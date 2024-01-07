resource "aws_vpc" "tf_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = var.vpc_tags
}

resource "aws_subnet" "public_subnet" {
  for_each = length(var.public_subnet_details) > 0 ? var.public_subnet_details : {}


  cidr_block              = each.value.public_subnet_cidr
  availability_zone       = each.value.public_subnet_az
  vpc_id                  = aws_vpc.tf_vpc.id
  map_public_ip_on_launch = true

  tags = each.value.public_subnet_tags

}

resource "aws_subnet" "private_subnet" {
  for_each = length(var.private_subnet_details) > 0 ? var.private_subnet_details : {}


  cidr_block              = each.value.private_subnet_cidr
  availability_zone       = each.value.private_subnet_az
  vpc_id                  = aws_vpc.tf_vpc.id
  map_public_ip_on_launch = false

  tags = each.value.private_subnet_tags
}

resource "aws_internet_gateway" "tf_igw" {
  count = length(aws_subnet.public_subnet) > 0 ? 1 : 0

  vpc_id = aws_vpc.tf_vpc.id

}

resource "aws_route_table" "public_route_table" {
  count = length(aws_subnet.public_subnet) > 0 ? 1 : 0

  vpc_id = aws_vpc.tf_vpc.id

  tags = var.public_route_table_tags

}
resource "aws_route_table_association" "public_subnet_association" {
  route_table_id = aws_route_table.public_route_table[0].id
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
}

resource "aws_route_table" "private_route_table" {
  for_each = length(aws_subnet.private_subnet) > 0 ? aws_subnet.private_subnet : {}

  vpc_id = aws_vpc.tf_vpc.id

  tags = merge({Name = "Route For - ${each.key}"},var.private_route_table_tags)


}

resource "aws_route_table_association" "private_subnet_association" {
  for_each = aws_subnet.private_subnet

  route_table_id = aws_route_table.private_route_table[each.key].id
  subnet_id      = each.value.id
}
