resource "aws_vpc" "vpc_tf" {
  cidr_block           = var.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  enable_classiclink   = var.enable_classiclink
  tags = {
    Name = var.tags
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_tf.id
  tags = {
    Name = "internet-gateway-tf"
  }
}

resource "aws_subnet" "app" {
  availability_zone       = "us-east-2a"
  vpc_id                  = aws_vpc.vpc_tf.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.1.0/24"
  tags = {
    Name = "app-tf"
  }
}

resource "aws_route_table" "route-public" {
  vpc_id = aws_vpc.vpc_tf.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "public-route-table-tf"
  }
}

resource "aws_route_table_association" "app" {
  subnet_id      = aws_subnet.app.id
  route_table_id = aws_route_table.route-public.id
}

resource "aws_subnet" "db" {
  vpc_id                  = aws_vpc.vpc_tf.id
  map_public_ip_on_launch = false
  cidr_block              = "10.0.2.0/24"
  tags = {
    Name = "db-tf"
  }
}

resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "nat-gw-eip-tf"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.app.id
  depends_on    = [aws_internet_gateway.gw]
}

resource "aws_route_table" "route_private" {
  vpc_id = aws_vpc.vpc_tf.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "private-route-table-tf"
  }
}

resource "aws_route_table_association" "db" {
  subnet_id      = aws_subnet.db.id
  route_table_id = aws_route_table.route_private.id
}
