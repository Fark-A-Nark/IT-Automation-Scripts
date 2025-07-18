# Ensure the script stops on errors
$ErrorActionPreference = "Stop"

# Get the current script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Run Script 1
& "$scriptDir\01_Create-JavaDeploymentFolder_v01.ps1"
if (-not $?) { Write-Error "Script 1 failed"; exit 1 }

# Run Script 2
& "$scriptDir\02_Install-Java8-Silent_v01.ps1"
if (-not $?) { Write-Error "Script 2 failed"; exit 1 }

# Run Script 3
& "$scriptDir\03_Set-JavaEnvVars_v01.ps1"
if (-not $?) { Write-Error "Script 3 failed"; exit 1 }
