output "admin_sg_id" {
  value = aws_security_group.admin_sg.id
}

output "node_sg_id" {
  value = aws_security_group.node_sg.id
}

output "eks_sg_id" {
  value = aws_security_group.eks_sg.id
}
