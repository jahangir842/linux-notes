@echo off
setlocal

echo ...
echo ...
echo ...

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

echo Git installed successfully...!
git --version

echo ...
echo ...
echo ...

REM Define the path to the PyCharm installer
set INSTALLER_PATH="D:\pycharm-community-edition-2024.2.3-installer.exe"

REM Run the installer silently

echo Installing PyCharm Community Edition...
%INSTALLER_PATH% /S /CONFIG=d:\ad-tewav0.8\installation\silent.config /D=c:\Program Files\JetBrains\PyCharm Community Edition 2024.2.4

REM Installation complete
echo PyCharm Community Edition installed successfully...!

echo ...
echo ...
echo ...

REM Define the path to the QGIS installer
set INSTALLER_PATH="D:\QGIS-OSGeo4W-3.22.16-1.msi"

REM Run the installer silently
echo Installing QGIS...
start /wait msiexec /i %INSTALLER_PATH% /quiet

REM Installation complete
echo QGIS installed successfully...!

echo ...
echo ...
echo ...


REM Define the path to the VS_Distributions
set INSTALLER_PATH="D:\VC_redist.x64.exe"

REM Run the installer silently
echo Installing VS_Distributions...
start /wait "" "%INSTALLER_PATH%" /SILENT /NORESTART

REM Installation complete
echo VS_Distributions installed successfully...!

echo ...
echo ...
echo ...

endlocal
pause

