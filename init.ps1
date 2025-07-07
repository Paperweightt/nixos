$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

.\ahk\init.ps1
.\glazeWm\init.ps1
.\neo\init.ps1
.\nvim\init.ps1
.\powershell\init.ps1
.\yasb\init.ps1
