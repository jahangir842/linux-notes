@echo off

REM...
REM...
REM...

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

REM...
REM...
REM...

@echo off
set ADAPTERS_FILE=%~dp0adapters.py
set DESTINATION_DIR_ADP="C:\Program Files\QGIS 3.22.16\apps\Python39\Lib\site-packages\geopy\"

REM Copy adapters.py to the QGIS directory
echo Copying adapters.py to %DESTINATION_DIR_ADP%...

echo adaptor file:  %ADAPTERS_FILE% 
echo destination:  %DESTINATION_DIR_ADP%

copy %ADAPTERS_FILE% %DESTINATION_DIR_ADP%


REM...
REM...
REM...


pause

