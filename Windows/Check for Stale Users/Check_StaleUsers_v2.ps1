# Define the number of days to check for old profiles
$days = 30

# Define the accounts to exclude from the check
$excludedAccounts = @("Administrator", "Guest", "DefaultAccount", "WDAGUtilityAccount")

# Get the current date and time
$currentDate = Get-Date

# Retrieve all user profiles, excluding special system profiles
$userProfiles = Get-WmiObject -Class Win32_UserProfile | Where-Object { $_.Special -eq $false }

# Initialize a list to store profile information
$profileInfoList = @()
$profilesForDeletion = @()

# Iterate through each user profile
foreach ($profile in $userProfiles) {
    try {
        # Extract the username from the profile's local path
        $username = $profile.LocalPath.Split("\")[-1]

        # Check if the LastUseTime property is not null or empty
        if ($profile.LastUseTime) {
            # Convert the LastUseTime from WMI format to a DateTime object
            $lastUseTime = [Management.ManagementDateTimeConverter]::ToDateTime($profile.LastUseTime)

            # Calculate the age of the profile in days
            $profileAge = ($currentDate - $lastUseTime).Days

            # Check if the profile is older than the specified number of days and not in the excluded accounts
            if (-not $excludedAccounts.Contains($username)) {
                # Determine if the profile is older than the specified number of days
                $isOlderThanXDays = if ($profileAge -gt $days) { "False" } else { "True" }

                # Determine if the profile is scheduled for deletion
                $scheduledForDeletion = if ($profileAge -gt $days) { "Yes" } else { "No" }

                # Create a custom object with the profile information
                $profileInfo = [PSCustomObject]@{
                    "Profile Name"             = $username
                    "Last Log-In Date"         = $lastUseTime
                    "Recent Log-in ($days days)" = $isOlderThanXDays
                    "Scheduled for Deletion"   = $scheduledForDeletion
                }

                # Add the custom object to the list
                $profileInfoList += $profileInfo

                # Add to deletion list if scheduled for deletion
                if ($scheduledForDeletion -eq "Yes") {
                    $profilesForDeletion += $username
                }
            }
        } else {
            # Create a custom object for profiles with no LastUseTime
            $profileInfo = [PSCustomObject]@{
                "Profile Name"             = $username
                "Last Log-In Date"         = "No LastUseTime"
                "Recent Log-in ($days days)" = "-Null-"
                "Scheduled for Deletion"   = "Yes"
            }

            # Add the custom object to the list
            $profileInfoList += $profileInfo

            # Add to deletion list if scheduled for deletion
            $profilesForDeletion += $username
        }
    } catch {
        Write-Output "Error processing profile: $username"
    }
}

# Output the profile information in a formatted table
Write-Output "

------------------------------------------------------------------------------------------
Results

User Profiles found:"
$profileInfoList | Format-Table -AutoSize

# Check if there are any profiles scheduled for deletion
if ($profilesForDeletion.Count -gt 0) {
    Write-Output "------------------------------------------------------------------------------------------
Profiles scheduled for deletion:"
    $profilesForDeletion | ForEach-Object { Write-Output $_ }
    exit 1
} else {
    Write-Output "No profiles scheduled for deletion."
    exit 0
}