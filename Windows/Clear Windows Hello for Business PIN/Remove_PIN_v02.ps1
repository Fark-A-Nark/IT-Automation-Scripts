﻿# Delete NGC folder for Current User
Start-Process cmd -ArgumentList '/s,/c,takeown /f C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\NGC /r /d y & icacls C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\NGC /grant administrators:F /t & RD /S /Q C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc & MD C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc & icacls C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc /T /Q /C /RESET' -Verb runAs

# Create the PassportForWork Key if it doesn't exist
$regPath = 'HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork'
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath
}

# Enable security key sign-in (optional)
New-ItemProperty -Path $regPath -Name 'UseSecurityKeyForSignIn' -Value 1 -PropertyType DWORD -Force

# Disable Windows Hello for Business
New-ItemProperty -Path $regPath -Name 'Enabled' -Value 0 -PropertyType DWORD -Force