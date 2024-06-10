resource "aws_instance" "EC2" {
  ami = "ami-09040d770ffe2224f"
  instance_type = "t2.small"
  subnet_id = var.subnet_id
  security_groups = var.security_groups
  tags = {
    Name: var.ec2_name
  }
  associate_public_ip_address = false
}