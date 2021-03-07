resource "aws_instance" "public" {
  ami                    = "ami-0915bcb5fa77e4892"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  key_name               = "test_user"
  vpc_security_group_ids = [aws_security_group.public.id]
  user_data = templatefile("./templates/user_data.sh", {
    server_info    = "Public instance"
    next_server_ip = aws_instance.private[0].private_ip
  })
}

resource "aws_eip" "public-instance" {
  instance = aws_instance.public.id
}

resource "aws_security_group" "public" {
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
    cidr_blocks = ["41.45.21.188/32"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["41.45.21.188/32"]
  }
}
