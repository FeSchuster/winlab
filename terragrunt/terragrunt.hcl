terraform {
    source = ".//module"

    extra_arguments "parallelism" {
        commands  = ["apply"]
        arguments = ["-parallelism=${get_env("TF_VAR_parallelism", "10")}"]
    }
}

inputs = {
    provider_network_uuid = "daecbf69-52c8-4ac8-a9e3-09b7d6e2ab44"
    provider_network_name = "AECID-provider-network"

    image_windows_server_2022 = "f6c29468-24f3-41d0-8b31-188540eb03c3"
    image_windows_10 = "4bd56e9d-d6d5-4318-800d-85d15607c04e"
    image_debian_12 = "2f66963e-69cc-440e-b526-357afa8d4875"
    image_ubuntu_24 = "fd234366-75b1-47a1-b8ce-e9f9859b50b0"
    image_kali = "2aba8827-88d8-4a21-b00c-948b40230de2"

    flavour_windows_server_2022 = "d2-8"
    flavour_windows_10 = "d2-8"
    flavour_debian_12 = "d2-4"
    flavour_ubuntu_24 = "d2-4"
    flavour_kali = "c2-15"
}

# include {
#     path = find_in_parent_folders()
# }

remote_state {
    backend = "http"
    config = {
        address        = "${get_env("GITLAB_STATE_REPOSITORY")}/${get_env("OS_PROJECT_NAME")}_${get_env("OS_USER_DOMAIN_NAME")}_${path_relative_to_include()}_${basename(get_repo_root())}"
        lock_address   = "${get_env("GITLAB_STATE_REPOSITORY")}/${get_env("OS_PROJECT_NAME")}_${get_env("OS_USER_DOMAIN_NAME")}_${path_relative_to_include()}_${basename(get_repo_root())}/lock"
        unlock_address = "${get_env("GITLAB_STATE_REPOSITORY")}/${get_env("OS_PROJECT_NAME")}_${get_env("OS_USER_DOMAIN_NAME")}_${path_relative_to_include()}_${basename(get_repo_root())}/lock"
        username       = "${get_env("GITLAB_USERNAME")}"
        password       = "${get_env("CR_GITLAB_ACCESS_TOKEN")}"
        lock_method    = "POST"
        unlock_method  = "DELETE"
        retry_wait_min = "5"
    }
}
