#Note Give your $Certificate Arn and $passprase  :xxxxx  $awsprofile  where ever required in this script Also Replace the path of your specified locations

# Export the Private certificate from AWS ACM
$cert = Export-ACMCertificate -CertificateArn $ARN -Passphrase $Passphrase -ProfileName $AWSprofile

# Download the certificate components to ACM folder
$cert.CertificateChain | Out-File C:/Users/Administrator/ACM/certificatechain.pem
$cert.Certificate | Out-File C:/Users/Administrator/ACM/certificate.pem
$cert.PrivateKey | Out-File C:/Users/Administrator/ACM/privatekey.pem

# Unencrypt the private key
Invoke-Expression "opensslrsa -in C:/Users/Administrator/ACM/privatekey.pem -out C:/Users/Administrator/ACM/privatekey_unecrypt.pem -passinpass:$Passphrase"

#Generate Personal Information Exchange (pfx) file
Invoke-Expression "openssl pkcs12 -export -out C:/Users/Administrator/ACM/certificate.pfx -inkey C:/Users/Administrator/ACM/privatekey_unecrypt.pem -in C:/Users/Administrator/ACM/certificate.pem -password pass:$Passphrase"


#Stopping Tomcat Service
stop-service Tomcat9

Start-Sleep -s 5

#Remove Tomcat keystore file if exists
if (Test-Path -path "C:/Program Files (x86)/Apache Software Foundation/Tomcat 9.0/conf/tomcat.keystore")
{
Remove-Item -path "C:/Program Files (x86)/Apache Software Foundation/Tomcat 9.0/conf/tomcat.keystore"
}

#Run keytool to import the tomcat keystore file
& 'C:\Program Files (x86)\Java\jre1.8.0_241\bin\keytool.exe' -importkeystore -deststorepass $Passphrase -destkeystore "C:/Program Files (x86)/Apache Software Foundation/Tomcat 9.0/conf/tomcat.keystore" -deststoretype JKS -srckeystore "C:/Users/Administrator/ACM/certificate.pfx" -srcstoretype PKCS12 -srcstorepass $Passphrase

Start-Sleep -s 5

#Start Tomcat Service
start-service Tomcat9

