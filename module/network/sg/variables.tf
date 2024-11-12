variable "name" {
  type    = string
  default = ""
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "ssh_port" {
  type    = string
  default = ""
}

variable "my_ip" {
  type    = list(string)
  default = []
}
