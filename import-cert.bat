@echo off

set Password=%1
set CertName=%2

set SETUP_FOLDER=%~dp0
cd %SETUP_FOLDER%

CertUtil -f -p %Password% -importpfx %CertName%

pause 