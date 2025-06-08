This PowerShell script is used to prepare a Windows computer for a new user by clearing out any traces of previous logins. This ensures that when the new user receives the device, they are presented with a clear login screen—no with stored usernames or accounts to choose from, they do not need to understand how to use the "other user" feature to log in.




------ What it does ------

Targets a specific registry path:

	HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI

Defines a list of registry values to remove:

	LastLoggedOnDisplayName
	LastLoggedOnUser
	LastLoggedOnSAMUser
	LastLoggedOnUserSID
	SelectedUserSID
	LastLoggedOnProvider

Loops through each value and deletes it from the registry using Remove-ItemProperty.

Outputs a confirmation message once the values are cleared.