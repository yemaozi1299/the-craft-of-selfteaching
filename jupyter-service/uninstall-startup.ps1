# ================================================================
#  uninstall-startup.ps1
#
#  Remove the Startup shortcut created by install-startup.ps1.
#  JupyterLab will no longer start at logon.
#
#  macOS equivalent:
#      launchctl unload ~/Library/LaunchAgents/com.jupyter.lab.plist
#
#  Run it:
#      powershell -ExecutionPolicy Bypass -File .\uninstall-startup.ps1
# ================================================================

$ErrorActionPreference = 'Stop'

$startup = [Environment]::GetFolderPath('Startup')
$lnk     = Join-Path $startup 'JupyterLab.lnk'

if (Test-Path -LiteralPath $lnk) {
    Remove-Item -LiteralPath $lnk -Force
    Write-Host "  Removed: $lnk"
} else {
    Write-Host "  Nothing to remove: $lnk"
}

$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Host ''
Write-Host '  Note: a server that is already running was NOT stopped.'
Write-Host '  Stop it with:  ' (Join-Path $dir 'stop-jupyter-lab.cmd')
Write-Host ''
