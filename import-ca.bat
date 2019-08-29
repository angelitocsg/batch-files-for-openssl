@echo off

set CertName=%1

set SETUP_FOLDER=%~dp0
cd %SETUP_FOLDER%

CertUtil -addstore -f "Root" %CertName%

pause 