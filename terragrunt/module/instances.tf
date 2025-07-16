###################################################################
#
# INSTANCE "mgmt"
#
###################################################################

resource "openstack_compute_instance_v2" "mgmt" {
    name            = "mgmt"
    image_id        = var.image_ubuntu_24
    flavor_name     = var.flavour_ubuntu_24
    security_groups = [openstack_networking_secgroup_v2.security_group_mgmt.name]

    user_data = file("scripts/cloud_init_linux.yml")

    tags = [ "linux", "ubuntu" ]

    network {
        name = openstack_networking_network_v2.winlab_network.name
        fixed_ip_v4 = var.winlab_ips["mgmt"]
    }

    depends_on = [
        openstack_networking_subnet_v2.winlab_subnet
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
# INSTANCE "dc1"
#
###################################################################

resource "openstack_compute_instance_v2" "dc1" {
    name            = "dc1"
    image_id        = var.image_windows_server_2022
    flavor_name     = var.flavour_windows_server_2022
    security_groups = [openstack_networking_secgroup_v2.security_group_allow_all.name]

    tags = [ "windows", "dc", "tier_0" ]

    user_data = file("scripts/cloud_init_windows.ps1")

    network {
        name = openstack_networking_network_v2.winlab_network.name
        fixed_ip_v4 = var.winlab_ips["dc1"]
    }

    depends_on = [
        openstack_networking_subnet_v2.winlab_subnet
    ]
}

###################################################################
#
# INSTANCE "dc2"
#
###################################################################

resource "openstack_compute_instance_v2" "dc2" {
    name            = "dc2"
    image_id        = var.image_windows_server_2022
    flavor_name     = var.flavour_windows_server_2022
    security_groups = [openstack_networking_secgroup_v2.security_group_allow_all.name]

    tags = [ "windows", "dc", "tier_0" ]

    user_data = file("scripts/cloud_init_windows.ps1")

    network {
        name = openstack_networking_network_v2.winlab_network.name
        fixed_ip_v4 = var.winlab_ips["dc2"]
    }

    depends_on = [
        openstack_networking_subnet_v2.winlab_subnet
    ]
}

###################################################################
#
# INSTANCE "webserver"
#
###################################################################

resource "openstack_compute_instance_v2" "webserver" {
    name            = "webserver"
    image_id        = var.image_windows_server_2022
    flavor_name     = var.flavour_windows_server_2022
    security_groups = [openstack_networking_secgroup_v2.security_group_allow_all.name]

    tags = [ "windows", "server", "tier_1" ]

    user_data = file("scripts/cloud_init_windows.ps1")

    network {
        name = openstack_networking_network_v2.winlab_network.name
        fixed_ip_v4 = var.winlab_ips["webserver"]
    }

    depends_on = [
        openstack_networking_subnet_v2.winlab_subnet
    ]
}

###################################################################
#
# INSTANCE "fileserver"
#
###################################################################

resource "openstack_compute_instance_v2" "fileserver" {
    name            = "fileserver"
    image_id        = var.image_windows_server_2022
    flavor_name     = var.flavour_windows_server_2022
    security_groups = [openstack_networking_secgroup_v2.security_group_allow_all.name]

    tags = [ "windows", "server", "tier_1" ]

    user_data = file("scripts/cloud_init_windows.ps1")

    network {
        name = openstack_networking_network_v2.winlab_network.name
        fixed_ip_v4 = var.winlab_ips["fileserver"]
    }

    depends_on = [
        openstack_networking_subnet_v2.winlab_subnet
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
    security_groups = [openstack_networking_secgroup_v2.security_group_allow_all.name]

    tags = [ "windows", "server", "tier_1" ]

    user_data = file("scripts/cloud_init_windows.ps1")

    network {
        name = openstack_networking_network_v2.winlab_network.name
        fixed_ip_v4 = var.winlab_ips["wec"]
    }

    depends_on = [
        openstack_networking_subnet_v2.winlab_subnet
    ]
}

###################################################################
#
# INSTANCE "pc1"
#
###################################################################

resource "openstack_compute_instance_v2" "pc1" {
    name            = "pc1"
    image_id        = var.image_windows_10
    flavor_name     = var.flavour_windows_10
    security_groups = [openstack_networking_secgroup_v2.security_group_allow_all.name]

    tags = [ "windows", "workstation", "tier_2" ]

    user_data = file("scripts/cloud_init_windows.ps1")

    network {
        name = openstack_networking_network_v2.winlab_network.name
        fixed_ip_v4 = var.winlab_ips["pc1"]
    }

    depends_on = [
        openstack_networking_subnet_v2.winlab_subnet
    ]
}

###################################################################
#
# INSTANCE "pc2"
#
###################################################################

resource "openstack_compute_instance_v2" "pc2" {
    name            = "pc2"
    image_id        = var.image_windows_10
    flavor_name     = var.flavour_windows_10
    security_groups = [openstack_networking_secgroup_v2.security_group_allow_all.name]

    tags = [ "windows", "workstation", "tier_2" ]

    user_data = file("scripts/cloud_init_windows.ps1")

    network {
        name = openstack_networking_network_v2.winlab_network.name
        fixed_ip_v4 = var.winlab_ips["pc2"]
    }

    depends_on = [
        openstack_networking_subnet_v2.winlab_subnet
    ]
}

###################################################################
#
# INSTANCE "attacker"
#
###################################################################

resource "openstack_compute_instance_v2" "attacker" {
    name            = "attacker"
    image_id        = var.image_kali
    flavor_name     = var.flavour_kali
    security_groups = [openstack_networking_secgroup_v2.security_group_allow_all.name]

    user_data = file("scripts/cloud_init_linux.yml")

    tags = [ "linux", "kali" ]

    network {
        name = openstack_networking_network_v2.winlab_network.name
        fixed_ip_v4 = var.winlab_ips["attacker"]
    }

    depends_on = [
        openstack_networking_subnet_v2.winlab_subnet
    ]
}
