###################################################################
#
# SSH KEY RELATED VARIABLES
#
###################################################################

# variable "ssh_key" {
#     type        = string
#     description = "SSH-key for administration"
#     default     = "testbed-key"
# }

###################################################################
#
# NETWORK RELATED VARIABLES
#
###################################################################

variable "provider_network_uuid" {
    type        = string
    description = "Provider network UUID"
}

variable "provider_network_name" {
    type        = string
    description = "Provider network name"
}

variable "winlab_subnet" {
    type        = string
    description = "Winlab subnet CIDR"
    default     = "10.0.0.0/24"
}

variable "winlab_ips" {
    type        = map(string)
    description = "IP addresses for various machines"
    default = {
        mgmt = "10.0.0.250"
        kafka = "10.0.0.249"
        dc1 = "10.0.0.10"
        dc2 = "10.0.0.11"
        webserver = "10.0.0.20"
        fileserver = "10.0.0.21"
        wec = "10.0.0.22"
        pc1 = "10.0.0.100"
        pc2 = "10.0.0.101"
    }
}

###################################################################
#
# IMAGE RELATED VARIABLES
#
###################################################################

variable "image_windows_server_2022" {
    type        = string
    description = "Windows Server 2022 image UUID"
}

variable "flavour_windows_server_2022" {
    type        = string
    description = "Windows Server 2022 flavour"
}

variable "image_windows_10" {
    type        = string
    description = "Windows 10 image UUID"
}

variable "flavour_windows_10" {
    type        = string
    description = "Windows 10 flavour"
}

variable "image_debian_12" {
    type        = string
    description = "Debian 12 image UUID"
}

variable "flavour_debian_12" {
    type        = string
    description = "Debian 12 flavour"
}

variable "image_ubuntu_24" {
    type        = string
    description = "Ubuntu 24 image UUID"
}

variable "flavour_ubuntu_24" {
    type        = string
    description = "Ubuntu 24 flavour"
}
