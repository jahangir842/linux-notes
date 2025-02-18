@echo off
setlocal

REM Define the path to the VS_Distributions
set INSTALLER_PATH="D:\VC_redist.x64.exe"

REM Run the installer silently
echo Installing VS_Distributions...
start /wait "" "%INSTALLER_PATH%" /SILENT /NORESTART

REM Installation complete
echo VS_Distributions installed successfully.

endlocal
pause
