resource "aws_vpc" "vpc" {
    
  cidr_block            = var.cidr
  instance_tenancy      = "default"
  enable_dns_hostnames  = true
  enable_dns_support    = true

  tags = {
    name= "${var.project_name}-vpc" 
    
  }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id

    tags = {
      name = "${var.project_name}-igw"
    }
  
}

data "aws_availability_zones" "availability_zones" {}

resource "aws_subnet" "pub_sub_2a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pub_sub_2a
    availability_zone = data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch = true
  
  tags = {
    Name = "pub_sub_2a"
  }
}


resource "aws_subnet" "pub_sub_2b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pub_sub_2b
    availability_zone = data.aws_availability_zones.availability_zones.names[1]
    map_public_ip_on_launch = true

    tags = {
      name = "pub_sub_2b"
    }
  
}

resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.vpc.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }  
    tags = {
        name = "public_rt"
    }
}

resource "aws_route_table_association" "pub_sub_2a_rt_assoc" {
    subnet_id = aws_subnet.pub_sub_2a.id
    route_table_id = aws_route_table.route_table.id

}

resource "aws_route_table_association" "pub_sub_2b_rt_assoc" {
    subnet_id = aws_subnet.pub_sub_2b.id
    route_table_id = aws_route_table.route_table.id  
}

resource "aws_subnet" "pri_sub_2a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pri_sub_2a
    availability_zone = data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch = true
  
  tags = {
    Name = "pri_sub_2a"
  }
}


resource "aws_subnet" "pri_sub_2b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pub_sub_2b
    availability_zone = data.aws_availability_zones.availability_zones.names[1]
    map_public_ip_on_launch = true

    tags = {
      name = "pri_sub_2b"
    }
  
}