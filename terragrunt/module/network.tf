###################################################################
#
# ROUTER "internet_router"
#
###################################################################

resource "openstack_networking_router_v2" "internet_router" {
    name                = "internet_router"
    admin_state_up      = true
    external_network_id = var.provider_network_uuid
}

###################################################################
#
# NETWORK "internet_network"
#
###################################################################

resource "openstack_networking_network_v2" "internet_network" {
    name                  = "internet_network"
    port_security_enabled = "true"
    admin_state_up        = "true"
}

resource "openstack_networking_subnet_v2" "internet_subnet" {
    name            = "internet_subnet"
    network_id      = openstack_networking_network_v2.internet_network.id
    cidr            = var.internet_subnet
    dns_nameservers = ["8.8.8.8", "1.1.1.1"]
    ip_version      = 4

    allocation_pool {
        start = cidrhost(var.internet_subnet, 9)
        end = cidrhost(var.internet_subnet, 252)
    }
}

resource "openstack_networking_router_interface_v2" "router_interface_internet_subnet" {
    router_id = openstack_networking_router_v2.internet_router.id
    subnet_id = openstack_networking_subnet_v2.internet_subnet.id
}

###################################################################
#
# NETWORK "internal_network"
#
###################################################################

resource "openstack_networking_network_v2" "internal_network" {
    name                  = "internal_network"
    port_security_enabled = "true"
    admin_state_up        = "true"
}

resource "openstack_networking_subnet_v2" "internal_subnet" {
    name            = "internal_subnet"
    network_id      = openstack_networking_network_v2.internal_network.id
    cidr            = var.internal_subnet
    dns_nameservers = ["8.8.8.8", "1.1.1.1"]
    ip_version      = 4

    allocation_pool {
        start = cidrhost(var.internal_subnet, 9)
        end = cidrhost(var.internal_subnet, 252)
    }
}

resource "openstack_networking_router_interface_v2" "router_interface_internal_subnet" {
  router_id = openstack_networking_router_v2.internet_router.id
  subnet_id = openstack_networking_subnet_v2.internal_subnet.id
}
