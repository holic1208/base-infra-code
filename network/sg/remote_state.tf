data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "sangun-admin"

    workspaces = {
      name = "base-infra-code_network_vpc"
    }
  }
}
