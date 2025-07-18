# Get the current script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Set the working directory
Set-Location $scriptDir

# Define the installer name
$installer = "jre-8u461-windows-x64.exe"
$installerPath = Join-Path $scriptDir $installer

# Check if installer exists
if (-Not (Test-Path -Path $installerPath)) {
    Write-Output "Installer not found: $installerPath"
    exit 1
}

# Run the silent install
$process = Start-Process -FilePath $installerPath -ArgumentList "/s INSTALL_SILENT=Enable AUTO_UPDATE=Disable SPONSORS=0" -Wait -NoNewWindow -PassThru

# Check exit code of the installer
if ($process.ExitCode -eq 0) {
    Write-Output "Installation completed successfully."
    exit 0
} else {
    Write-Output "Installation failed with exit code $($process.ExitCode)"
    exit $process.ExitCode
}
