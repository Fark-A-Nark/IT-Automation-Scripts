Assumes 
Windows PowerShell 5.1 
Set-ExecutionPolicy RemoteSigned
Uninstall-Module ExchangeOnlineManagement -AllVersions -Force
Install-Module -Name ExchangeOnlineManagement -RequiredVersion 3.7.1 -Force