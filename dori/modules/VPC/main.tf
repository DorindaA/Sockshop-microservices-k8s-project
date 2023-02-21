# Create VPC
resource "aws_vpc" "dori_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "dori_vpc"
  }
}