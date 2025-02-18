@echo off
setlocal

REM Define the paths
set REQUIREMENTS_FILE=%~dp0requirements.txt
set ADAPTERS_FILE=%~dp0adapters.py
set DESTINATION_DIR_REQ="C:\Program Files\QGIS 3.22.16\"
set DESTINATION_DIR_ADP="C:\Program Files\QGIS 3.22.16\apps\Python39\Lib\site-packages\geopy\"
set OSGeo4W_BAT="C:\Program Files\QGIS 3.22.16\OSGeo4W.bat"

REM Check if OSGeo4W.bat exists
if not exist %OSGeo4W_BAT% (
    echo ERROR: OSGeo4W.bat not found at %OSGeo4W_BAT%.
    echo Please check the path and try again.
    pause
    exit /b
)

REM Copy requirements.txt to the QGIS directory
echo Copying requirements.txt to %DESTINATION_DIR_REQ%...
copy %REQUIREMENTS_FILE% %DESTINATION_DIR_REQ%

REM Copy adapters.py to the QGIS directory
echo Copying adapters.py to %DESTINATION_DIR_ADP%...
copy %ADAPTERS_FILE% %DESTINATION_DIR_ADP%

REM Open OSGeo4W.bat as Administrator
echo Opening QGIS Terminal (OSGeo4W.bat) as Administrator...
powershell -Command "Start-Process '%OSGeo4W_BAT%' -Verb runAs"

endlocal
pause

