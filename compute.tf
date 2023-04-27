resource "flexibleengine_compute_keypair_v2" "CV_keypair" {
  name = var.key_pair_name
}

resource "flexibleengine_vpc_eip" "CV_eip" {
  publicip {
    type = var.eip_type
  }
  bandwidth {
    name       = var.eip_name
    size       = var.eip_bandwidth_size
    share_type = var.eip_share_type
  }
}



resource "flexibleengine_compute_instance_v2" "CV_VM" {
  name              = var.ecs_name
  image_id          = var.ecs_image_id
  region            = var.location
  availability_zone = var.availability_zone
  flavor_id         = var.flavor_id
  key_pair          = flexibleengine_compute_keypair_v2.CV_keypair.name
  security_groups   = [flexibleengine_networking_secgroup_v2.nsg.id]
  #security_groups = [data.flexibleengine_networking_secgroup_v2.nsg_test.name]


  network {
    uuid = data.flexibleengine_vpc_subnet_v1.vpc.id

  }

  tags = {

  }

  /*connection {
  type        = "ssh"
  host        = flexibleengine_vpc_eip.CV_eip.address
  #user        = "ubuntu"
  password    = "your_ssh_password"
  timeout     = "2m"
  agent       = false 
  private_key = file("./${flexibleengine_compute_keypair_v2.CV_keypair.name}.pem")
  
  #allow_host_key_verification = false
}

  provisioner "remote-exec" {
    inline = [
    #Apache installation 
      "apt-get update",
      "apt-get install -y apache2",
      "systemctl start apache2"
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
