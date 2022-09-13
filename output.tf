output "DB-ADDRESS" {
  value = aws_db_instance.mysql-db.address
}

output "PUBLIC-ALB" {
  value = aws_lb.alb-01.dns_name
}

output "PRIVATE-ALB" {
  value = aws_lb.alb-02.dns_name
}