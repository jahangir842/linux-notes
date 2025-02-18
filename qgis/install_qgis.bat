@echo off
setlocal

REM Define the path to the QGIS installer
set INSTALLER_PATH="D:\QGIS-OSGeo4W-3.22.16-1.msi"

REM Run the installer silently
echo Installing QGIS...
start /wait msiexec /i %INSTALLER_PATH% /quiet

REM Installation complete
echo QGIS installed successfully.

endlocal
pause