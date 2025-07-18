# Define path for new directory
$path = "C:\Windows\Sun\Java\Deployment"

# Check if directory exists and create it
if (-Not (Test-Path -Path $path)) {
    New-Item -ItemType Directory -Path $path -Force
    Write-Output "Created folder: $path"
} else {
    Write-Output "Folder already exists: $path"
}

# Define source path (where Intune extracts the package)
$sourcePath = Split-Path -Parent $MyInvocation.MyCommand.Definition
# List of files to copy
$files = @("deployment.config", "deployment.properties", "exception.sites")

$missingFiles = $false

# Copy each file to the target directory
foreach ($file in $files) {
    $sourceFile = Join-Path -Path $sourcePath -ChildPath $file
    $destinationFile = Join-Path -Path $path -ChildPath $file

    if (Test-Path -Path $sourceFile) {
        Copy-Item -Path $sourceFile -Destination $destinationFile -Force
        Write-Output "Copied $file to $path"
    } else {
        Write-Output "File not found: $sourceFile"
        $missingFiles = $true
    }
}

if ($missingFiles) {
    exit 1  # Exit with error if any file was missing
} else {
    exit 0  # Success
}
