###################################################################
#
# SECURITY GROUP "security_group_allow_all"
#
###################################################################

resource "openstack_networking_secgroup_v2" "allow_all" {
    name        = "allow_all"
    description = "Allow All"
}

resource "openstack_networking_secgroup_rule_v2" "allow_all" {
    direction         = "ingress"
    ethertype         = "IPv4"
    remote_ip_prefix  = "0.0.0.0/0"
    security_group_id = openstack_networking_secgroup_v2.allow_all.id
}

###################################################################
#
# SECURITY GROUP "security_group_mgmt"
#
###################################################################

resource "openstack_networking_secgroup_v2" "mgmt" {
    name        = "mgmt"
    description = "Allow SSH, Kafka"
}

resource "openstack_networking_secgroup_rule_v2" "allow_ssh" {
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = 22
    port_range_max    = 22
    remote_ip_prefix  = "0.0.0.0/0"
    security_group_id = openstack_networking_secgroup_v2.mgmt.id
}

resource "openstack_networking_secgroup_rule_v2" "allow_kafka" {
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = 9092
    port_range_max    = 9092
    remote_ip_prefix  = "0.0.0.0/0"
    security_group_id = openstack_networking_secgroup_v2.mgmt.id
}
