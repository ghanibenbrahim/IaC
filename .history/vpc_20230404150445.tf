resource "flexibleengine_vpc_v1" "vpc_test" {
  name = "vpc_test_2"
  cidr = "192.168.0.0/16"
}

resource "flexibleengine_vpc_subnet_v1" "subnet_automation" {
  name       = "vpc-subnet_test_workspace_dev"
  cidr       = "192.168.1.0/24"
  gateway_ip = "192.168.1.1"
  vpc_id     = flexibleengine_vpc_v1.vpc_test.id
}





