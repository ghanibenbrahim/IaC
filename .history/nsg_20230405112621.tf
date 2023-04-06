resource "flexibleengine_networking_secgroup_v2" "nsg" {
  name        = "CV_nsg"
  description = "The network security group associated to the CV_VM"
}

resource "flexibleengine_networking_secgroup_rule_v2" "ingress_secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = flexibleengine_networking_secgroup_v2.nsg.id
}
resource "flexibleengine_networking_secgroup_rule_v2" "ingress_secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = flexibleengine_networking_secgroup_v2.nsg.id
}