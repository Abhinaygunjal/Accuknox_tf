resource "aws_vpc" "arch_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "Accuknox_public" {
depends_on = [ aws_vpc.arch_vpc ]
  vpc_id = aws_vpc.arch_vpc.id
  cidr_block = var.pub_cidr_block
  availability_zone = "us-east-2a"
  tags = {
    Name = var.pub_subnet_name
  }
}

resource "aws_subnet" "Accuknox_private" {
    depends_on = [ aws_vpc.arch_vpc ]
  vpc_id = aws_vpc.arch_vpc.id
  cidr_block = var.priv_cidr_block
  availability_zone = "us-east-2b"
  tags = {
    Name = var.priv_subnet_name
  }
}

resource "aws_internet_gateway" "Accuknox_ig" {
    depends_on = [ aws_subnet.Accuknox_public ]
  vpc_id = aws_vpc.arch_vpc.id
  tags = {
    Name = var.ig_name
  }
}

resource "aws_route_table" "public_subnet_rt" {
    depends_on = [ aws_subnet.Accuknox_public ]
  vpc_id = aws_vpc.arch_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Accuknox_ig.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.Accuknox_public.id
  route_table_id = aws_route_table.public_subnet_rt.id
}

resource "aws_security_group" "Accuknox_sg" {
    depends_on = [ aws_subnet.Accuknox_private ]
  name   = "HTTP and SSH"
  vpc_id = aws_vpc.arch_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}