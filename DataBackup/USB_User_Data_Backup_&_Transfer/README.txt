User Data Migration Script

This batch script is designed to quickly and efficiently pull essential user data from a Windows machine in preparation for migration to a new device. It focuses on the most commonly needed files to help users in an enterprise setting get up and running with minimal disruption. It is expected the old computer will still be avaliable to grab any missing files. 

>>>> ⚠️ This is not a full 1:1 backup. It's not intended for disaster recovery. Always maintain your own backups. Do not rely solely on this tool. ⚠️ <<<<


------ What It Does ------

- Creates a structured backup folder on the same USB drive the script is run from.
- Copies key user folders:
  - Desktop
  - Documents
  - Downloads
  - Outlook Signatures
  - OneDrive folders (if applicable)
- Backs up browser data:
  - Chrome (bookmarks, preferences, login data)
  - Edge (entire user profile)
  - Firefox (profiles and settings)
- Includes shortcut for quick access to restored locations on the new device.


------ How to Use ------

USB Setup

  1. Place the "Backups" folder and all of it's contents in the **root** of your USB flash drive.


Scripted Backup

  1. Plug the USB into the source computer (the old computer you want to pull data from).
  2. Navigate to:  
     "Backups\Backup_Tools\Backup User Profiles\"
  3. Double-click the script "Backup_v05.bat" to run it.
  4. When prompted:
     - Enter the **drive letter** of the USB (e.g., "E" or "D")
     - Enter the **username** (must match the user folder; used to identify the correct user's data and name the backup folder)
     - Enter the **OneDrive folder name** (e.g., "OneDrive - Company Name")
  5. The script will create a backup folder and begin copying data.
  6. OneDrive data is copied last. You may press Ctrl-C to cancel this step if it's not needed (e.g., if the user has already synced their OneDrive or if the data is redundant).


VHD Backup

Disk2vhd is a tool develouped by MS please use their documetation to learn proper use of this software.
https://learn.microsoft.com/en-us/sysinternals/downloads/disk2vhd

  1. Plug the USB into the source computer (the old computer you want to pull data from).
  2. Navigate to:  
     "Backups\Backup_Tools\Disk2vhd"
  3. Run the appropriate "disk2vhd.exe" file to launch.
  4. Use the included tool to create a full VHD image of the system drive.
  5. Save the file to:  
     "Backups\Backups_VHD"


------ Folder Structure Example ------

E:\Backups\Backups_Scripted\jdoe_2025-06-06
├── Desktop 
├── Documents 
├── Downloads 
├── Signatures 
├── Browsers 
│ ├── Chrome 
│ ├── Edge 
│ └── Firefox 
├── Desktop (OneDrive) 
└── Documents (OneDrive)


------ Requirements ------

- Windows 10 or later
- USB drive with sufficient space


------ Why Use This? ------

- Faster than full system imaging
- Focuses on what users actually need
- Great for IT teams migrating users to managed environments


----- Notes ------

- This script does **not** back up installed applications or application configurations.
- This script does **not** back up Windows settings or configurations.
- This script does **not** back up ProgramData folders.
- This script does **not** back up AppData in its entirety.
- You can pair this with a VHD backup for full data capture. Store VHDs in:  
  "Backups\Backups_VHD"
- If manually backing up the entire user folder, store it in:  
  "Backups\Backups_Manual"
- A restore script can be created to automate copying data to the new machine.
- It is intended to someday write a "put back" script for restoring the backed-up data to the new machine, but for now that is a manual process.
