@echo off
rem ================================================================
rem  stop-jupyter-lab.cmd - stop the background JupyterLab server.
rem
rem  This is the counterpart of:
rem      launchctl unload ~/Library/LaunchAgents/com.jupyter.lab.plist
rem  It stops the server that is running right now; it does NOT stop
rem  it from starting again at your next logon (use
rem  uninstall-startup.ps1 for that).
rem ================================================================

set "PORT=8888"
if not "%~1"=="" set "PORT=%~1"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0stop-jupyter-lab.ps1" -Port %PORT%

if errorlevel 1 pause
