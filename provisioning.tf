resource "null_resource" "remote_exec" {

  
  

  provisioner "remote-exec" {
    inline = [
    #Apache installation 
      "sudo apt-get update",
      "sudo apt install git",
    ]
    connection {
  type        = "ssh"
  host        = flexibleengine_vpc_eip.CV_eip.address
  user        = "cloud"
  /*password    = "your_ssh_password"
  timeout     = "2m"
  agent       = false */
  private_key = file("./${flexibleengine_compute_keypair_v2.CV_keypair.name}.pem")
  
  #allow_host_key_verification = false
}
  }
  depends_on = [
    flexibleengine_compute_floatingip_associate_v2.CV_eip_associate
  ]
}
