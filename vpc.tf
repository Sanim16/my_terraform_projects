resource "aws_vpc" "main" {
  cidr_block       = "${var.VPC_CIDR}"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.PROJECT_NAME}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.PROJECT_NAME}-igw"
  }
}

resource "aws_route_table" "rt-1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.PROJECT_NAME}-rt-1"
  }
}

resource "aws_route_table_association" "rt-1a" {
  subnet_id      = aws_subnet.public-subnet-01.id
  route_table_id = aws_route_table.rt-1.id
}

resource "aws_route_table_association" "rt-2a" {
  subnet_id      = aws_subnet.public-subnet-02.id
  route_table_id = aws_route_table.rt-1.id
}

resource "aws_route_table_association" "rt-3a" {
  subnet_id      = aws_subnet.public-subnet-03.id
  route_table_id = aws_route_table.rt-1.id
}

resource "aws_subnet" "public-subnet-01" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "${var.PROJECT_NAME}-public-subnet-01"
  }
}

resource "aws_subnet" "public-subnet-02" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "${var.PROJECT_NAME}-public-subnet-02"
  }
}

resource "aws_subnet" "public-subnet-03" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"

  tags = {
    Name = "${var.PROJECT_NAME}-public-subnet-03"
  }
}










resource "aws_route_table" "rt-2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw-1.id
  }

  tags = {
    Name = "${var.PROJECT_NAME}-rt-2"
  }
}

resource "aws_route_table_association" "rt-app-1a" {
  subnet_id      = aws_subnet.app-private-subnet-01.id
  route_table_id = aws_route_table.rt-2.id
}

resource "aws_route_table_association" "rt-app-2a" {
  subnet_id      = aws_subnet.app-private-subnet-02.id
  route_table_id = aws_route_table.rt-2.id
}

resource "aws_route_table_association" "rt-app-3a" {
  subnet_id      = aws_subnet.app-private-subnet-03.id
  route_table_id = aws_route_table.rt-2.id
}

resource "aws_subnet" "app-private-subnet-01" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name = "${var.PROJECT_NAME}-app-private-subnet-01"
  }
}

resource "aws_subnet" "app-private-subnet-02" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name = "${var.PROJECT_NAME}-app-private-subnet-02"
  }
}

resource "aws_subnet" "app-private-subnet-03" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1c"

  tags = {
    Name = "${var.PROJECT_NAME}-app-private-subnet-03"
  }
}








# resource "aws_route_table" "rt-3" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     #nat_gateway_id = aws_nat_gateway.nat-gw-1.id
#     gateway_id = aws_internet_gateway.gw.id
#   }

#   tags = {
#     Name = "${var.PROJECT_NAME}-rt-3"
#   }
# }

# resource "aws_route_table_association" "rt-db-1a" {
#   subnet_id      = aws_subnet.db-private-subnet-01.id
#   route_table_id = aws_route_table.rt-3.id
# }

# resource "aws_route_table_association" "rt-db-2a" {
#   subnet_id      = aws_subnet.db-private-subnet-02.id
#   route_table_id = aws_route_table.rt-3.id
# }

# resource "aws_route_table_association" "rt-db-3a" {
#   subnet_id      = aws_subnet.db-private-subnet-03.id
#   route_table_id = aws_route_table.rt-3.id
# }

resource "aws_subnet" "db-private-subnet-01" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.7.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name = "${var.PROJECT_NAME}-db-private-subnet-01"
  }
}

resource "aws_subnet" "db-private-subnet-02" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.8.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name = "${var.PROJECT_NAME}-db-private-subnet-02"
  }
}

resource "aws_subnet" "db-private-subnet-03" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.9.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1c"

  tags = {
    Name = "${var.PROJECT_NAME}-db-private-subnet-03"
  }
}