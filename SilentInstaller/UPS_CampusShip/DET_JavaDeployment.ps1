# Define expected paths
$javaExe = "C:\Program Files\Java\latest\jre-1.8\bin\java.exe"
$deploymentFolder = "C:\Windows\Sun\Java\Deployment"
$envVar = [Environment]::GetEnvironmentVariable("JAVA_HOME", [System.EnvironmentVariableTarget]::Machine)

# Check if Java is installed
if (Test-Path $javaExe) {
    Write-Host "✔ Java executable found at: $javaExe" -ForegroundColor Green
} else {
    Write-Host "❌ Java executable not found." -ForegroundColor Red
    exit 1
}

# Check if deployment folder and required files exist
$requiredFiles = @("deployment.config", "deployment.properties", "exception.sites")
$allFilesFound = $true

foreach ($file in $requiredFiles) {
    $filePath = Join-Path $deploymentFolder $file
    if (Test-Path $filePath) {
        Write-Host "✔ Found deployment file: $file" -ForegroundColor Green
    } else {
        Write-Host "❌ Missing deployment file: $file" -ForegroundColor Red
        $allFilesFound = $false
    }
}

if (-Not $allFilesFound) {
    exit 1
}

# Check if JAVA_HOME is set correctly
if ($envVar -eq "C:\Program Files\Java\latest\jre-1.8") {
    Write-Host "✔ JAVA_HOME is set correctly." -ForegroundColor Green
} else {
    Write-Host "❌ JAVA_HOME is not set correctly. Current value: $envVar" -ForegroundColor Red
    exit 1
}

# All checks passed
Write-Host "✅ Java 8 deployment detected successfully." -ForegroundColor Green
exit 0
