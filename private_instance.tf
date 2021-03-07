resource "aws_instance" "private" {
  count = 63

  ami                    = "ami-0915bcb5fa77e4892"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private.id
  key_name               = "test_user"
  vpc_security_group_ids = [aws_security_group.private.id]
  private_ip             = "10.0.0.${count.index + 133}"
  user_data = templatefile("./templates/user_data.sh", {
    server_info    = "10.0.0.${count.index + 133}"
    next_server_ip = "10.0.0.${count.index + 133 + 1}"
  })
}

resource "aws_security_group" "private" {
  vpc_id = aws_vpc.main.id

  // Outgoing
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }

  // Incoming
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"]
  }
}
