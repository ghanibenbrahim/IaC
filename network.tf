resource "flexibleengine_vpc_v1" "CV_vpc" {
  name = "VPC_CV_2"
  cidr = "192.168.0.0/16"
  #region = var.location
}

resource "flexibleengine_vpc_subnet_v1" "CV_subnet" {
  name       = "CV_Subnet"
  cidr       = "192.168.0.0/24"
  gateway_ip = "192.168.0.1"
  #region = var.location
  #availability_zone = var.availability_zone
  vpc_id = flexibleengine_vpc_v1.CV_vpc.id
  depends_on = [
    flexibleengine_vpc_v1.CV_vpc

  ]
}




