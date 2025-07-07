$profilePath = $PROFILE
$dotfilesProfilePath = "$HOME\.dotfiles\powershell\Microsoft.PowerShell_profile.ps1"

# Ensure the profile directory exists
$profileDir = Split-Path $profilePath
if (-not (Test-Path $profileDir))
{
    Write-Host "Creating profile directory at $profileDir"
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

# Create the profile file if it doesn't exist
if (-not (Test-Path $profilePath))
{
    Write-Host "Creating new PowerShell profile at $profilePath"
    New-Item -ItemType File -Path $profilePath | Out-Null
}

# Check if the sourcing line is already present
$sourceLine = ". `"$dotfilesProfilePath`""
$profileContent = Get-Content $profilePath -Raw

if ($profileContent -notmatch [regex]::Escape($dotfilesProfilePath))
{
    Write-Host "Adding dotfiles profile sourcing to $profilePath"
    Add-Content -Path $profilePath -Value "`n$sourceLine"
} else
{
    Write-Host "Dotfiles profile already sourced in $profilePath"
}


