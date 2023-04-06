output "CV_VM" {
    value = flexibleengine_compute_instance_v2.CV_VM.id
}

output "Object_storage_bucket" {
    value = flexibleengine_obs_bucket.CV_storage_bucket.id
  
}

output "nsg" {
    value = flexibleengine_networking_secgroup_v2.nsg.id
  
}

output "virtual_network" {
    value = flexibleengine_vpc_subnet_v1.CV_subnet.id
  
}