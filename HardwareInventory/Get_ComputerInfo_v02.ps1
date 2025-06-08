# Prompt for Asset Tag Number
$AssetTagNumber = Read-Host "Enter Asset Tag Number"

# Retrieve Computer Name
$ComputerName = $env:COMPUTERNAME

# Get System Information
$SystemInfo = Get-CimInstance -ClassName Win32_ComputerSystem
$Manufacturer = $SystemInfo.Manufacturer
$Model = $SystemInfo.Model
$SerialNumber = $SystemInfo.SerialNumber
$SKUNumber = $SystemInfo.SystemSKUNumber

# Get UUID
$SystemProduct = Get-CimInstance -ClassName Win32_ComputerSystemProduct
$UUID = $SystemProduct.UUID

# Get RAM Information
$RAM = Get-CimInstance -ClassName Win32_PhysicalMemory
$TotalRAM = ($RAM | Measure-Object -Property Capacity -Sum).Sum / 1GB

# Get CPU Information
$CPU = Get-CimInstance -ClassName Win32_Processor
$CPUInfo = "$($CPU.Name) ($($CPU.NumberOfCores) cores, $($CPU.Manufacturer))"

# Get OS Information
$OSInfo = Get-CimInstance -ClassName Win32_OperatingSystem
$OS = $OSInfo.Caption
$OSVersion = $OSInfo.Version

# Get IP Address
$IPAddresses = Get-NetIPAddress | Where-Object { $_.AddressFamily -eq "IPv4" }
$IPAddress = ($IPAddresses | Select-Object -ExpandProperty IPAddress) -join "`r`n"

# Get MAC Address
$NetworkAdapters = Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration | Where-Object { $_.MACAddress -ne $null -and $_.IPEnabled -eq $true }
$MACAddresses = $NetworkAdapters.MACAddress -join "`r`n"

# Get Hard Drive Information
$HardDrives = Get-CimInstance -ClassName Win32_DiskDrive
$DriveNumber = 1
$DriveInfo = $HardDrives | ForEach-Object {
    $ModelNumber = $_.DeviceID
    $HDManufacturer = $_.Manufacturer
    $Serial = $_.SerialNumber
    $SizeGB = [math]::Round($_.Size / 1GB, 2)
    $MediaType = $_.MediaType
    $ModelVersion = $_.Model
    $InterfaceType = $_.InterfaceType
    $HDName = $_.Name
    $HDHealth = $_.StatusInfo

    @"
                -----------------------------
                
                Drive $DriveNumber
                Model Version: $ModelVersion
                Manufacturer: $HDManufacturer
                Location : $HDName
                Interface: $InterfaceType
                Serial Number: $Serial
                Health: $HDHealth
                Size: $SizeGB GB

"@
    $DriveNumber++
}

# Specify the output file path with Asset Tag Number
$OutputFilePath = "C:\($AssetTagNumber)_ComputerInfo.txt"

# Build the output text
$OutputText = @"
Asset Tag     : $AssetTagNumber
Computer Name : $ComputerName
Manufacturer  : $Manufacturer
Model         : $Model
Sku Number    : $SKUNumber
Serial Number : $SerialNumber
UUID          : $UUID
GUID          : $GUID
OS            : $OS
OS Version    : $OSVersion
CPU           : $CPUInfo
RAM           : $TotalRAM GB
Hard Drive    : 
$DriveInfo

IP Address    : 
$IPAddress

Mac Address   : 
$MACAddresses
"@

# Export the information to a text file
$OutputText | Out-File -FilePath $OutputFilePath

# Display the results
Write-Host "Computer information has been saved to $OutputFilePath"