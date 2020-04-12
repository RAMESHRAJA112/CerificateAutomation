#Note Give your Certificate No Pass Phrase ..
#Firstly export the certificate to renew it
Export-ACMCertificate -CertificateArn arn:aws:acm:us-east-1:055309605239:certificate/xxxxxxa-b43e-4e57-baa7-xxxxxx -Passphrase xxxxx -ProfileName test

#Now request AWS to renew the certificate
Invoke-ACMCertificateRenewal -CertificateArn arn:aws:acm:us-east-1:055309605239:certificate/xxxxxxa-b43e-4e57-baa7-550267626cd3 -ProfileName xxxx
