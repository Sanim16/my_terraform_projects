resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Allow HTTP & HTTPS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "HTTP from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTPS from everywhere"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.PROJECT_NAME}-alb-sg"
  }
}

resource "aws_security_group" "web-tier-sg" {
  name        = "web-tier-sg"
  description = "Allow traffic from ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "All from alb"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_groups = [aws_security_group.alb-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.PROJECT_NAME}-web-tier-sg"
  }
}

resource "aws_security_group" "private-alb-sg" {
  name        = "private-alb-sg"
  description = "Allow traffic from public subnet"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "All from public subnet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_groups = [aws_security_group.web-tier-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.PROJECT_NAME}-private-alb-sg"
  }
}

resource "aws_security_group" "app-tier-sg" {
  name        = "app-tier-sg"
  description = "Allow traffic from Private ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "All from private alb"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_groups = [aws_security_group.private-alb-sg.id]
  }

  ingress {
    description      = "db traffic from db"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [aws_security_group.private-alb-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.PROJECT_NAME}-app-tier-sg"
  }
}

resource "aws_security_group" "db-tier-sg" {
  name        = "db-tier-sg"
  description = "Allow traffic from App tier"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "db traffic from app tier"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = [aws_security_group.app-tier-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.PROJECT_NAME}-db-tier-sg"
  }
}

resource "aws_security_group" "ssh-sg" {
  name        = "ssh-sg"
  description = "Allow ssh traffic from my IP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "SSH traffic from my IP"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["${var.MY_IP}"]
    #security_groups = [aws_security_group.app-tier-sg.id]
  }

  ingress {
    description      = "SSH traffic from web tier for app tier"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.web-tier-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.PROJECT_NAME}-db-tier-sg"
  }
}