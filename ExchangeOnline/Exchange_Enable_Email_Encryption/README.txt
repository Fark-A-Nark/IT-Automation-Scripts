This script will configure the MS Tenant Exchange Online and Azure Information Protection settings to enable basic email encryption. 

You must run the script as admin.

If you are using a version of ExchangeOnlineManagement other then 3.7.1, the script may fail or error out.
If this is the case you will want to remove the existing version using this command:

	Uninstall-Module ExchangeOnlineManagement -AllVersions -Force



--------------------------------------------------------
Script Summary

Installs the following PowerShell modules (if missing):
	ExchangeOnlineManagement – for managing Exchange Online
	AIPService – for Azure Information Protection
	
Connects to:
	Exchange Online
	Azure Information Protection (AIP)

Enables and configures:
	Azure Rights Management (RMS) licensing
	Internal licensing and licensing location
	AIP service activation
	Protect button in Outlook on the Web
	Encrypt-Only option for email

Verifies and tests:
	IRM (Information Rights Management) settings
	Email protection between sender and recipient

--------------------------------------------------------
On a base level this script uses the following scripts to set the to configure email encryption.

Enable-AipService
Set-IRMConfiguration -AzureRMSLicensingEnabled $true
Set-IRMConfiguration -LicensingLocation $LicenseUri
Set-IRMConfiguration -InternalLicensingEnabled $true
Set-IRMConfiguration -SimplifiedClientAccessEnabled $true
Set-IRMConfiguration -SimplifiedClientAccessEncryptOnlyDisabled $false

--------------------------------------------------------
Operating System
	Windows 11
	Version 24H2 (OS Build 26100.3624)


PowerShell Version

Major  Minor  Build  Revision
-----  -----  -----  --------
5      1      26100  3624



