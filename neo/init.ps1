# create exe file
Invoke-ps2exe `
    -inputFile "C:\Users\henry\.dotfiles\neo\neo.ps1" `
    -outputFile "C:\Users\henry\.dotfiles\neo\neo.exe"`
    -noConsole
#-iconFile "C:\Users\henry\.dotfiles\neo\neovide-256x256.png"` #TODO needs to be a .ico

# create environment variables
$oldPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$oldPath;C:\Users\henry\.dotfiles\neo\neo.exe"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

# elevate permission for shortcut
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
            [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    $script = $MyInvocation.MyCommand.Definition
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$script`"" -Verb RunAs
    exit
}


# create shortcut in start menu
# C:\ProgramData\Microsoft\Windows\Start Menu\Programs
$wsh = New-Object -ComObject WScript.Shell
$shortcut = $wsh.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\neo.lnk")
$shortcut.TargetPath = "C:\Users\henry\.dotfiles\neo\neo.exe"
$shortcut.WorkingDirectory = "C:\Users\henry\.dotfiles\neo"
$shortcut.Save()
#$Shortcut.IconLocation = "C:\Path\To\YourApp.exe,0"  # Optional: set icon
