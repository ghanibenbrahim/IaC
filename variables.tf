variable "resource_group_name" {
  type        = string
  description = "This defines the name of the resource group"
  default     = "level0_rsg"
}

variable "location" {
  type        = string
  description = "This defines the location of the resource group"
  default     = "eu-west-0"
}

variable "availability_zone" {
  type        = string
  description = "This defines the location of the resource group"
  default     = "eu-west-0a"
}

variable "flavor_id" {
  type        = string
  description = "the name of the flavor in FE"
  default     = "value"

}

variable "key_pair_name" {
  type        = string
  default     = "CV_keypair_2"
  description = "The name of a keypair to create on FE"
}





// EIP Params 

variable "eip_name" {
  type    = string
  default = "CV_eip"
}
variable "eip_type" {
  type    = string
  default = "5_bgp"
}

variable "eip_bandwidth_size" {
  type    = number
  default = 10
}
variable "eip_share_type" {
  type    = string
  default = "PER"
}



// ECS params 
variable "ecs_name" {
  type    = string
  default = "CV_VM"
}
variable "ecs_image_id" {
  type    = string
  default = "6ab649f9-d0b8-4e4f-aac8-a5d0a3fed1c9"
}
