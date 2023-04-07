resource "null_resource" "remote_exec" {
  // Packages installation
  provisioner "remote-exec" {
    inline = [
      // install git 
      "sudo apt-get update",
      "sudo apt install git", 

      // install docker 
      
      // repo setup 
      "sudo apt-get update", 
      "sudo apt-get -y install ca-certificates curl gnupg", 
      // add Docker's GPG key 
      "sudo mkdir -m 0755 -p /etc/apt/keyrings", 
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
      // set up the repo 
      " echo \"deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu  \"$(. /etc/os-release && echo \"$VERSION_CODENAME\")\" stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null ",
      // install docker engine
      "sudo apt-get update",
      "sudo apt-get -y install  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
      "echo docker engine installed ",

      // install Rancher 

      //instal Terraform

      // install Ansible 
      
      // install AWX
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
