@echo off
echo Sintaxe: create-ca ^<domainName^>
rem Install OpenSSL from https://slproweb.com/products/Win32OpenSSL.html

rem Parameters
set OPENSSL_CONF=c:\OpenSSL-Win64\bin\openssl.cfg
set path=%path%;c:\OpenSSL-Win64\bin\
set domainName=%1

rem Validate parameters
if [%1] == [] goto:eof

set CompanyName="ACME Corporation"
set Country="BR"
set State="Sao Paulo"
set Locale="Sao Paulo"
set RootDomain=%domainName%

set CA_Days=3650
set CA_Name=myCA
set CA_Path=ca-certificate
set CA_KEY=%CA_Path%\%CA_Name%.key
set CA_PEM=%CA_Path%\%CA_Name%.pem
set CA_CRT=%CA_Path%\%CA_Name%.crt

rem Run
mkdir %CA_Path%
echo.
openssl genrsa -aes256 -out %CA_KEY% 8192
echo.
openssl req -x509 -new -nodes -key %CA_KEY% -sha256 -out %CA_PEM% -days %CA_Days% -subj /CN=%RootDomain%/O=%CompanyName%/C=%Country%/ST=%State%/L=%Locale%
copy %CA_PEM% %CA_CRT%

pause   