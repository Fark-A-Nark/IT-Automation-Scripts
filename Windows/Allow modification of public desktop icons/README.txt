PowerShell Script: Grant Modify Access to Authenticated Users

Overview
This PowerShell script modifies the access control settings (ACL) of the C:\Users\Public\Desktop folder to grant Modify permissions to the Authenticated Users group. This change applies to the folder itself as well as all its subfolders and files.


Script explanation

	Specifies the target folder whose permissions will be modified.
	Get Current ACL
	Retrieves the current access control list (ACL) for the folder.
	Define the User Group
	Creates a security identifier (SID) for the Authenticated Users group.


About S-1-5-11
	This is a well-known SID in Windows.
	Represents the Authenticated Users group.
	Includes all users who have successfully logged in with valid credentials.
	Excludes anonymous and guest users.
	Commonly used to grant access to any legitimate user without specifying individual accounts.
	

Create Access Rule
	Creates a rule that grants Modify permissions to Authenticated Users. The rule applies to the folder and all its subfolders and files.
	Apply and Save the Rule
	Adds the new rule to the ACL and applies the updated ACL to the folder.


Summary
This script is useful for system administrators who want to ensure that all authenticated users have modify access to a shared folder, such as the public desktop, without granting access to anonymous or guest users. Primarily created to allow users to delete desktop icons on computers with onlu one user.