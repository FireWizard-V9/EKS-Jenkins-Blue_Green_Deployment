resource "aws_vpc" "bg" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "blue-green-vpc"
  }
}

resource "aws_subnet" "bg_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.bg.id
  cidr_block              = cidrsubnet(aws_vpc.bg.cidr_block, 8, count.index)
  availability_zone       = element(["us-east-1a", "us-east-1b"], count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Blue-Green-Subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "bg-igw" {
  vpc_id = aws_vpc.bg.id

  tags = {
    Name = "Blue-Green-IGW"
  }
}

resource "aws_route_table" "bg-rt" {
  vpc_id = aws_vpc.bg.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bg-igw.id
  }

  tags = {
    Name = "Blue-Green-RT"
  }
}

resource "aws_route_table_association" "a" {
  count          = 2
  subnet_id      = aws_subnet.bg_subnet[count.index].id
  route_table_id = aws_route_table.bg-rt.id
}
