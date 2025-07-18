# Define the name of the environment variable
$envName = "JAVA_HOME"
$envValue = "C:\Program Files\Java\latest\jre-1.8"

# Check if the path exists
if (-Not (Test-Path -Path $envValue)) {
    Write-Output "Java path does not exist: $envValue"
    exit 1
}

# Set the environment variable system-wide
[Environment]::SetEnvironmentVariable($envName, $envValue, [System.EnvironmentVariableTarget]::Machine)

# Update PATH if needed
$existingPath = [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)

if ($existingPath -notlike "*%JAVA_HOME%\bin*") {
    $newPath = "$existingPath;%JAVA_HOME%\bin"
    [Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
    Write-Output "Updated system PATH to include JAVA_HOME\bin"
}

Write-Output "JAVA_HOME set successfully."
exit 0
