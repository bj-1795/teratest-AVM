variable "transit_gateway_id" {
  description = "Transit gateway id to be attached to the VPC"
}

variable "subnet_ids" {
  description = "Subnet ids for transit gateway attachment"
}

variable "name" {
  description = "Name of the transit gateway attachment to be added in tags"
}
variable "vpc_id" {
  description = "The VPC id for transit gateway attachment"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}