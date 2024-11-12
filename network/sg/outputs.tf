output "admin_sg_id" {
  value = module.sg.admin_sg_id
}

output "node_sg_id" {
  value = module.sg.node_sg_id
}

output "eks_sg_id" {
  value = module.sg.eks_sg_id
}
