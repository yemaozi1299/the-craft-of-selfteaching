# ================================================================
#  stop-jupyter-lab.ps1
#
#  Stop the background JupyterLab server by finding whatever process
#  is listening on the port and killing it.
#
#  Why not "jupyter server stop 8888"?
#  Because we start the server with authentication disabled
#  (--ServerApp.token=). The shutdown request it sends then comes
#  back as HTTP 403 Forbidden and the server keeps running.
#  Verified on this machine. Killing the listener always works.
#
#  Usage:
#      powershell -ExecutionPolicy Bypass -File .\stop-jupyter-lab.ps1
#      powershell -ExecutionPolicy Bypass -File .\stop-jupyter-lab.ps1 -Port 8889
# ================================================================
param(
    [int]$Port = 8888
)

$ErrorActionPreference = 'Stop'

$procs = Get-NetTCPConnection -LocalPort $Port -State Listen -ErrorAction SilentlyContinue |
         Select-Object -ExpandProperty OwningProcess -Unique

if (-not $procs) {
    Write-Host "Nothing is listening on port $Port - JupyterLab is not running."
    exit 0
}

foreach ($procId in $procs) {
    $p = Get-Process -Id $procId -ErrorAction SilentlyContinue
    $name = if ($p) { $p.ProcessName } else { 'unknown' }
    Write-Host "Stopping PID $procId ($name) ..."
    Stop-Process -Id $procId -Force -ErrorAction Stop
}

Start-Sleep -Milliseconds 800

$still = Get-NetTCPConnection -LocalPort $Port -State Listen -ErrorAction SilentlyContinue
if ($still) {
    Write-Host "Port $Port is still in use. Close it from Task Manager."
    exit 1
}

Write-Host "Stopped. Port $Port is free."
Write-Host "Your notebooks are on disk; open them again after the restart."
Write-Host "It will start again automatically at your next logon."
