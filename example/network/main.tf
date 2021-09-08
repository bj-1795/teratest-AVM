locals {
  cidr_map = flatten([for i in var.subnet_values : [
    for j in i.cidr : {
      cidr             = j
      subnet_name      = i.subnet_name
      route_table_name = i.subnet_name
    }
    ]
  ])
  cidr = { for cidr in toset(local.cidr_map) : cidr.cidr => cidr }
}

module "Xplatform_vpc" {
  source               = "./modules/vpc/"
  name                 = var.vpc_name
  cidr_block           = var.cidr_block
  secondary_cidr       = var.secondary_cidr
  enable_dns_support   = true
  enable_dns_hostnames = false
  enable_classiclink   = false
  tags                 = var.tags
}


module "transit_gateway_attachment" {
  source             = "./modules/gateway_attachment/"
  subnet_ids         = [for i in var.tg_subnets : module.Xplatform_subnet[i].subnet_ids]
  name               = var.vpc_name
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = module.Xplatform_vpc.vpc_id
  tags               = var.tags
  depends_on = [
    module.Xplatform_subnet
  ]
}

module "routes" {
  source                 = "./modules/routes/"
  for_each               = toset([for i in var.subnet_values : i.subnet_name])
  route_table_id         = module.Xplatform_route_table[each.value].id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = var.transit_gateway_id
  depends_on = [
    module.transit_gateway_attachment
  ]
}

module "Xplatform_route_table" {
  source   = "./modules/route_table/"
  for_each = toset([for i in var.subnet_values : i.subnet_name])
  name     = each.value
  vpc_id   = module.Xplatform_vpc.vpc_id
  tags     = var.tags
}

module "Xplatform_subnet" {
  source                  = "./modules/subnet/"
  for_each                = { for cidr in local.cidr_map : cidr.cidr => cidr }
  vpc_id                  = module.Xplatform_vpc.vpc_id
  subnet_name             = "${each.value.subnet_name}-${element(var.subnet_az, index(keys(local.cidr), each.key))}"
  subnet_cidr             = each.key
  subnet_az               = "${var.region}${element(var.subnet_az, index(keys(local.cidr), each.key))}"
  route_table_id          = module.Xplatform_route_table[each.value.subnet_name].id
  map_public_ip_on_launch = false
  tags                    = var.tags
  depends_on = [
    module.Xplatform_vpc
  ]
}
