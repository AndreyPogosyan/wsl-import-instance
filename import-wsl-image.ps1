<#
.SYNOPSIS
Manage WSL instances by unregistering and importing from a tar backup.

.DESCRIPTION
This script accepts a WSL instance name and a tar filename as parameters.
It terminates the instance if running, unregisters it, and then imports
the tar file from a hardcoded base path as a new WSL instance.

.PARAMETER InstanceName
The name of the WSL instance to manage.

.PARAMETER TarFileName
The name of the tar backup file (without path).

.EXAMPLE
.\ManageWSLInstance.ps1 -InstanceName "Learn-React" -TarFileName "Ubuntu.tar"
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$InstanceName,

    [Parameter(Mandatory=$true)]
    [string]$TarFileName
)

# Hardcoded base path for the tar files
$BasePath = "G:\WSL\"

# Construct the full path to the tar file
$TarFilePath = Join-Path -Path $BasePath -ChildPath $TarFileName

# Function to check if WSL instance exists
function Get-WSLInstance {
    $instances = wsl --list --quiet
    return $instances -contains $InstanceName
}

# Check if the WSL instance exists
if (Get-WSLInstance) {
    Write-Output "WSL instance '$InstanceName' exists."

    # Terminate the instance if it's running
    Write-Output "Checking if '$InstanceName' is running..."
    $runningInstances = wsl --list --verbose | Select-String "Running"
    if ($runningInstances -match $InstanceName) {
        Write-Output "Instance '$InstanceName' is running. Terminating it..."
        wsl --terminate $InstanceName
        Write-Output "Instance '$InstanceName' terminated."
    } else {
        Write-Output "Instance '$InstanceName' is not running."
    }

    # Unregister the instance
    Write-Output "Unregistering WSL instance '$InstanceName'..."
    wsl --unregister $InstanceName
    Write-Output "Instance '$InstanceName' unregistered."
} else {
    Write-Output "WSL instance '$InstanceName' does not exist."
}

# Check if the tar file exists in the base path
if (-Not (Test-Path $TarFilePath)) {
    Write-Error "Tar file '$TarFilePath' not found. Please ensure the file exists in the '$BasePath' directory."
    exit 1
}

# Import the new instance
Write-Output "Importing WSL instance '$InstanceName' from '$TarFilePath'..."
$ImportPath = "G:\WSL\$InstanceName"
wsl --import $InstanceName $ImportPath $TarFilePath
Write-Output "WSL instance '$InstanceName' successfully imported from '$TarFilePath'."
wsl --list --verbose