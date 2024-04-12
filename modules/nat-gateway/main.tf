# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet 2a
resource "aws_eip" "eip_for_nat_gateway_2a" {
  vpc    = true

  tags   = {
    Name = "nat gateway 2a eip"
  }
}

# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet 2b
resource "aws_eip" "eip_for_nat_gateway_2b" {
  vpc    = true

  tags   = {
    Name = "nat gateway 2b eip"
  }
} 

# create nat gateway in public subnet az1
resource "aws_nat_gateway" "nat_gateway_2a" {
  allocation_id = aws_eip.eip_for_nat_gateway_2a.id
  subnet_id     = var.public_subnet_2a_id

  tags   = {
    Name ="nat gateway 2a"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.internet_gateway]
}

# create nat gateway in public subnet 2b
resource "aws_nat_gateway" "nat_gateway_2b" {
  allocation_id = aws_eip.eip_for_nat_gateway_2b.id
  subnet_id     = var.public_subnet_2b_id

  tags   = {
    Name = "nat gateway 2b"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.internet_gateway]
}

# create private route table az1 and add route through nat gateway az1
resource "aws_route_table" "private_route_table_2a" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_2a.id
  }

  tags   = {
    Name = "private route table for 2a"
  }
}

# associate private data subnet 2a with private route table 2a
resource "aws_route_table_association" "private_subnet_2a_route_table_2a_association" {
  subnet_id         = var.private_subnet_2a_id
  route_table_id    = aws_route_table.private_route_table_2a.id
}

# create private route table az2 and add route through nat gateway az2
resource "aws_route_table" "private_route_table_2b" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway_2b.id
  }

  tags   = {
    Name = "private route table for 2b"
  }
}

# associate private data subnet az2 with private route table az2
resource "aws_route_table_association" "private_subnet_2b_route_table_2b_association" {
  subnet_id         = var.private_subnet_2b_id
  route_table_id    = aws_route_table.private_route_table_2b.id
}
