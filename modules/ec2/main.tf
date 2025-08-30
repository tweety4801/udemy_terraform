resource "aws_instance" "this" {
  ami           = "ami-0b828c1c5ac3f13ee"
  instance_type = "t2.micro"

  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.this.id]
  associate_public_ip_address = true

  user_data                   = file("${path.module}/user_data.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "udemy-terraform-ec2"
  }
}

resource "random_id" "this" {
  byte_length = 8
}

data "aws_subnet" "this" {
  id = var.subnet_id
}

resource "aws_security_group" "this" {
  name   = "udemy-terraform-ec2-sg-${random_id.this.hex}"
  vpc_id = data.aws_subnet.this.vpc_id
}

resource "aws_security_group_rule" "ssh" {
  count = var.allow_ssh ? 1 : 0

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

#ec2とalbがお互いにセキュリティグループのidを参照しあうと、プログラム的によくないので
#ec2のセキュリティグループのidをoutputしたものをdevのmain.tfのalbで設定しているので
# 以下８行はきりとってmodules/alb/main.tfにはりつける
# resource "aws_security_group_rule" "http" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.this.id
# }

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}
