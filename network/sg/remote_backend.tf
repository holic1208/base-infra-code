terraform {
  backend "s3" {
    bucket         = "backend-base-infra-code"
    key            = "network/sg/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-lock-table"
  }
}
