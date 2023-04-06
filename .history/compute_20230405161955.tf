resource "flexibleengine_compute_keypair_v2" "CV_keypair" {
  name = "CV_keypair"
}

resource "flexibleengine_vpc_eip" "CV_eip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name = "CV_eip"
    size = 10
    share_type = "PER"
    
  }
}



resource "flexibleengine_compute_instance_v2" "CV_VM" {
  name            = "CV_VM"
  image_id        = data.flexibleengine_images_image_v2.ubuntu.id
  region = var.location
  availability_zone = var.availability_zone
  flavor_id       = "s6.2xlarge.2"
  key_pair        = flexibleengine_compute_keypair_v2.CV_keypair.name
  security_groups = [flexibleengine_networking_secgroup_v2.nsg.name]

  network {
    uuid = flexibleengine_vpc_subnet_v1.CV_subnet.id
  }

  tags = {
    
  }
  /*connection {
  type        = "ssh"
  host        = flexibleengine_compute_instance_v2.CV_VM.public_ip
  user        = "ubuntu"
  password    = "your_ssh_password"
  timeout     = "2m"
  agent       = false
  private_key = file("C:\\path\\to\\your\\private\\key\\file")
  allow_host_key_verification = false
}

  provisioner "remote-exec" {
    inline = [
    #Docker installation 
      "sudo apt-get update",
      "sudo apt-get install ca-certificates curl gnupg",
      "sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
      "sudo apt-get install -y git"
    ]
  } */
  depends_on = [
    flexibleengine_compute_keypair_v2.CV_keypair,
    flexibleengine_networking_secgroup_v2.nsg,
    flexibleengine_vpc_subnet_v1.CV_subnet

  ]
}

resource "flexibleengine_compute_floatingip_associate_v2" "CV_eip_associate" {
  floating_ip = flexibleengine_vpc_eip.CV_eip.publicip.0.ip_address
  instance_id = flexibleengine_compute_instance_v2.CV_VM.id
  depends_on = [
    flexibleengine_compute_instance_v2.CV_VM,
    flexibleengine_vpc_eip.CV_eip
  ]
}
