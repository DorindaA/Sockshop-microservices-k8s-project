# Create Public Subunet 1
resource "aws_subnet" "dori_pub_sn1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.doripubsub1_cidr
  availability_zone = "eu-west-1a"

  tags = {
    Name = "dori_pub_sn1"
  }
}

# Create Public Subnet 2
resource "aws_subnet" "dori_pub_sn2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.doripubsub2_cidr
  availability_zone = "eu-west-1b"

  tags = {
    Name = "dori_pub_sn2"
  }
}

# Create Private Subnet 1
resource "aws_subnet" "dori_prv_sn1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.doriprvsub1_cidr
  availability_zone = "eu-west-1a"

  tags = {
    Name = "dori_prv_sn1"
  }
}

# Create Private Subnet 2
resource "aws_subnet" "dori_prv_sn2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.doriprvsub2_cidr
  availability_zone = "eu-west-1b"

  tags = {
    Name = "dori_prv_sn2"
  }
}

# Craete Internet Gateway
resource "aws_internet_gateway" "dori_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "dori_igw"
  }
}

# Create Elastic IP for NAT Gateway
resource "aws_eip" "dori_nat_eip" {
  vpc = true

  tags = {
    Name = "dori_nat_eip"
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "dori_ngw" {
  allocation_id = aws_eip.dori_nat_eip.id
  subnet_id     = aws_subnet.dori_pub_sn1.id

  tags = {
    Name = "dori_ngw"
  }
  # Explicit Dependency
  depends_on = [aws_internet_gateway.dori_igw]
}

# Create Route-Table for Public Subnet
resource "aws_route_table" "dori_pub_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.all_ip
    gateway_id = aws_internet_gateway.dori_igw.id
  }
}

# Create Route-Table for Private Subnet
resource "aws_route_table" "dori_prv_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = var.all_ip
    nat_gateway_id = aws_nat_gateway.dori_ngw.id
  }
}

# Create Route-Table Association for Public Subnet 1
resource "aws_route_table_association" "dori_pub_sub_rt_as1" {
  subnet_id      = aws_subnet.dori_pub_sn1.id
  route_table_id = aws_route_table.dori_pub_rt.id
}
# Create Route-Table Association for Public Subnet 2
resource "aws_route_table_association" "dori_pub_sub_rt_as2" {
  subnet_id      = aws_subnet.dori_pub_sn2.id
  route_table_id = aws_route_table.dori_pub_rt.id
}

# Create Route-Table Association for Private Subnet 1
resource "aws_route_table_association" "dori_prv_sub_rt_as1" {
  subnet_id      = aws_subnet.dori_prv_sn1.id
  route_table_id = aws_route_table.dori_prv_rt.id
}

# Create Route-Table Association for Private Subnet 2
resource "aws_route_table_association" "dori_prv_sub_rt_as2" {
  subnet_id      = aws_subnet.dori_prv_sn2.id
  route_table_id = aws_route_table.dori_prv_rt.id
}