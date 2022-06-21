# Create VPC
resource "aws_vpc" "wordpress-vpc" {
  cidr_block           = var.VPC_cidr
  enable_dns_support   = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
  instance_tenancy     = "default"


}

# Create Public Subnet for EC2
resource "aws_subnet" "public-1" {
  vpc_id                  = aws_vpc.wordpress-vpc.id
  cidr_block              = var.subnet1_cidr
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = var.AZ1

}

# Create Public Subnet for EC2
resource "aws_subnet" "public-2" {
  vpc_id                  = aws_vpc.wordpress-vpc.id
  cidr_block              = var.subnet2_cidr
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = var.AZ2

}

# Create Private subnet for RDS
resource "aws_subnet" "private-1" {
  vpc_id                  = aws_vpc.wordpress-vpc.id
  cidr_block              = var.subnet3_cidr
  map_public_ip_on_launch = "false" //it makes private subnet
  availability_zone       = var.AZ1

}

# Create second Private subnet for RDS
resource "aws_subnet" "private-2" {
  vpc_id                  = aws_vpc.wordpress-vpc.id
  cidr_block              = var.subnet4_cidr
  map_public_ip_on_launch = "false" //it makes private subnet
  availability_zone       = var.AZ2

}

# Create IGW for internet connection
resource "aws_internet_gateway" "wordpress-igw" {
  vpc_id = aws_vpc.wordpress-vpc.id

}

# Creating Route table
resource "aws_route_table" "wordpress-public-crt" {
  vpc_id = aws_vpc.wordpress-vpc.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.wordpress-igw.id
  }


}


# Associating route tabe to public subnet
resource "aws_route_table_association" "wordpress-crta-public-subnet-1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.wordpress-public-crt.id
}
# Associating route tabe to public subnet
resource "aws_route_table_association" "wordpress-crta-public-subnet-2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.wordpress-public-crt.id
}
