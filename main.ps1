function Get-InstalledVersion {
    # Read the module version from the .psd1 manifest
    $manifestPath = "C:\Path\To\Module\MathFunctions.psd1"
    $manifest = Get-Content -Path $manifestPath | ConvertFrom-Json
    return $manifest.ModuleVersion
}

function Get-LatestVersion {
    # Fetch the latest release version from GitHub API (or any other source)
    $repoOwner = "sunilmanjhu"
    $repoName = "PS-UpdateNotifier"
    $apiUrl = "https://api.github.com/repos/$repoOwner/$repoName/releases/latest"
    
    try {
        $response = Invoke-RestMethod -Uri $apiUrl
        return $response.tag_name
    } catch {
        Write-Host "Error fetching the latest version: $_"
        return $null
    }
}

function Check-ForUpdate {
    $installedVersion = Get-InstalledVersion
    $latestVersion = Get-LatestVersion

    if ($latestVersion -and $installedVersion -lt $latestVersion) {
        Write-Host "Installed Version: $installedVersion"
        Write-Host "Latest Version: $latestVersion"
        $response = Read-Host "A new version is available. Do you want to update? (Y/N)"
        if ($response -eq "Y") {
            Update-Module
        }
    }
}

function Update-Module {
    Write-Host "Updating module..."
    # Add logic for updating the module, e.g., downloading and installing the latest version.
}

Check-ForUpdate
