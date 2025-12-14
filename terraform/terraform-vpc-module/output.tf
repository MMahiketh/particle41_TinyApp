output "vpc_id" {
  value = aws_vpc.main.id
}

output "igw_id" {
  value = aws_internet_gateway.main.id
}


# for debugging
output "all_azs_info" {
  value = data.aws_availability_zones.all_azs
}

output "selected_azs" {
  value = local.selected_azs_names
}

output "az1_subnet_cidrs" {
  value = var.subnet_cidrs[0]
}

output "az2_subnet_cidrs" {
  value = var.subnet_cidrs[1]
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "eip_ip_address" {
  value = aws_eip.main.public_ip
}

output "nat_id" {
  value = aws_nat_gateway.main.id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

output "public_route_id" {
  value = aws_route.public.id
}

output "private_route_id" {
  value = aws_route.private.id
}

output "public_route_association_id" {
  value = aws_route_table_association.public[*].id
}

output "private_route_association_id" {
  value = aws_route_table_association.private[*].id
}