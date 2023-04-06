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

resource "flexibleengine_compute_instance_v2" "exemple" {
  name            = "exemple"
  image_id        = "ad091b52-742f-469e-8f3c-fd81cadf0743"
  flavor_id       = "s3.large.2"
  security_groups = ["default"]

  network {
    uuid = flexibleengine_vpc_subnet_v1.subnet_automation.id
  }



