$profilePath = "$home/.dotfiles/powershell/profile.ps1"
$version = "0.1.1"
$prev_location = Get-Location

# for use with auto-sessions to allow for gobal sessions
Set-Location "C:\"

if (Test-Path $profilePath)
{
    . $profilePath
} else
{
    Write-Error "profile not found"
}

if ($args -contains "--version")
{
    Write-Output "neo v$version"
    exit
}

& "neovide" @args

Set-Location $prev_location
