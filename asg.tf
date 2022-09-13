resource "aws_autoscaling_group" "asg-01" {
  vpc_zone_identifier = [aws_subnet.public-subnet-01.id, aws_subnet.public-subnet-02.id, aws_subnet.public-subnet-03.id]
  name                = "asg-01"
  desired_capacity    = 1
  max_size            = 3
  min_size            = 1
  default_cooldown    = 120

  target_group_arns = [aws_lb_target_group.alb-tg-01.arn]
  health_check_type = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.lt-01.id
    version = "$Latest"
  }

  depends_on = [
    aws_launch_template.lt-01, aws_lb.alb-01
  ]
}

resource "aws_autoscaling_group" "asg-02" {
  vpc_zone_identifier = [aws_subnet.app-private-subnet-01.id, aws_subnet.app-private-subnet-02.id, aws_subnet.app-private-subnet-03.id]
  name                = "asg-02"
  desired_capacity    = 1
  max_size            = 3
  min_size            = 1
  default_cooldown    = 120

  target_group_arns = [aws_lb_target_group.alb-tg-02.arn]
  health_check_type = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.lt-02.id
    version = "$Latest"
  }

  depends_on = [
    aws_launch_template.lt-02, aws_lb.alb-02
  ]
}