resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.db-private-subnet-01.id, aws_subnet.db-private-subnet-02.id, aws_subnet.db-private-subnet-03.id]

  tags = {
    Name = "${var.PROJECT_NAME}-db-subnet-group"
  }
}

resource "aws_db_instance" "mysql-db" {
  allocated_storage    = 20  #set max_allocated_storage to a higher value to enable autoscaling
  #max_allocated_storage = 100
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  db_name              = "${var.DB_NAME}" #use a variable and store in terraform.tfvars
  username             = "${var.USERNAME}" #use a variable and store in terraform.tfvars
  password             = "${var.PASSWORD}" #use a variable and store in terraform.tfvars
  #parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  #allow_major_version_upgrade = true #disabled because im not using a nat gateway
  #availability_zone = "us-east-1a"
  apply_immediately = true
  port = 3306
  storage_type = "gp2"

  identifier             = "goals"
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
  vpc_security_group_ids = [aws_security_group.db-tier-sg.id]
  publicly_accessible    = false
  backup_retention_period = 0
  depends_on = [
    aws_db_subnet_group.db-subnet-group
  ]
}