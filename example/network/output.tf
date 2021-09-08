output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.Xplatform_vpc.vpc_id
}

output "arn" {
  description = "The arn of the VPC"
  value       = module.Xplatform_vpc.arn
}

output "subnet_ids" {
  description = "Values for Subnet IDs to be used in other resources"
  value = [
    for i in module.Xplatform_subnet :
    i.subnet_ids
  ]
}