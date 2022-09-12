#!/bin/bash

# Password for your PFX file
export PFX_PASSWORD=""

# Name of the PFX file to process
export PFX_FILE_IN=""

# Define the name of the output key file
export KEY_FILE_OUT="${PFX_FILE_IN/.pfx/.nopassword.key}"

# Define the name of the output PFX file
export PFX_FILE_OUT="${PFX_FILE_IN/.pfx/.nopassword.pfx}"

echo Extracting certificate...
openssl pkcs12 -clcerts -nokeys -in "$PFX_FILE_IN" -out certificate.crt -password pass:"$PFX_PASSWORD" -passin pass:"$PFX_PASSWORD"

echo Extracting certificate authority key...
openssl pkcs12 -cacerts -nokeys -in "$PFX_FILE_IN" -out ca-cert.ca -password pass:"$PFX_PASSWORD" -passin pass:"$PFX_PASSWORD"

echo Extracting private key...
openssl pkcs12 -nocerts -in "$PFX_FILE_IN" -out private.key -password pass:"$PFX_PASSWORD" -passin pass:"$PFX_PASSWORD" -passout pass:TemporaryPassword

echo Removing passphrase from private key in file $KEY_FILE_OUT...
openssl rsa -in private.key -out "$KEY_FILE_OUT" -passin pass:TemporaryPassword

echo Building new PFX input file...
cat private.key certificate.crt ca-cert.ca >pfx-in.pem

echo Creating new PFX file $PFX_FILE_OUT...
openssl pkcs12 -export -nodes -CAfile ca-cert.ca -in pfx-in.pem -passin pass:TemporaryPassword -passout pass:"" -out "$PFX_FILE_OUT"

echo Cleaning up...
rm certificate.crt ca-cert.ca private.key pfx-in.pem
