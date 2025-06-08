# Define the registry path
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI"

# List of registry values to clear
$valuesToClear = @(
    "LastLoggedOnDisplayName",
    "LastLoggedOnUser",
    "LastLoggedOnSAMUser",
    "LastLoggedOnUserSID",
    "SelectedUserSID"
    "LastLoggedOnProvider"
)

# Clear each registry value
foreach ($value in $valuesToClear) {
    Remove-ItemProperty -Path $regPath -Name $value -ErrorAction SilentlyContinue
}

Write-Output "Specified registry values have been cleared."