$ahkDir = "$HOME\.dotfiles\ahk"  # Replace with your AHK scripts folder path
$startupDir = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

if (-not (Test-Path $ahkDir))
{
    Write-Host "AHK directory not found: $ahkDir" -ForegroundColor Red
    exit
}

$wsh = New-Object -ComObject WScript.Shell

Get-ChildItem -Path $ahkDir -Filter *.ahk | ForEach-Object {
    $scriptPath = $_.FullName
    $shortcutPath = Join-Path $startupDir ($_.BaseName + ".lnk")

    $shortcut = $wsh.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $scriptPath
    $shortcut.WorkingDirectory = $ahkDir
    $shortcut.Save()

    Write-Host "Created shortcut for '$($_.Name)' in Startup folder."
}

Write-Host "`nAll done"
