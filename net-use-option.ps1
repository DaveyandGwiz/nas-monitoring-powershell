# Define the drive letter to use for the mapped drive
$driveLetter = "Z:"

# Define the UNC path to the NAS share
$nasSharePath = "\\YourNAS\SharePath"

# Define the username and password for accessing the NAS share
$username = "YourUsername"
$password = "YourPassword"

# Convert the password to a secure string
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force

# Create a PSCredential object
$credentials = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

# Check if the drive is already mapped and remove it if it is
if (Test-Path $driveLetter) {
    Remove-PSDrive -Name ($driveLetter -replace ':$') -Force
}

# Map the NAS share as a network drive
New-PSDrive -Name ($driveLetter -replace ':$') -PSProvider FileSystem -Root $nasSharePath -Credential $credentials -Persist

# Optionally, to ensure the drive mapping is available outside of PowerShell (in Windows Explorer, etc.), you might also consider using "net use"
# Remove the previous mapping to avoid conflicts
# net use $driveLetter /delete /y
# Map the network drive using "net use"
# net use $driveLetter $nasSharePath /user:$username $password /persistent:yes
