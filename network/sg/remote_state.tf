data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "backend-base-infra-code"
    key    = "network/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
