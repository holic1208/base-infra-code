variable "name" {
  type    = string
  default = ""
}

variable "vpc_cidr_block" {
  type    = string
  default = ""
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "azs" {
  type    = list(string)
  default = []
}

variable "pub_subnet" {
  type    = list(string)
  default = []
}
