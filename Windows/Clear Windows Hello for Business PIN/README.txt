# Windows Hello for Business Reset Script

## Overview

This PowerShell script is designed to reset Windows Hello for Business (WHfB) (Passport for Work) settings by deleting the NGC folder and modifying registry keys to disable WHfB and optionally enable security key sign-in.

## Purpose

- Remove the NGC folder, which stores PIN-related data for Windows Hello.
- Disable Windows Hello for Business via registry settings.
- Optionally enable security key sign-in.

## Prerequisites

- Must be run with Administrator privileges.
- Applicable to Windows systems using Windows Hello for Business.
- Ensure no critical data is stored in the NGC folder before deletion.


## Warnings
This script will permanently delete the NGC folder, which may remove existing PIN sign-in configurations.
Ensure that this action aligns with your organization's security policies.
Improper use of registry modifications can affect system behavior. Always back up the registry before making changes.