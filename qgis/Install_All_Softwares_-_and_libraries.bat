@echo off
setlocal

color 0A

echo ...
echo ...
echo ...

echo              .o.       oooooooooo.               ooooooooooooo oooooooooooo oooooo   oooooo     oooo       .o.       
echo             .888.      `888'   `Y8b              8'   888   `8 `888'     `8  `888.    `888.     .8'       .888.      
echo            .8"888.      888      888                  888       888           `888.   .8888.   .8'       .8"888.     
echo           .8' `888.     888      888                  888       888oooo8       `888  .8'`888. .8'       .8' `888.    
echo          .88ooo8888.    888      888                  888       888    "        `888.8'  `888.8'       .88ooo8888.   
echo         .8'     `888.   888     d88'                  888       888       o      `888'    `888'       .8'     `888.  
echo        o88o     o8888o o888bood8P'   ooooooooooo     o888o     o888ooooood8       `8'      `8'       o88o     o8888o 

REM echo **********************************************************
REM echo ************* Installing AD_TEWA *************************
REM echo **********************************************************


REM Define the path to the Git installer (update this path as needed)
set GIT_INSTALLER_PATH=D:\Git-2.45.2-64-bit.exe

REM Check if the installer exists
if not exist "%GIT_INSTALLER_PATH%" (
    echo Git installer not found at "%GIT_INSTALLER_PATH%".
    echo Installer not found, please check the path and try again.
    exit /b 1
)

echo ...
echo ...
echo ...

REM Install Git silently
echo Installing Git ...
start /wait "" "%GIT_INSTALLER_PATH%" /SILENT /NORESTART

REM Check if Git was installed successfully

echo Git installed successfully...!


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
echo QGIS installed successfully.

echo ...
echo ...
echo ...


REM Define the path to the VS_Distributions
set INSTALLER_PATH="D:\VC_redist.x64.exe"

REM Run the installer silently
echo Installing VS_Distributions...
start /wait "" "%INSTALLER_PATH%" /SILENT /NORESTART

REM Installation complete
echo VS_Distributions installed successfully.

echo ...
echo ...
echo ...

rem Initializing the OSGeo4W environment
rem call "%~dp0\bin\o4w_env.bat"          ---------------   skip for now

rem Ensure Python is set up correctly

echo Initializing OSGeo4W environment
set PYTHON_PATH="C:\Program Files\QGIS 3.22.16\apps\python39\python.exe"

rem Path to your requirements.txt file
set REQUIREMENTS_PATH="D:\ad-tewav0.8\installation\requirements.txt"
echo requiremnts.txt file is: %REQUIREMENTS_PATH%

rem Run pip install command
@echo on
%PYTHON_PATH% -m pip install --no-index --find-links=http://192.168.1.109/libraries --trusted-host 192.168.1.109 -r %REQUIREMENTS_PATH%

echo ...
echo ...
echo ...

@echo off
set ADAPTERS_FILE=%~dp0adapters.py
set DESTINATION_DIR_ADP="C:\Program Files\QGIS 3.22.16\apps\Python39\Lib\site-packages\geopy\"

REM Copy adapters.py to the QGIS directory
echo Copying adapters.py to %DESTINATION_DIR_ADP%...

echo adaptor file:  %ADAPTERS_FILE% 
echo destination:  %DESTINATION_DIR_ADP%

copy %ADAPTERS_FILE% %DESTINATION_DIR_ADP%

echo ...
echo ...
echo ...

REM echo **********************************************************
REM echo ************* AD_TEWA Installed  *************************
REM echo **********************************************************

echo ...
echo ...


echo            .o.       oooooooooo.               ooooooooooooo oooooooooooo oooooo   oooooo     oooo       .o.       
echo           .888.      `888'   `Y8b              8'   888   `8 `888'     `8  `888.    `888.     .8'       .888.      
echo          .8"888.      888      888                  888       888           `888.   .8888.   .8'       .8"888.     
echo         .8' `888.     888      888                  888       888oooo8       `888  .8'`888. .8'       .8' `888.    
echo        .88ooo8888.    888      888                  888       888    "        `888.8'  `888.8'       .88ooo8888.   
echo       .8'     `888.   888     d88'                  888       888       o      `888'    `888'       .8'     `888.  
echo      o88o     o8888o o888bood8P'   ooooooooooo     o888o     o888ooooood8       `8'      `8'       o88o     o8888o 

echo ...
echo ...
echo          *****************************************************************************************************
echo          *                                           /\                                                      *
echo          *                                          ^|==^|                                                     *
echo          *                                          ^|  ^|                                                     *
echo          *                                         /____\                                                    *  
echo          *                                         ^|    ^|                                                    * 
echo          *                                        /______\                                                   *
echo          *                                       ^|________^|                                                  *
echo          *                                          /^|^|\                                                     *
echo          *                                         //^|^|\\                                                    *
echo          *                                        ^|^|^|^|^|^|^|^|                                                   *
echo          *                                   AD_TEWA INSTALLED!                                              *
echo          *                                                                                                   *
echo          *****************************************************************************************************
echo ...
echo ...
echo ...
echo ...
endlocal
pause

