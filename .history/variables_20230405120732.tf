variable "resource_group_name" {
  type=string
  description="This defines the name of the resource group"
  default = "level0_rsg"
}

variable "location" {
  type=string
  description="This defines the location of the resource group"
  default = "eu-west-0"
}

variable "availability_zone" {
  type=string
  description="This defines the location of the resource group"
  default = "eu-west-0a"
}
