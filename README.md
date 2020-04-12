# CerificateAutomation
This document is about How to automate SSL Certificate of Windows Tomcat Server Using Powershell which is integrated with Terraform

# WalkThrough of Script 

#Step1 :Downloads the Certificate From AWS ACM Certificate Manger 

#Step2 :Unencrypts the Downloaded Private Key Using OpenSSL 

#Step3 :Imports .Keystore file to tomcat using PFX

#Step4 :Removes any tomcat.keystore file if previously exists

#Step5 :Stop and Start Tomcat 

# Prerequisites

You Need to have Openssl and Winrm and Few Commands to Execute the Script
 
Login as Administartor 
 
Open Powershell as Administrator.
          
 Run the below command to check the Powershell version:

"Get-Host | Select-Object Version"

If the version is less than 7, Run the below command to install latest version of Powershell:

              iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI -Preview"

             Now, open Powershell 7 from the Start menu as an Administrator.
   
   Run the below command:

 "Set-ExecutionPolicy RemoteSigned"

"Install-Module -Name AWSPowerShell"

Once the module is installed, test if the module is installed by running:

"Get-Module -ListAvailable"

 Load the module by running the below command:

"Get-Command -Module AWSPowerShell"

To test if the module was loaded successfully, try running the below command:

"Get-AWSPowerShellVersion"

This should return the value of the AWS PowerShell version installed.

Once you confirm that the module is installed, set AWScredentials using the below command:

Set-AWSCredentials -AccessKey<<Access Key>> -SecretKey<<Secret Key>>-StoreAs<<AWSProfileName>>

# OpenSSL:

Now, download the latest OpenSSL zip file from:

https://sourceforge.net/projects/openssl/

 And install OpenSSL in the system.

Once installed, set the path in the Powershell by running the below command:

$env:path = $env:path + "C:\Users\Administrator\Downloads\OpenSSL\bin"

Note: Modify the path as required.

# Tomcat:

Go to the Tomcat/conf folder.

 Open server.xml file.

 #Search for 8443 port connector and modify the value as below:

<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"

maxThreads="150" SSLEnabled="true">

<SSLHostConfig>

<Certificate certificateKeystoreFile="conf/tomcat.keystore" certificateKeystorePassword="xxxxx"

type="RSA" />

</SSLHostConfig>

</Connector>

 And save the file.

 Once all the above setup is done, create a powershell scripts to export the certificate from ACM and renew the certificates.

 Create a Folder for ACM Certificates to Download to give the path in code 
 
 # WinRM 
 
 To enable Winrm we use below commands
 
set-executionpolicy -executionpolicy remotesigned

winrm quickconfig -q

winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="512"}'

winrm set winrm/config '@{MaxTimeoutms="1800000"}'

winrm set winrm/config/service '@{AllowUnencrypted="true"}'

winrm set winrm/config/service/auth '@{Basic="true"}'




