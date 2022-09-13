resource "aws_lb" "alb-01" {
  name               = "alb-01"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = [aws_subnet.public-subnet-01.id, aws_subnet.public-subnet-02.id, aws_subnet.public-subnet-03.id]

  enable_deletion_protection = false
  depends_on = [
    aws_lb_target_group.alb-tg-01
  ]
}

resource "aws_lb_listener" "alb-01-listener" {
  load_balancer_arn = aws_lb.alb-01.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-01.arn
  }
}


resource "aws_lb_target_group" "alb-tg-01" {
  name     = "msvpc-lb-tg-01"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 120
    interval            = 125
    matcher             = 200
    path                = "/"
    port                = 80
  }
  stickiness {
    type = "lb_cookie"
    cookie_duration = 86400
  }
}



resource "aws_lb" "alb-02" {
  name               = "alb-02"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.private-alb-sg.id]
  subnets            = [aws_subnet.app-private-subnet-01.id, aws_subnet.app-private-subnet-02.id, aws_subnet.app-private-subnet-03.id]

  enable_deletion_protection = false
  depends_on = [
    aws_lb_target_group.alb-tg-02
  ]
}

resource "aws_lb_listener" "alb-02-listener" {
  load_balancer_arn = aws_lb.alb-02.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg-02.arn
  }
}


resource "aws_lb_target_group" "alb-tg-02" {
  name     = "msvpc-lb-tg-02"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 120
    interval            = 300
    matcher             = 200
    path                = "/"
    port                = 80
  }
  stickiness {
    type = "lb_cookie"
    cookie_duration = 86400
  }
}