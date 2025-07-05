output "cluster_name" {
  value = module.eks.cluster_name
}

output "region" {
  value = "ap-southeast-1"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
