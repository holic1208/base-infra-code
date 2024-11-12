#########################
####       vpc       ####
#########################

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = format("${var.name}-%s", "vpc")
  }
}

#########################
####    subnet       ####
#########################

resource "aws_subnet" "public" {
  count = length(var.azs)

  vpc_id                  = aws_vpc.main.id
  availability_zone       = element(var.azs, count.index)
  cidr_block              = var.pub_subnet[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = format("${var.name}-%s-%s",
      "pub", substr(var.azs[count.index], length(var.azs[count.index]) - 1, 1)
    ),
    "kubernetes.io/role/elb" = 1
  }
}

#########################
####    gateway      ####
#########################

resource "aws_internet_gateway" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = format("${var.name}-%s", "igw")
  }
}

#########################
####   route table   ####
#########################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Nmae = format("${var.name}-%s-%s", "pub", "rt")
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.public.id
}

resource "aws_route_table_association" "name" {
  count = length(var.pub_subnet)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
