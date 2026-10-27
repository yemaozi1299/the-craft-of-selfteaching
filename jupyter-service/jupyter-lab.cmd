@echo off
rem ================================================================
rem  jupyter-lab.cmd - start JupyterLab in the background.
rem
rem  This is the Windows replacement for the <ProgramArguments>
rem  block of the macOS launchd .plist in the article.
rem
rem  IMPORTANT: keep this file ASCII-only. cmd.exe reads a .cmd in
rem  the OEM code page (936 on Chinese Windows), so a path written
rem  here in UTF-8 gets mis-decoded and the whole script breaks with
rem  "'ab.cmd' is not recognized" / "The syntax of the command is
rem  incorrect." That is why the folder below is computed relatively
rem  instead of pasted in.
rem ================================================================
setlocal EnableExtensions

set "PYTHON=C:\Users\YU\anaconda3\python.exe"
set "PORT=8888"

rem Notebook root = two levels above this script (the book folder).
rem To use another folder, set a user environment variable instead of
rem editing this line, e.g. in PowerShell:
rem     setx JUPYTER_LAB_ROOT "D:\notes"
set "ROOT_DIR=%~dp0..\.."
if defined JUPYTER_LAB_ROOT set "ROOT_DIR=%JUPYTER_LAB_ROOT%"

set "LOGDIR=%~dp0logs"
set "LOGFILE=%LOGDIR%\jupyter-lab.log"

if not exist "%LOGDIR%" mkdir "%LOGDIR%"

cd /d "%ROOT_DIR%"
if errorlevel 1 (
    echo ==== [%TIME%] ERROR: cannot cd to "%ROOT_DIR%" ==== >> "%LOGFILE%"
    exit /b 1
)
set "ROOT_DIR=%CD%"

echo. >> "%LOGFILE%"
echo ==== [%TIME%] start jupyter lab on port %PORT% ==== >> "%LOGFILE%"

rem --port_retries=0 makes a busy port fail loudly instead of
rem silently walking up to 8889, where you would not find it.
rem --ServerApp.token= disables the token, same as the article's
rem "c.NotebookApp.token = ''". It still listens on localhost only.
"%PYTHON%" -m jupyter lab --no-browser ^
    --ServerApp.root_dir="%ROOT_DIR%" ^
    --ServerApp.port=%PORT% ^
    --ServerApp.port_retries=0 ^
    --ServerApp.token= >> "%LOGFILE%" 2>&1

set "RC=%ERRORLEVEL%"
if not "%RC%"=="0" echo ==== [%TIME%] exited, code %RC% ==== >> "%LOGFILE%"
exit /b %RC%
