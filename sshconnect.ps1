# Script name: SSH Servers connect
# Author: Siim Aarmaa @ https://aarmaa.ee @ 25.04.2024
# Last update: 25.04.2024
# This is open source, everyone in the world can use this code

# Function to read SSH connections from file
function Read-SshConnections {
    param (
        [string]$ScriptDirectory
    )

    # Construct the full path to the SSH connections file
    $filePath = Join-Path -Path $ScriptDirectory -ChildPath "ssh_connections.txt"

    # Check if the file exists
    if (-not (Test-Path $filePath)) {
        Write-Host "File not found: $filePath" -ForegroundColor Red
        return
    }

    # Read the file and display SSH connections with numbers
    $sshConnections = Get-Content $filePath
    Write-Host "SSH Connections:"
    for ($i = 0; $i -lt $sshConnections.Count; $i++) {
        Write-Host "$($i+1). $($sshConnections[$i])"
    }

    # Prompt user to select a connection
    $selection = Read-Host "Enter the number of the SSH connection you want to use"

    # Validate user input
    if ($selection -match '^\d+$' -and $selection -ge 1 -and $selection -le $sshConnections.Count) {
        $selectedConnection = $sshConnections[$selection - 1]
        Write-Host "Selected SSH connection: $selectedConnection"
        
        # Construct the SSH command
        $sshCommand = "ssh.exe $($selectedConnection)"

        # Perform automatic login with SSH command
        Start-Process -FilePath "C:\Windows\System32\OpenSSH\ssh.exe" -ArgumentList $selectedConnection
    }
    else {
        Write-Host "Invalid selection. Please enter a valid number." -ForegroundColor Red
    }
}

# Get the directory of the script
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Usage example
Read-SshConnections -ScriptDirectory $scriptDirectory
