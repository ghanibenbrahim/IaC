
resource "null_resource" "remote_exec" {
  // Packages installation  

  provisioner "file" {
    source = "pvc.yaml"
    destination = "pvc.yaml"
    connection {
      type = "ssh"
      host = flexibleengine_vpc_eip.CV_eip.address
      user = "cloud"
      private_key = file("./${flexibleengine_compute_keypair_v2.CV_keypair.name}.pem")
    }
  }
  provisioner "file" {
    source = "awx_dep.yaml"
    destination = "awx_dep.yaml"
    connection {
      type = "ssh"
      host = flexibleengine_vpc_eip.CV_eip.address
      user = "cloud"
      private_key = file("./${flexibleengine_compute_keypair_v2.CV_keypair.name}.pem")
    }
  }



  // creating necessaire files for installtion 
  # provisioner "file" {
  #   source = "pvc.yaml"
  #   destination = "pvc.yaml"
  # }
  # provisioner "file" {
  #   source = "awx_dep.yaml"
  #   destination = "awx_dep.yaml"
  # }

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
      // lunch a Rancher container
      "sudo docker run -d --restart=unless-stopped -p 8080:80 --name rancher_server rancher/server:stable",


      //instal Terraform
      // update the index file
      "echo installing terraform ...",
      "sudo apt update",
      "sudo apt -y install software-properties-common gnupg2",
      // adding the GPG key & add the hashicorp repo 
      "curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg",
      "sudo install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/",
      "sudo apt-add-repository -y \"deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main\"",
      // installing terraform 
      "sudo apt install terraform",


      // install Ansible 
      // installing pip3
      # "sudo apt -y install python3-pip",
      # // install ansible as python module
      # "python3 -m pip install --user ansible",
      # // install Ansible
      # "sudo apt install ansible",

      // install AWX
      // K3s
      "curl -sfL https://get.k3s.io | sudo bash -",
      "sudo chmod 644 /etc/rancher/k3s/k3s.yaml",

      // AWX operator 
      "git clone https://github.com/ansible/awx-operator.git",
      "export NS=awxopns",
      "kubectl create ns $NS",
      "sudo kubectl config set-context --current --namespace=$NAMESPACE",
      "RELEASE_TAG=`curl -s https://api.github.com/repos/ansible/awx-operator/releases/latest | grep tag_name | cut -d '\"' -f 4` ",
      "cd awx-operator",
      "sudo apt -y install make",
      "make deploy",

      // AWX instance 
      "cp ../pvc.yaml ../awx_dep.yaml .", 
      "kubectl create -f pvc.yaml",
      "kubectl apply -f awx_dep.yaml"

    ]
    connection {
      type = "ssh"
      host = flexibleengine_vpc_eip.CV_eip.address
      user = "cloud"
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
