resource "flexibleengine_vpc_v1" "vpc_test" {
  name = "vpc_test"
  cidr = "192.168.0.0/16"
}

resource "flexibleengine_vpc_subnet_v1" "subnet_automation" {
  name       = "vpc-subnet_test"
  cidr       = "192.168.0.0/24"
  gateway_ip = "192.168.0.1"
  vpc_id     = flexibleengine_vpc_v1.vpc_test.id
}

resource "flexibleengine_compute_instance_v2" "example_instance" {
  name        = "example-instance"
  image_name  = "Standard_Ubuntu_20.04_latest"
  flavor_name = "s2.medium.2"
   network {
    name = flexibleengine_vpc_subnet_v1.subnet_automation.name
    fixed_ip_v4   = "192.168.0.3"
    subnet_name   = flexibleengine_vpc_subnet_v1.name
    #subnet_id  = flexibleengine_networking_subnet_v1.subnet_automation.id
    
    
  }
  
}



