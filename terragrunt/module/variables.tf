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

variable "internet_subnet" {
    type        = string
    description = "Internet subnet CIDR"
    default     = "10.10.10.0/24"
}

variable "internal_subnet" {
    type        = string
    description = "Internal subnet CIDR"
    default     = "10.0.0.0/24"
}

variable "internet_ips" {
    type        = map(string)
    description = "Internet IP addresses for various machines"
    default = {
        web = "10.10.10.10"
        kali = "10.10.10.200"
        mgmt = "10.10.10.250"
    }
}

variable "internal_ips" {
    type        = map(string)
    description = "Internal IP addresses for various machines"
    default = {
        web = "10.0.0.10"
        dc1 = "10.0.0.100"
        mgmt = "10.0.0.250"
        wec = "10.0.0.251"
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

variable "image_kali" {
    type        = string
    description = "Kali image UUID"
}

variable "flavour_kali" {
    type        = string
    description = "Kali flavour"
}