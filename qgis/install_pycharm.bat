@echo off
setlocal

REM Define the path to the PyCharm installer
set INSTALLER_PATH="D:\pycharm-community-edition-2024.2.3-installer.exe"

REM Run the installer silently
echo Installing PyCharm Community Edition...
%INSTALLER_PATH% /S /CONFIG=d:\ad-tewav0.8\installation\silent.config /D=c:\Program Files\JetBrains\PyCharm Community Edition 2024.2.4

REM Installation complete
echo PyCharm Community Edition installed successfully...!

endlocal
pause

D:\ad-tewav0.8\installation