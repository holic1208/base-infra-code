variable "account_id" {
  default = ["985522651362"]
}

variable "region" {
  default = "ap-northeast-2"
}

variable "vpc_cidr_block" {
  default = "172.31.0.0/16"
}

variable "enable_dns_hostnames" {
  default = true
}

variable "azs" {
  default = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c", "ap-northeast-2d"]
}

variable "sub_cidr_block" {
  default = {
    public = ["172.31.1.0/24", "172.31.3.0/24", "172.31.5.0/24", "172.31.7.0/24"]
  }
}

