
#Firstly export the certificate to renew it
Export-ACMCertificate -CertificateArn arn:aws:acm:us-east-1:055309605239:certificate/69f8e78a-b43e-4e57-baa7-550267626cd3 -Passphrase Test@1234 -ProfileName test

#Now request AWS to renew the certificate
Invoke-ACMCertificateRenewal -CertificateArn arn:aws:acm:us-east-1:055309605239:certificate/69f8e78a-b43e-4e57-baa7-550267626cd3 -ProfileName test
