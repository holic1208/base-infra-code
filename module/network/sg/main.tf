#########################
####    admin sg     ####
#########################

resource "aws_security_group" "admin_sg" {
  name   = format("${var.name}-%s-%s", "admin", "sg")
  vpc_id = var.vpc_id

  tags = {
    Name = format("${var.name}-%s-%s", "admin", "sg")
  }
}

resource "aws_security_group_rule" "admin_sg_rule_1" {
  type              = "ingress"
  from_port         = var.ssh_port
  to_port           = var.ssh_port
  protocol          = "tcp"
  cidr_blocks       = var.my_ip
  security_group_id = aws_security_group.admin_sg.id
  description       = "ssh connection for adminhost"
}

resource "aws_security_group_rule" "admin_sg_rule_2" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.admin_sg.id
  description       = "egress http"
}

resource "aws_security_group_rule" "admin_sg_rule_3" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.admin_sg.id
  description       = "egress https"
}

#########################
####    node sg      ####
#########################

resource "aws_security_group" "node_sg" {
  name   = format("${var.name}-%s-%s", "node", "sg")
  vpc_id = var.vpc_id

  tags = {
    Name = format("${var.name}-%s-%s", "node", "sg")
  }
}

resource "aws_security_group_rule" "node_sg_rule_1" {
  type                     = "ingress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.eks_sg.id
  security_group_id        = aws_security_group.node_sg.id
  description              = "Allow pod communication"
}

resource "aws_security_group_rule" "node_sg_rule_2" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.eks_sg.id
  security_group_id        = aws_security_group.node_sg.id
  description              = "API communication for eks cluster"
}

resource "aws_security_group_rule" "node_sg_rule_3" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  self              = true
  security_group_id = aws_security_group.node_sg.id
  description       = "communication for worker group each other"
}

resource "aws_security_group_rule" "node_sg_rule_4" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.node_sg.id
  description       = "egress all"
}

#########################
####    eks sg       ####
#########################

resource "aws_security_group" "eks_sg" {
  name   = format("${var.name}-%s-%s", "eks", "sg")
  vpc_id = var.vpc_id

  tags = {
    Name = format("${var.name}-%s-%s", "eks", "sg")
  }
}

resource "aws_security_group_rule" "eks_sg_rule_1" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.admin_sg.id
  security_group_id        = aws_security_group.eks_sg.id
  description              = "communication for adminhost"
}

resource "aws_security_group_rule" "eks_sg_rule_2" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.node_sg.id
  security_group_id        = aws_security_group.eks_sg.id
  description              = "communication for worker node"
}
