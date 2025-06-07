# 🧳 User Data Migration Script

This batch script is designed to **quickly and efficiently migrate essential user data** from machine to machine. It focuses on the most commonly requested files and settings to help users get up and running with minimal disruption.

---

## 📦 What It Does

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
- Includes shortcut files for quick access to restored locations on the new device.

---

## 🚀 How to Use

### 🔹 USB Setup

1. Place the `Backups` folder in the **root** of your USB flash drive.


### 🔹 Scripted Backup

1. Plug the USB into the old **source computer**.
2. Navigate to:  
   `Backups\Backup_Tools\Backup User Profiles`
3. Double-click the script to run it.
4. When prompted:
   - Enter the **drive letter** of the USB (e.g., `E`)
   - Enter the **username** (used to identify the user's data and name the backup folder)
   - Enter the **OneDrive folder name** (e.g., `OneDrive - Company Name`)
5. The script will create a backup folder and begin copying data.
6. OneDrive data is last, feel free to Ctrl-C to terminate the back up if you don't want that data.


### 🔹 VHD Backup

Navigate to:  
`Backups\Backup_Tools\Disk2vhd`  
Use the included tool to create a full VHD image of the system drive.


---

## 📁 Folder Structure Example
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

---

## 🛠 Requirements

- Windows 10 or later
- USB drive with sufficient space

---

## ✅ Why Use This?

- Faster than full system imaging
- Focuses on what users actually need
- Great for IT teams migrating users to managed environments

---

## 📌 Notes

- This script does **not** back up installed applications or system settings.
- You can pair this with a VHD backup for full data capture. Store VHDs in:  
  `E:\Backups\Backups_VHD`
- If manually backing up the entire user folder, store it in:  
  `E:\Backups\Backups_Manual`
- A restore script can be created to automate copying data to the new machine.


---

## 📄 License

MIT License — feel free to use and modify.




