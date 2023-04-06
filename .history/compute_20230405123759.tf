resource "flexibleengine_compute_keypair_v2" "CV_keypair" {
  name = "CV_keypair"
}

resource "flexibleengine_vpc_eip" "CV_eip" {
  publicip {
    type = "Dynamic BGP"
  }
  bandwidth {
    name = "CV_eip"
    size = 10
    share_type = "PER"
    
  }
}



resource "flexibleengine_compute_instance_v2" "CV_VM" {
  name            = "CV_VM"
  image_id        = "6ab649f9-d0b8-4e4f-aac8-a5d0a3fed1c9"
  region = var.location
  availability_zone = var.availability_zone
  flavor_id       = "s3.large.2"
  key_pair        = flexibleengine_compute_keypair_v2.CV_keypair.name
  security_groups = [flexibleengine_networking_secgroup_v2.nsg.name]

  network {
    uuid = flexibleengine_vpc_subnet_v1.CV_subnet.id
  }

  tags = {
    
  }
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