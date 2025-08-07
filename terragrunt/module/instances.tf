###################################################################
#
# INSTANCE "mgmt"
#
###################################################################

resource "openstack_compute_instance_v2" "mgmt" {
    name            = "mgmt"
    image_id        = var.image_ubuntu_24
    flavor_name     = var.flavour_ubuntu_24
    security_groups = [openstack_networking_secgroup_v2.mgmt.name]

    user_data = file("scripts/cloud_init_linux.yml")

    tags = [ "linux", "ubuntu" ]

    network {
        name = openstack_networking_network_v2.internet_network.name
        fixed_ip_v4 = var.internet_ips["mgmt"]
    }

    network {
        name = openstack_networking_network_v2.internal_network.name
        fixed_ip_v4 = var.internal_ips["mgmt"]
    }

    depends_on = [
        openstack_networking_subnet_v2.internet_subnet,
        openstack_networking_subnet_v2.internal_subnet
    ]
}

resource "openstack_networking_floatingip_v2" "mgmt_ip" {
    pool = var.provider_network_name
}

data "openstack_networking_port_v2" "mgmt_port" {
    device_id  = openstack_compute_instance_v2.mgmt.id
    network_id = openstack_compute_instance_v2.mgmt.network.0.uuid
}

resource "openstack_networking_floatingip_associate_v2" "mgmt_ip_associate" {
    floating_ip = openstack_networking_floatingip_v2.mgmt_ip.address
    port_id     = data.openstack_networking_port_v2.mgmt_port.id
}

output "mgmt_ip" {
  value = openstack_networking_floatingip_v2.mgmt_ip.address
}

###################################################################
#
# INSTANCE "kali"
#
###################################################################

resource "openstack_compute_instance_v2" "kali" {
    name            = "kali"
    image_id        = var.image_kali
    flavor_name     = var.flavour_kali
    security_groups = [openstack_networking_secgroup_v2.allow_all.name]

    user_data = file("scripts/cloud_init_linux.yml")

    tags = [ "linux" ]

    network {
        name = openstack_networking_network_v2.internet_network.name
        fixed_ip_v4 = var.internet_ips["kali"]
    }

    depends_on = [
        openstack_networking_subnet_v2.internet_subnet
    ]
}

###################################################################
#
# INSTANCE "web"
#
###################################################################

resource "openstack_compute_instance_v2" "web" {
    name            = "web"
    image_id        = var.image_windows_server_2022
    flavor_name     = var.flavour_windows_server_2022
    security_groups = [openstack_networking_secgroup_v2.allow_all.name]

    tags = [ "windows", "server", "tier_1" ]

    user_data = file("scripts/cloud_init_windows.ps1")

    network {
        name = openstack_networking_network_v2.internet_network.name
        fixed_ip_v4 = var.internet_ips["web"]
    }

    network {
        name = openstack_networking_network_v2.internal_network.name
        fixed_ip_v4 = var.internal_ips["web"]
    }

    depends_on = [
        openstack_networking_subnet_v2.internet_subnet,
        openstack_networking_subnet_v2.internal_subnet
    ]
}

###################################################################
#
# INSTANCE "dc1"
#
###################################################################

resource "openstack_compute_instance_v2" "dc1" {
    name            = "dc1"
    image_id        = var.image_windows_server_2022
    flavor_name     = var.flavour_windows_server_2022
    security_groups = [openstack_networking_secgroup_v2.allow_all.name]

    tags = [ "windows", "dc", "tier_0" ]

    user_data = file("scripts/cloud_init_windows.ps1")

    network {
        name = openstack_networking_network_v2.internal_network.name
        fixed_ip_v4 = var.internal_ips["dc1"]
    }

    depends_on = [
        openstack_networking_subnet_v2.internal_subnet
    ]
}

###################################################################
#
# INSTANCE "wec"
#
###################################################################

resource "openstack_compute_instance_v2" "wec" {
    name            = "wec"
    image_id        = var.image_windows_server_2022
    flavor_name     = var.flavour_windows_server_2022
    security_groups = [openstack_networking_secgroup_v2.allow_all.name]

    tags = [ "windows", "server", "tier_1" ]

    user_data = file("scripts/cloud_init_windows.ps1")

    network {
        name = openstack_networking_network_v2.internal_network.name
        fixed_ip_v4 = var.internal_ips["wec"]
    }

    depends_on = [
        openstack_networking_subnet_v2.internal_subnet
    ]
}

