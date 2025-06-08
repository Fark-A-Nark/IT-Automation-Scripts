# Check if Print Management Console is installed
Get-WindowsCapability -Name Print.Management.Console -Online

# Install Print Management Console (if not already installed)
Add-WindowsCapability -Online -Name Print.Management.Console