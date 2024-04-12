output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_2a_id" {
  value = aws_subnet.pub_sub_2a.id
}

output "public_subnet_2b_id" {
  value = aws_subnet.pub_sub_2b.id
}

output "private_subnet_2a_id" {
  value = aws_subnet.pri_sub_2a.id
}

output "private_subnet_2b_id" {
  value = aws_subnet.pri_sub_2b.id
}

output "internet_gateway"{
    value = "${var.project_name}-igw"
}
