function Find-Module 
{    
    [bool]$result = $false # Default value
    Write-Host "Searching for dependencies..."
    # Check if the package exists
    if (Get-InstalledModule | Sort-Object -Property Name | Select-String PSWindowsUpdate)
    {
        $result = $true 
    } else {
        Install-Module -Name PSWindowsUpdate -Force 
    }
}

function Update-System 
{
    Import-Module PSWindowsUpdate
    Write-Host "List of available Windows updates"
    Get-WUlist -MicrosoftUpdate 
    Write-Warning "Do you want to update your system? Y/N"
    $UpdateOrNot = Read-Host

    if ($UpdateOrNot.ToLower() -eq "y") {
        Write-Verbose "Updating system..."
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll
    } else {
        return;
    }
} 
