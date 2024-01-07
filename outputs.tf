output "vpc_id" {
  value = aws_vpc.tf_vpc.id
}

output "public_subnet_ids" {
  value = tomap({for k,sub in aws_subnet.public_subnet :  k => sub.id })
}

output "private_subnet_ids" {
  value = tomap({for k,sub in aws_subnet.private_subnet : k => sub.id})
}

output "public_route_table_id" {
  value = aws_route_table.public_route_table[0].id
}

output "private_route_table_id" {
  value = tomap({for k,rid in aws_route_table.private_route_table : k => rid.id})
}