# OpenSSL - Batch file for custom certificates

Batch files to create a custom CA (Certificate Authority) and self-signed certificates

## Requirements

Install OpenSSL from https://slproweb.com/products/Win32OpenSSL.html

## Creating your own CA (Certificate Authority)

Edit the `create-ca.bat` file with your data.

```bat
set CompanyName="ACME Corporation"
set Country="BR"
set State="Sao Paulo"
set Locale="Sao Paulo"
```

Execute batch:

```bat
rem Sintax
create-ca.bat <domainName>
rem Example
create-ca.bat acme.corp
```

## Creating a certificate signed by your own CA

Edit the `create-cert.bat` file with your data.

```bat
set CompanyName="ACME Corporation"
set Country="BR"
set State="Sao Paulo"
set Locale="Sao Paulo"
```

Execute batch:

```bat
rem Sintax
create-cert.bat <domainName> <alternativeName>
rem Example
create-cert.bat headquarters.acme.corp hq.acme.corp
```