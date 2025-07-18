# Stop on errors
$ErrorActionPreference = "Stop"

# Uninstall Java 8 using known GUID
$JavaGUID = "{71124AE4-039E-4CA4-87B4-2F64180461F0}"
Write-Output "Attempting to uninstall Java 8 using GUID: $JavaGUID"
Start-Process "msiexec.exe" -ArgumentList "/x $JavaGUID /qn" -Wait -NoNewWindow
Write-Output "Java 8 uninstalled using GUID."

# Remove the Sun folder
$sunFolder = "C:\Windows\Sun"
if (Test-Path $sunFolder) {
    Remove-Item -Path $sunFolder -Recurse -Force
    Write-Output "Removed folder: $sunFolder"
} else {
    Write-Output "Sun folder not found: $sunFolder"
}

# Remove JAVA_HOME environment variable
[Environment]::SetEnvironmentVariable("JAVA_HOME", $null, [System.EnvironmentVariableTarget]::Machine)
Write-Output "JAVA_HOME environment variable removed."

# Clean up system PATH
$path = [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
$filteredPath = ($path -split ";") | Where-Object {
    $_ -notmatch "Java\\latest\\jre-1.8\\bin" -and $_ -ne "%JAVA_HOME%\bin"
}
$newPath = ($filteredPath -join ";")
[Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
Write-Output "System PATH cleaned up."

exit 0
