#Note: Give your Username Password , source destination paths 
resource "null_resource" "cluster" {
  connection {
    host     = "give your hostname,publicip ,"
    type     = "winrm"
    user     = "Administrator"
    password = "yourpassword"
    timeout  = "30m"
  }
  provisioner "file" {
    source      = "c:exportcertificate.ps1"
    destination = "C:/Windows/Temp/exportcertificate.ps1"
  }

  provisioner "remote-exec" {
    inline = [
      "powershell.exe -File C:/Windows/Temp/exportcertificate.ps1"
    ]
  }
}

