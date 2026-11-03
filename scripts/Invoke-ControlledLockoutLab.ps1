#Requires -RunAsAdministrator
#Requires -Modules ActiveDirectory

<#
.SYNOPSIS
Runs one bounded account-lockout scenario in the fictional bluevale.test lab.

.DESCRIPTION
Creates one temporary fictional user, adds it only to GG-Employees, performs
exactly the configured five invalid credential checks, verifies lockout,
unlocks the account, and leaves it disabled for evidence review.

The script refuses to run outside AD-DC01 / bluevale.test, never prints the
runtime-generated account password, and always disables the account in its
cleanup path. IR-001 predates this committed helper and was produced by an
equivalent one-off launcher; this file is the reviewed reproduction version.
#>

[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory)]
    [switch]$Execute
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not $Execute) {
    throw 'Refusing to run without -Execute.'
}

$expectedDomain = 'bluevale.test'
$expectedComputer = 'AD-DC01'
$expectedThreshold = 5
$domain = Get-ADDomain

if ($domain.DNSRoot -ne $expectedDomain) {
    throw "Safety check failed: expected domain $expectedDomain."
}

if ($env:COMPUTERNAME -ne $expectedComputer) {
    throw "Safety check failed: expected computer $expectedComputer."
}

$policy = Get-ADDefaultDomainPasswordPolicy
if ([int]$policy.LockoutThreshold -ne $expectedThreshold) {
    throw "Safety check failed: expected lockout threshold $expectedThreshold."
}

$userOu = Get-ADOrganizationalUnit -Filter "Name -eq 'Lab Users'" |
    Select-Object -First 1
$employeeGroup = Get-ADGroup -Identity 'GG-Employees'

if (-not $userOu -or -not $employeeGroup) {
    throw 'Required fictional OU or unprivileged group was not found.'
}

$started = Get-Date
$marker = 'BLV-AUTH-{0}' -f $started.ToString('yyyyMMdd-HHmmss')
$samAccountName = 'blvlock-{0}' -f $started.ToString('MMddHHmmss')
$displayName = "Controlled Lockout $($started.ToString('yyyyMMdd-HHmmss'))"
$created = $false
$correctPassword = $null
$securePassword = $null
$principalContext = $null
$bytes = $null

try {
    $bytes = New-Object byte[] 18
    $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $rng.GetBytes($bytes)
    $rng.Dispose()
    $correctPassword = 'Bv!' + [Convert]::ToBase64String($bytes)
    $securePassword = ConvertTo-SecureString $correctPassword -AsPlainText -Force

    if (-not $PSCmdlet.ShouldProcess(
            "$samAccountName in $expectedDomain",
            'Create, test lockout, unlock, and disable fictional account')) {
        return
    }

    New-ADUser `
        -Name $displayName `
        -SamAccountName $samAccountName `
        -UserPrincipalName "$samAccountName@$expectedDomain" `
        -Path $userOu.DistinguishedName `
        -AccountPassword $securePassword `
        -Enabled $true `
        -Description $marker
    $created = $true

    Add-ADGroupMember -Identity $employeeGroup -Members $samAccountName

    Add-Type -AssemblyName System.DirectoryServices.AccountManagement
    $principalContext = New-Object `
        -TypeName System.DirectoryServices.AccountManagement.PrincipalContext `
        -ArgumentList @(
            [System.DirectoryServices.AccountManagement.ContextType]::Domain,
            $expectedDomain
        )

    for ($attempt = 1; $attempt -le $expectedThreshold; $attempt++) {
        $null = $principalContext.ValidateCredentials(
            $samAccountName,
            'Definitely-Wrong-Lab-Password!'
        )
        Start-Sleep -Milliseconds 600
    }

    $account = Get-ADUser -Identity $samAccountName -Properties LockedOut
    if (-not $account.LockedOut) {
        throw 'Expected lockout was not observed after the bounded attempts.'
    }

    $lockoutObserved = Get-Date
    Unlock-ADAccount -Identity $samAccountName
    $unlockVerified = -not (Get-ADUser -Identity $samAccountName -Properties LockedOut).LockedOut
    if (-not $unlockVerified) {
        throw 'Account unlock verification failed.'
    }

    Disable-ADAccount -Identity $samAccountName
    $finalAccount = Get-ADUser -Identity $samAccountName -Properties Enabled
    if ($finalAccount.Enabled) {
        throw 'Cleanup verification failed: account is still enabled.'
    }

    Start-Sleep -Seconds 2
    $eventIds = 4625, 4720, 4725, 4728, 4740, 4767
    $events = Get-WinEvent -FilterHashtable @{
        LogName = 'Security'
        Id = $eventIds
        StartTime = $started.AddSeconds(-5)
    } | Where-Object Message -Match ([regex]::Escape($samAccountName))

    $counts = foreach ($eventId in $eventIds) {
        [pscustomobject]@{
            EventId = $eventId
            Count = @($events | Where-Object Id -EQ $eventId).Count
        }
    }

    [pscustomobject]@{
        Marker = $marker
        TestAccount = $samAccountName
        StartTime = $started.ToString('o')
        LockoutObserved = $lockoutObserved.ToString('o')
        BoundedFailedAttempts = $expectedThreshold
        UnlockVerified = $unlockVerified
        FinalAccountState = 'disabled'
        SecurityEventCounts = $counts
    }
}
finally {
    if ($principalContext) {
        $principalContext.Dispose()
    }

    if ($created) {
        $existing = Get-ADUser -Identity $samAccountName -Properties Enabled -ErrorAction SilentlyContinue
        if ($existing -and $existing.Enabled) {
            Disable-ADAccount -Identity $samAccountName -Confirm:$false
        }
    }

    $correctPassword = $null
    $securePassword = $null
    if ($bytes) {
        [Array]::Clear($bytes, 0, $bytes.Length)
    }
}

