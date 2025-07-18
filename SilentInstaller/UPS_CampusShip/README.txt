# Java 8 SE Runtime Environment Deployment

--------------------------------------------------------------

## 📦 Overview
This package installs Java 8 SE Runtime Environment (v461) silently. 
Creates and places configures deployment settings in the correct location. 
Sets system environment variables. 

It is intended for deployment via Microsoft Intune using the Win32 App package created using the Microsoft Win32 Content Prep Tool (IntuneWinAppUtil.exe) 

It also includes a custom detection script and uninstaller. 

--------------------------------------------------------------

## 📁 Package Contents

Scripts:

	00_Run.ps1
		– Master script that runs all others in order.
	01_Create-JavaDeploymentFolder_v01.ps1
		– Creates the deployment folder and copies config files.
	02_Install-Java8-Silent_v01.ps1
		– Installs Java 8 silently with custom options.
	03_Set-JavaEnvVars_v01.ps1
		– Sets JAVA_HOME and updates the system PATH.
	04_Install-ThermalPaper_v01.ps1
		– Currently Empty - Planned to install UPS Thermal Paper support App


Dependencies:
	deployment.config
	deployment.properties
	exception.sites
	jre-8u461-windows-x64.exe



Other Files:

	README.txt
	Noted.txt


--------------------------------------------------------------


## 🚀 Intune Deployment Instructions

1. Wrap the package using the [Microsoft Win32 Content Prep Tool](https://learn.microsoft.com/en-us/intune/intune-service/apps/apps-win32-prepare)
2. Upload to Intune as a Win32 app:
	Install command: powershell.exe -ExecutionPolicy Bypass -File .\00_Run.ps1
	Uninstall command: (Optional, if needed)
	Install behavior: System
	Requirements: Windows 10/11, 64-bit
	Detection rule: File exists
	Path: C:\Program Files\Java\latest\jre-1.8\bin
	File: java.exe

--------------------------------------------------------------

## 🛠️ Notes

The deployment folder is created at: C:\Windows\Sun\Java\Deployment
JAVA_HOME is set to: C:\Program Files\Java\latest\jre-1.8
%JAVA_HOME%\bin is appended to the system PATH if not already present.
Auto-updates and sponsor offers are disabled during installation.

--------------------------------------------------------------

##❗ Troubleshooting

Ensure all files are present in the source folder before wrapping.
Check Intune logs (IntuneManagementExtension.log) for deployment issues.
If any script fails, the master script will exit with an error code.
No built in logging.

--------------------------------------------------------------
