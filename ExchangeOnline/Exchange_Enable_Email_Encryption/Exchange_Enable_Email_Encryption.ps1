Write-Host "--------------------------------------------------"
Write-Host " "
Write-Host "Script Starting"
Write-Host "Enabling Exchange Encryption"
Write-Host " "
Write-Host "--------------------------------------------------"

## Check if AIPService Module is installed
if (!(Get-Module -ListAvailable -Name AIPService)) {
    try {
        Install-Module -Name AIPService -Force
        Write-Host "AIPService Module installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "Failed to install AIPService Module: $_" -ForegroundColor Red
    }
} else {
    Write-Host "AIPService Module is already installed." -ForegroundColor Yellow
}

## Check if AIPService Module is imported
if (!(Get-Module -Name AIPService)) {
    try {
        Import-Module AIPService
        Write-Host "AIPService Module imported successfully." -ForegroundColor Green
    } catch {
        Write-Host "Failed to import AIPService Module: $_" -ForegroundColor Red
    }
} else {
    Write-Host "AIPService Module is already imported." -ForegroundColor Yellow
}

Write-Host "--------------------------------------------------"

## Check if already connected to Exchange Online
if (!(Get-Module -ListAvailable -Name ExchangeOnlineManagement)) {
    try {
        Connect-ExchangeOnline
        Write-Host "Connected to Exchange Online." -ForegroundColor Green
    } catch {
        Write-Host "Failed to connect to Exchange Online: $_" -ForegroundColor Red
    }
} else {
    Write-Host "Already connected to Exchange Online." -ForegroundColor Yellow
}

## Check if already connected to AIPService
if (!(Get-Module -ListAvailable -Name AIPService)) {
    try {
        Connect-AipService
        Write-Host "Connected to AIPService." -ForegroundColor Green
    } catch {
        Write-Host "Failed to connect to AIPService: $_" -ForegroundColor Red
    }
} else {
    Write-Host "Already connected to AIPService." -ForegroundColor Yellow
}

Write-Host "--------------------------------------------------"

## View initial IRM settings
try {
    $initialConfig = Get-IRMConfiguration
    Write-Host "Initial IRM Configuration." -ForegroundColor Green
    Write-Host "IRM Results:" -ForegroundColor Cyan
    $initialConfig | Format-List
} catch {
    Write-Host "Failed to get IRM Configuration: $_" -ForegroundColor Red
}

Write-Host "--------------------------------------------------"
Write-Host "Enabling the following settings"
Write-Host " "

## Enable Azure RMS Licensing
try {
    Set-IRMConfiguration -AzureRMSLicensingEnabled $true
    Write-Host "Azure RMS Licensing enabled." -ForegroundColor Green
} catch {
    Write-Host "Failed to enable Azure RMS Licensing: $_" -ForegroundColor Red
}

## Set License URL, Enable Licensing Location, Enable Internal Licensing
try {
    $RMSConfig = Get-AipServiceConfiguration
    $LicenseUri = $RMSConfig.LicensingIntranetDistributionPointUrl
    Set-IRMConfiguration -LicensingLocation $LicenseUri
    Set-IRMConfiguration -InternalLicensingEnabled $true
    Write-Host "License URL set and internal licensing enabled." -ForegroundColor Green
} catch {
    Write-Host "Failed to set License URL or enable internal licensing: $_" -ForegroundColor Red
}

## Enable AIP Service
try {
    Enable-AipService
    Write-Host "AipService enabled." -ForegroundColor Green
} catch {
    Write-Host "Failed to enable AipService: $_" -ForegroundColor Red
}

## Enable the Protect button in Outlook on the web (Optional)
try {
    Set-IRMConfiguration -SimplifiedClientAccessEnabled $true
    Write-Host "Protect button in Outlook on the web enabled." -ForegroundColor Green
} catch {
    Write-Host "Failed to enable Protect button in Outlook on the web: $_" -ForegroundColor Red
}

## Enable the "Encrypt-Only" option in the simplified client access settings
try {
    Set-IRMConfiguration -SimplifiedClientAccessEncryptOnlyDisabled $false
    Write-Host "Encrypt-Only option enabled." -ForegroundColor Green
} catch {
    Write-Host "Failed to enable Encrypt-Only option: $_" -ForegroundColor Red
}

Write-Host "--------------------------------------------------"

## Verify new IRM settings
try {
    $newConfig = Get-IRMConfiguration
    Write-Host "Updated IRM Configuration." -ForegroundColor Green
    Write-Host "IRM Results:" -ForegroundColor Cyan
    $newConfig | Format-List
} catch {
    Write-Host "Failed to verify IRM Configuration: $_" -ForegroundColor Red
}

Write-Host "--------------------------------------------------"

## Test Configuration
## Prompt for sender and recipient email addresses
$senderEmail = Read-Host "Enter the sender's email address"
$recipientEmail = Read-Host "Enter the recipient's email address"

Write-Host "--------------------------------------------------"
Write-Host "Testing IRM Configuration"
Write-Host "Sender: $senderEmail"
Write-Host "Recipient: $recipientEmail"

try {
    $testResult = Test-IRMConfiguration -Sender $senderEmail -Recipient $recipientEmail
    Write-Host "IRM Configuration test completed." -ForegroundColor Green
    Write-Host "Test Results:" -ForegroundColor Cyan
    $testResult | Format-List
} catch {
Write-Host "Failed to test IRM Configuration: $_" -ForegroundColor Red
}
Write-Host "--------------------------------------------------"
