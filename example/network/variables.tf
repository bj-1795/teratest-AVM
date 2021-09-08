variable "subnet_values" {
  description = "Values for subnet to be created"
}

variable "region" {
  description = "Region in which subnet will be created"
}

variable "tg_subnets" {
  description = "CIDRs range for the subnets to be attached to transit gateway"
}

variable "subnet_az" {
  description = "Availability zones in which subnet will be created"
}


variable "vpc_name" {
  description = "Name tag for the VPC to be created"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
}

variable "secondary_cidr" {
  description = "The secondary CIDR block for the VPC."
  type        = list(any)
}

variable "transit_gateway_id" {
  description = "Transit gateway Id to be attached to routetable"
}

variable "tags" {
  description = "A map of tags to add to all reosurces"
  type        = map(string)
  default     = {}
}
