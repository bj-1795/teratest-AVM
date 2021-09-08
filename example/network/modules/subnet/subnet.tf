resource "aws_subnet" "subnet" {
  availability_zone       = var.subnet_az
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id                  = var.vpc_id
  tags = merge(
    {
      Name = var.subnet_name
    },
    var.tags
  )
}

resource "aws_route_table_association" "subnet_association_rt" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = var.route_table_id
}