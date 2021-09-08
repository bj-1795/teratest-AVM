variable "transit_gateway_id" {
  description = "Transit gateway id to be attached to the Route Table"
}

variable "destination_cidr_block" {
  description = "CIDR to which traffic will be allowed"
  type        = string
}

variable "route_table_id" {
  description = "Route table id for subnet association"
}