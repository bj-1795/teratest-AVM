variable "subnet_az" {
  description = "Availability zone for subnet"
}

variable "subnet_cidr" {
  description = "CIDR range for subnets to be created"
}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the public subnet should be assigned a public IP address"
  type        = string
  default     = false
}

variable "subnet_name" {
  description = "Name of the subnet to be added in tags"
}

variable "vpc_id" {
  description = "The VPC id for subnet creation"
  type        = string
}

variable "route_table_id" {
  description = "Route table id for subnet association"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
