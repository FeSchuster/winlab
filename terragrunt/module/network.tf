###################################################################
#
# ROUTER "winlab_router"
#
###################################################################

resource "openstack_networking_router_v2" "winlab_router" {
    name                = "winlab_router"
    admin_state_up      = true
    external_network_id = var.provider_network_uuid
}

###################################################################
#
# NETWORK "winlab_network"
#
###################################################################

resource "openstack_networking_network_v2" "winlab_network" {
    name                  = "winlab_network"
    port_security_enabled = "true"
    admin_state_up        = "true"
}

resource "openstack_networking_subnet_v2" "winlab_subnet" {
    name            = "winlab_subnet"
    network_id      = openstack_networking_network_v2.winlab_network.id
    cidr            = var.winlab_subnet
    dns_nameservers = ["8.8.8.8", "1.1.1.1"]
    ip_version      = 4
}

resource "openstack_networking_router_interface_v2" "router_interface_winlab_subnet" {
    router_id = openstack_networking_router_v2.winlab_router.id
    subnet_id = openstack_networking_subnet_v2.winlab_subnet.id
}
