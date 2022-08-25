output "IP" {
  value = aws_instance.ms_web_server.public_ip
  description = "The public IP of the instance"
}