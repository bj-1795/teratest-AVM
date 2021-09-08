resource "aws_vpc" "main" {
  cidr_block                     = var.cidr_block
  instance_tenancy               = var.instance_tenancy
  enable_dns_support             = var.enable_dns_support
  enable_dns_hostnames           = var.enable_dns_hostnames
  enable_classiclink             = var.enable_classiclink
  enable_classiclink_dns_support = var.enable_classiclink_dns_support
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags,
  )
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  count      = length(var.secondary_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.secondary_cidr, count.index)
}
