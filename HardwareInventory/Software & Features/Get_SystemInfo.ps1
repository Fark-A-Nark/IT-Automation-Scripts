# Self-elevate the script if not running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Export Windows Optional Features
$FeaturesPath = Join-Path -Path $PSScriptRoot -ChildPath "Features.csv"
Get-WindowsOptionalFeature -Online | Select-Object * | Export-Csv -Path $FeaturesPath -NoTypeInformation

# Export Installed Software (Warning: Win32_Product may trigger MSI reconfigurations)
$SoftwarePath = Join-Path -Path $PSScriptRoot -ChildPath "Software.csv"
Get-WmiObject -Class Win32_Product | Export-Csv -Path $SoftwarePath -NoTypeInformation

# Export Windows Capabilities
$CapabilityPath = Join-Path -Path $PSScriptRoot -ChildPath "Capability.csv"
Get-WindowsCapability -Online | Export-Csv -Path $CapabilityPath -NoTypeInformation