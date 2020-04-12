resource "null_resource" "cluster" {
  connection {
    host     = "3.95.155.117"
    type     = "winrm"
    user     = "Administrator"
    password = "3j7Rq;XI56S)Uz=qh.3-T3-SK-TQI=TG"
    private_key = "privatekey.pem"
    timeout  = "30m"
  }

  provisioner "file" {
    source      = "c:test.ps1"
    destination = "C:/Windows/Temp/test.ps1"
  }

  provisioner "remote-exec" {
    inline = [
      "powershell.exe -File C:/Windows/Temp/test.ps1"
    ]
  }
}

