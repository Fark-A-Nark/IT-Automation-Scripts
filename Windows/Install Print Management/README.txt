# Print Management Console Installer

This PowerShell script checks for the presence of the Print Management Console feature on a Windows system and installs it if it is not already installed.


------ What It Does ------

1. Checks the installation status of the Print.Management.Console capability.
2. Installs the capability if it is not already present.


------ Usage ------

Open PowerShell as Administrator and run the following commands:


# Check if Print Management Console is installed
Get-WindowsCapability -Name Print.Management.Console -Online

# Install Print Management Console (if not already installed)
Add-WindowsCapability -Online -Name Print.Management.Console
