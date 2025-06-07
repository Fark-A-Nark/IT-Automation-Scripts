## ----------------------------------------------------
## ~~~~~~~~~~ * ~~~~~  RUN AS ADMIN  ~~~~~ * ~~~~~~~~~~
## ----------------------------------------------------

# Start logging (optional)
Start-Transcript -Path "$env:USERPROFILE\Desktop\IRM-Setup-Log.txt" -Append

Write-Host "--------------------------------------------------"

# Set exeacution policy to remote signed to allow modules to install properly and allow use of said modules.
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

Write-Host "--------------------------------------------------"
Write-Host "Checking and installing required modules..." -ForegroundColor Cyan

# Ensure AIPService module is installed and imported
if (!(Get-Module -ListAvailable -Name AIPService)) {
    try {
        Install-Module -Name AIPService -Force
        Write-Host "AIPService Module installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "Failed to install AIPService Module: $_" -ForegroundColor Red
    }
}

# Import AIP Service
Write-Host "Importing AIPService..." -ForegroundColor Cyan
Import-Module AIPService -Force

# Ensure ExchangeOnlineManagement module is installed and imported
if (!(Get-Module -ListAvailable -Name ExchangeOnlineManagement)) {
    try {
        Install-Module -Name ExchangeOnlineManagement -RequiredVersion 3.7.1 -Force
        Write-Host "ExchangeOnlineManagement Module installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "Failed to install ExchangeOnlineManagement Module: $_" -ForegroundColor Red
    }
}

# Import AIP Service
Write-Host "Importing Exchange Online Management..." -ForegroundColor Cyan
Import-Module ExchangeOnlineManagement -Force

Write-Host "--------------------------------------------------"
Write-Host "Connecting to services..." -ForegroundColor Cyan

# Connect to Exchange Online
Write-Host "Connecting to Exchange Online..." -ForegroundColor Cyan
try {
    Connect-ExchangeOnline
    Write-Host "Connected to Exchange Online." -ForegroundColor Green
} catch {
    Write-Host "Failed to connect to Exchange Online: $_" -ForegroundColor Red
}

# Connect to AIPService
Write-Host "Connecting to AIP Service..." -ForegroundColor Cyan
try {
    Connect-AipService
    Write-Host "Connected to AIP Service." -ForegroundColor Green
} catch {
    Write-Host "Failed to connect to AIP Service: $_" -ForegroundColor Red
}

Write-Host "--------------------------------------------------"
Write-Host "Retrieving initial IRM configuration..." -ForegroundColor Cyan

# View current IRM settings
try {
    $initialConfig = Get-IRMConfiguration
    Write-Host "Initial IRM Configuration:" -ForegroundColor Green
    $initialConfig | Format-List
} catch {
    Write-Host "Failed to get IRM Configuration: $_" -ForegroundColor Red
}

Write-Host "--------------------------------------------------"
Write-Host "Configuring IRM and AIP settings..." -ForegroundColor Cyan

# Enable Azure RMS Licensing
try {
    Set-IRMConfiguration -AzureRMSLicensingEnabled $true
    Write-Host "Azure RMS Licensing enabled." -ForegroundColor Green
} catch {
    Write-Host "Failed to enable Azure RMS Licensing: $_" -ForegroundColor Red
}

# Set License URL and enable internal licensing
try {
    $RMSConfig = Get-AipServiceConfiguration
    $LicenseUri = $RMSConfig.LicensingIntranetDistributionPointUrl
    Set-IRMConfiguration -LicensingLocation $LicenseUri
    Set-IRMConfiguration -InternalLicensingEnabled $true
    Write-Host "License URL set and internal licensing enabled." -ForegroundColor Green
} catch {
    Write-Host "Failed to set License URL or enable internal licensing: $_" -ForegroundColor Red
}

# Enable AIP Service
Write-Host "Enabling AIP Service..." -ForegroundColor Cyan
try {
    Enable-AipService
    Write-Host "AIP Service enabled." -ForegroundColor Green
} catch {
    Write-Host "Failed to enable AIP Service: $_" -ForegroundColor Red
}

# Enable Protect button in Outlook on the web
Write-Host "Enabling Protect Button..." -ForegroundColor Cyan
try {
    Set-IRMConfiguration -SimplifiedClientAccessEnabled $true
    Write-Host "Protect button in Outlook on the web enabled." -ForegroundColor Green
} catch {
    Write-Host "Failed to enable Protect button: $_" -ForegroundColor Red
}

# Enable Encrypt-Only option
Write-Host "Enabling Encryption..." -ForegroundColor Cyan
try {
    Set-IRMConfiguration -SimplifiedClientAccessEncryptOnlyDisabled $false
    Write-Host "Encrypt-Only option enabled." -ForegroundColor Green
} catch {
    Write-Host "Failed to enable Encrypt-Only option: $_" -ForegroundColor Red
}

Write-Host "--------------------------------------------------"
Write-Host "Verifying updated IRM configuration..." -ForegroundColor Cyan

# Verify new IRM settings
try {
    $newConfig = Get-IRMConfiguration
    Write-Host "Updated IRM Configuration:" -ForegroundColor Green
    $newConfig | Format-List
} catch {
    Write-Host "Failed to verify IRM Configuration: $_" -ForegroundColor Red
}

Write-Host "--------------------------------------------------"
Write-Host "Testing IRM Configuration..." -ForegroundColor Cyan

# Prompt for sender and recipient email addresses
$senderEmail = Read-Host "Enter the sender's email address"
$recipientEmail = Read-Host "Enter the recipient's email address"

try {
    $testResult = Test-IRMConfiguration -Sender $senderEmail -Recipient $recipientEmail
    Write-Host "IRM Configuration test completed." -ForegroundColor Green
    $testResult | Format-List
} catch {
    Write-Host "Failed to test IRM Configuration: $_" -ForegroundColor Red
}

Write-Host "--------------------------------------------------"

# Return execution policy to restriced state (windows default)
Write-Host "Return execution policy to restricted" -ForegroundColor Cyan
Set-ExecutionPolicy Restricted -Scope CurrentUser

Write-Host "--------------------------------------------------"

# End logging
Stop-Transcript