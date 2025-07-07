if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
            [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    $script = $MyInvocation.MyCommand.Definition
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$script`"" -Verb RunAs
    exit
}

$settings_path = "$home/Appdata/Roaming/Code/User/settings.json"
$keybindings_path = "$home/AppData/Roaming/Code/User/keybindings.json"

if (Test-Path $settings_path)
{
    Remove-Item -Path $settings_path
}

New-Item -ItemType SymbolicLink `
    -Path $settings_path `
    -Target "$home/.dotfiles/vscode/settings.json"

if (Test-Path $keybindings_path)
{
    Remove-Item -Path $keybindings_path
}

New-Item -ItemType SymbolicLink `
    -Path $keybindings_path `
    -Target "$home/.dotfiles/vscode/keybindings.json"
