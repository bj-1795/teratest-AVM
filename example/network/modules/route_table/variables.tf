variable "vpc_id" {
  description = "VPC id of the the VPC where Route Table To be created "
}

variable "name" {
  description = "Name of Route Table To be created "
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
