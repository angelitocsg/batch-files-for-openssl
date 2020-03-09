@echo off
echo Sintaxe: create-cert ^<domainName^> ^<alternativeName^>
rem Install OpenSSL from https://slproweb.com/products/Win32OpenSSL.html

rem Parameters
set OPENSSL_CONF=c:\openssl-win64\bin\openssl.cfg
set path=%path%;c:\openssl-win64\bin\
set domainName=%1
set alternativeName=%2
set config_ssl=%domainName%.extcfg

rem Validate parameters
if [%1] == [] goto:eof
if [%2] == [] set alternativeName=0

set CompanyName="ACME Corporation"
set Country="BR"
set State="Sao Paulo"
set Locale="Sao Paulo"
set RootDomain="%domainName%"

set CA_Name=myCA
set CA_Path=ca-certificate
set CA_KEY=%CA_Path%\%CA_Name%.key
set CA_PEM=%CA_Path%\%CA_Name%.pem

set Cert_Days=180
set Cert_Path=certificates
set Cert_KEY=%Cert_Path%\%domainName%.key
set Cert_CSR=%Cert_Path%\%domainName%.csr
set Cert_CRT=%Cert_Path%\%domainName%.crt
set Cert_BUNDLE=%Cert_Path%\%domainName%.bundle
set Cert_PFX=%Cert_Path%\%domainName%_keystore.pfx
set Cert_KeyStore=%Cert_Path%\%domainName%_keystore.pkcs12

rem Run
mkdir %Cert_Path%
echo.
openssl genrsa -out %Cert_KEY% 8192
echo.
echo Making a CSR (Certificate Signing Request)
openssl req -new -key %Cert_KEY% -out %Cert_CSR% -subj /CN=%RootDomain%/O=%CompanyName%/C=%Country%/ST=%State%/L=%Locale%

echo.
echo Creating a custom config SSL
echo authorityKeyIdentifier=keyid,issuer> %config_ssl%
echo basicConstraints = CA:FALSE>> %config_ssl%
echo keyUsage=digitalSignature,nonRepudiation,keyEncipherment,dataEncipherment>> %config_ssl%
    echo subjectAltName = @alt_names>> %config_ssl%
    echo.>> %config_ssl%
    echo [alt_names]>> %config_ssl%
echo DNS.1 = %RootDomain% >> %config_ssl%
if %alternativeName% NEQ 0 (
    echo DNS.2 = %alternativeName% >> %config_ssl%
)

echo.
echo Generating domain certificate
echo.
openssl x509 -req -in %Cert_CSR% -CA %CA_PEM% -CAkey %CA_KEY% -CAcreateserial -out %Cert_CRT% -days %Cert_Days% -sha256 -extfile %config_ssl%

echo.
echo Creating certificates package
echo.
openssl pkcs12 -export -inkey %Cert_KEY% -in %Cert_CRT% -out %Cert_KeyStore%
copy %Cert_KeyStore% %Cert_PFX%

del %config_ssl%

type %Cert_CRT% %CA_PEM% > %Cert_BUNDLE%

pause