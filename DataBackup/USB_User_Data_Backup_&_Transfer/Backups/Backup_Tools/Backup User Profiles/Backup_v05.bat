@cd /d "%~dp0"
@ECHO off
setlocal enabledelayedexpansion

REM --------------------------------------------------------
REM Get today's date in YYYY-MM-DD format using PowerShell
for /f %%a in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd"') do set "todays_date=%%a"

REM --------------------------------------------------------

REM Prompt for user input
set /p "Input1=Export Drive letter?: "
set /p "Input2=Username?: "
set /p "Input3=OneDrive Folder Name (OneDrive - Company Name): "

REM Create folder structure with today's date
set "backup_folder=%Input1%:\Backups\Backups_Scripted\%Input2%_%todays_date%"
mkdir "!backup_folder!\Signatures"
mkdir "!backup_folder!\Browsers\Chrome\User Data\Default"
mkdir "!backup_folder!\Browsers\Firefox"
mkdir "!backup_folder!\Browsers\Edge"
mkdir "!backup_folder!\Desktop"
mkdir "!backup_folder!\Documents"
mkdir "!backup_folder!\Downloads"
mkdir "!backup_folder!\Desktop (OneDrive)"
mkdir "!backup_folder!\Documents (OneDrive)"

REM --------------------------------------------------------

echo Creating Shortcuts
Xcopy "Shortcuts\Desktop - Shortcut.lnk" "!backup_folder!\" /e /i /c
Xcopy "Shortcuts\Documents - Shortcut.lnk" "!backup_folder!\" /e /i /c
Xcopy "Shortcuts\Signatures - Shortcut.lnk" "!backup_folder!\" /e /i /c
Xcopy "Shortcuts\ChromeDefault - Shortcut.lnk" "!backup_folder!\" /e /i /c
Xcopy "Shortcuts\EdgeDefault - Shortcut.lnk" "!backup_folder!\" /e /i /c

echo.
TIMEOUT /T 2
echo.

REM ------------   Browsers   ------------
echo Copy Edge (User Data folder)
Xcopy "%LocalAppData%\Microsoft\Edge\User Data" "!backup_folder!\Browsers\Edge\" /e /i /c

echo Copy Chrome (Specific Data)
Xcopy "%LocalAppData%\Google\Chrome\User Data\Default\Bookmarks" "!backup_folder!\Browsers\Chrome\User Data\Default\" /i /c
Xcopy "%LocalAppData%\Google\Chrome\User Data\Default\Bookmarks.dat" "!backup_folder!\Browsers\Chrome\User Data\Default\" /i /c
Xcopy "%LocalAppData%\Google\Chrome\User Data\Default\Preferences" "!backup_folder!\Browsers\Chrome\User Data\Default\" /i /c
Xcopy "%LocalAppData%\Google\Chrome\User Data\Default\Login Data" "!backup_folder!\Browsers\Chrome\User Data\Default\" /i /c
Xcopy "%LocalAppData%\Google\Chrome\User Data\Default\Login Data For Account" "!backup_folder!\Browsers\Chrome\User Data\Default\" /i /c
Xcopy "%LocalAppData%\Google\Chrome\User Data\Default\Login Data For Account-journal" "!backup_folder!\Browsers\Chrome\User Data\Default\" /i /c
Xcopy "%LocalAppData%\Google\Chrome\User Data\Default\Login Data-journal" "!backup_folder!\Browsers\Chrome\User Data\Default\" /i /c

echo Firefox (Default Folder)
Xcopy "%APPDATA%\Mozilla\Firefox\Profiles\" "!backup_folder!\Browsers\Firefox\Profiles\" /e /i /c
Xcopy "%APPDATA%\Mozilla\Firefox\profiles.ini" "!backup_folder!\Browsers\Firefox\" /i /c

TIMEOUT /T 3

REM ------------   User Data   ------------
echo Copy Outlook Signatures
Xcopy "%AppData%\Microsoft\Signatures\" "!backup_folder!\Signatures" /e /i /c

TIMEOUT /T 3

REM ------------   User Folders   ------------
echo Copy Desktop Folder Local
Xcopy "%USERPROFILE%\Desktop\" "!backup_folder!\Desktop" /e /i /c

echo Copy Documents Folder Local
Xcopy "%USERPROFILE%\Documents\" "!backup_folder!\Documents" /e /i /c

echo Copy Downloads Folder Local
Xcopy "%USERPROFILE%\Downloads\" "!backup_folder!\Downloads" /e /i /c

TIMEOUT /T 3

REM ------------   User OneDrive (Optional)  ------------
echo Copy Desktop Folder (OneDrive)
Xcopy "%USERPROFILE%\%Input3%\Desktop\" "!backup_folder!\Desktop (OneDrive)" /e /i /c

echo Copy Documents Folder (OneDrive)
Xcopy "%USERPROFILE%\%Input3%\Documents\" "!backup_folder!\Documents (OneDrive)" /e /i /c

Pause
Exit
