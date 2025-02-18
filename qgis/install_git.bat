@echo off
setlocal

REM Define the path to the Git installer (update this path as needed)
set GIT_INSTALLER_PATH=D:\Git-2.45.2-64-bit.exe

REM Check if the installer exists
if not exist "%GIT_INSTALLER_PATH%" (
    echo Git installer not found at "%GIT_INSTALLER_PATH%".
    echo Installer not found, please check the path and try again.
    exit /b 1
)

REM Install Git silently
echo Installing Git silently...
start /wait "" "%GIT_INSTALLER_PATH%" /SILENT /NORESTART

REM Check if Git was installed successfully
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Git installation failed.
    exit /b 1
)

echo Git installed successfully.
git --version

endlocal
pause

