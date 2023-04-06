resource "flexibleengine_compute_instance_v2" "CV_VM" {
  name            = "CV_VM"
  image_id        = "6ab649f9-d0b8-4e4f-aac8-a5d0a3fed1c9"
  region = var.location
  availability_zone = var.availability_zone
  flavor_id       = "s3.large.2"
  key_pair        = "my_key_pair_name"
  security_groups = [flexibleengine_networking_secgroup_v2.nsg.name]

  network {
    uuid = flexibleengine_vpc_subnet_v1.CV_subnet.id
  }

  tags = {
    
  }
}