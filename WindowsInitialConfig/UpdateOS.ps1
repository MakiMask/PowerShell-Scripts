# This script requires the 'PSWindowsUpdate' module to function properly.
function Find-Module 
{    
    [bool]$result = $false # Default value

    if (Get-Package -Name PSWindowsUpdate) {
        Write-Host "Dependency detected."
        $result = $true
    } else {
        Install-Module -Name PSWindowsUpdate -Force
    }

    return $result
}

function Update-System 
{
    Import-Module PSWindowsUpdate
    Write-Host "List of available Windows updates"
    Get-WUlist -MicrosoftUpdate 
    Write-Warning "Do you want to update your system? Y/N"
    $UpdateOrNot = Read-Host

    if ($UpdateOrNot.ToLower() == "y") {
        Write-Verbose "Updating system..."
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll
    } else {
        return;
    }
} 
