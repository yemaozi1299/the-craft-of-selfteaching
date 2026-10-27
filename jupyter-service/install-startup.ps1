# ================================================================
#  install-startup.ps1
#
#  Put a shortcut to jupyter-lab.vbs into this user's Startup
#  folder, so JupyterLab starts every time you log in.
#
#  macOS equivalent:
#      launchctl load ~/Library/LaunchAgents/com.jupyter.lab.plist
#
#  Run it (no administrator rights needed):
#      powershell -ExecutionPolicy Bypass -File .\install-startup.ps1
#
#  Add -Start to also launch JupyterLab right away:
#      powershell -ExecutionPolicy Bypass -File .\install-startup.ps1 -Start
# ================================================================
param(
    [switch]$Start
)

$ErrorActionPreference = 'Stop'

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$vbs  = Join-Path $here 'jupyter-lab.vbs'
$cmd  = Join-Path $here 'jupyter-lab.cmd'

if (-not (Test-Path -LiteralPath $vbs)) { throw "Missing file: $vbs" }
if (-not (Test-Path -LiteralPath $cmd)) { throw "Missing file: $cmd" }

$wscript = Join-Path $env:SystemRoot 'System32\wscript.exe'
$startup = [Environment]::GetFolderPath('Startup')
$lnk     = Join-Path $startup 'JupyterLab.lnk'

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($lnk)
$shortcut.TargetPath       = $wscript
$shortcut.Arguments        = "`"$vbs`""
$shortcut.WorkingDirectory = $here
$shortcut.Description      = 'Start JupyterLab at logon'
$shortcut.Save()

Write-Host ''
Write-Host "  Installed : $lnk"
Write-Host "  Runs      : wscript.exe `"$vbs`""
Write-Host ""

if ($Start) {
    Write-Host '  Starting JupyterLab now ...'
    Start-Process -FilePath $wscript -ArgumentList "`"$vbs`"" -WorkingDirectory $here
    Write-Host '  Give it ~10 seconds, then open http://localhost:8888/'
} else {
    Write-Host '  JupyterLab will start automatically at your next logon.'
    Write-Host "  To start it now:  wscript.exe `"$vbs`""
    Write-Host '  Watch the log at: ' (Join-Path $here 'logs\jupyter-lab.log')
}
Write-Host ''
