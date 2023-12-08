
resource "aws_vpc" "Ease-VPC" {

  cidr_block       = var.vpc-cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "Ease-VPC"
  }
}

resource "aws_internet_gateway" "Ease-IGW" {

  tags = {
    Name = "Ease-IGW"
  }
}

resource "aws_internet_gateway_attachment" "IGW_ATTACHMNET" {
  internet_gateway_id = aws_internet_gateway.Ease-IGW.id
  vpc_id              = aws_vpc.Ease-VPC.id

}

resource "aws_subnet" "Ease-PUB-SUBNET-1a" {
  vpc_id            = aws_vpc.Ease-VPC.id
  availability_zone = var.public-subnet-1a-az
  cidr_block        = var.public-subnet-1a-cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "Ease-PUB-SUBNET-1a"
  }
}

resource "aws_subnet" "Ease-PUB-SUBNET-1b" {
  vpc_id            = aws_vpc.Ease-VPC.id
  availability_zone = var.public-subnet-1b-az
  cidr_block        = var.public-subnet-1b-cidr
    map_public_ip_on_launch = true

  tags = {
    Name = "Ease-PUB-SUBNET-1b"
  }
}

resource "aws_route_table" "Ease-PUB-RT" {
  vpc_id = aws_vpc.Ease-VPC.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Ease-IGW.id
  }

  tags = {
    Name = "Ease-PUB-RT"
  }
}


resource "aws_route_table_association" "Ease-RT-PUB-ASS-1a" {

  subnet_id      = aws_subnet.Ease-PUB-SUBNET-1a.id
  route_table_id = aws_route_table.Ease-PUB-RT.id
}

resource "aws_route_table_association" "Ease-RT-PUB-ASS-1b" {

  subnet_id      = aws_subnet.Ease-PUB-SUBNET-1b.id
  route_table_id = aws_route_table.Ease-PUB-RT.id
}



resource "aws_security_group" "Ease-Security-Group" {
  name        = "Ease-Security-Group"
  vpc_id      = aws_vpc.Ease-VPC.id

 ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Ease-Security-Group"
  }
}