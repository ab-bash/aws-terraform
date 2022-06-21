# Create EIP for NAT GW1
resource "aws_eip" "eip_natgw1" {
     count = "1"
} 

# Create NAT gateway1
resource "aws_nat_gateway" "natgateway" {
     count         = "1"
     allocation_id = aws_eip.eip_natgw1[count.index].id
     subnet_id     = aws_subnet.public-1.id
}

# Create private route table for prv sub1
resource "aws_route_table" "prv_rt" {
  count  = "1"
  vpc_id = aws_vpc.wordpress-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway[count.index].id
  }
  tags = {
    Name = "private route table"
 }
}

# Create route table association betn prv sub1 & NAT GW1
resource "aws_route_table_association" "pri_sub1_to_natgw1" {
  count          = "1"
  route_table_id = aws_route_table.prv_rt[count.index].id
  subnet_id      = aws_subnet.private-1.id
}

# Create private route table for prv sub2
resource "aws_route_table" "prv_sub2_rt" {
  count  = "1"
  vpc_id = aws_vpc.wordpress-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgateway[count.index].id
  }
  tags = {
    Name = "private subnet2 route table"
  }
}

# Create route table association betn prv sub2 & NAT GW2
resource "aws_route_table_association" "pri_sub2_to_natgw1" {
  count          = "1"
  route_table_id = aws_route_table.prv_sub2_rt[count.index].id
  subnet_id      = aws_subnet.private-2.id
}
