resource "aws_launch_template" "lt-01" {
  name     = "lt-01"
  key_name = var.KEY_PAIR

  # #Enabling monitoring turns on detailed monitoring, which has a cost attached
  #   monitoring {
  #     enabled = true
  #   }

  vpc_security_group_ids = ["${aws_security_group.web-tier-sg.id}", "${aws_security_group.ssh-sg.id}"]
  instance_type          = "t2.micro"
  image_id               = data.aws_ami.web-server-ami.id

  ##This enables me to use the private load balancer dns name in userdata script
  user_data = base64encode(templatefile("userdata.sh", local.vars))

  depends_on = [
    aws_db_instance.mysql-db
  ]
}

locals {
  vars = {
    private_alb_dns = aws_lb.alb-02.dns_name
  }
}



resource "aws_launch_template" "lt-02" {
  name     = "lt-02"
  key_name = var.KEY_PAIR

  # #Enabling monitoring turns on detailed monitoring, which has a cost attached
  #   monitoring {
  #     enabled = true
  #   }

  vpc_security_group_ids = ["${aws_security_group.app-tier-sg.id}", "${aws_security_group.ssh-sg.id}"]
  instance_type          = "t2.micro"
  image_id               = data.aws_ami.app-server-ami.id

  ##This enables me to use the database address and other variables in userdata script
  user_data = base64encode(templatefile("user-data.sh", {
    db_address = local.db_address
    admin_user = local.admin_user
    admin_password = local.admin_password
  } ))

  depends_on = [
    aws_db_instance.mysql-db
  ]
}

locals {
  db_address = aws_db_instance.mysql-db.address
  admin_user = "${var.USERNAME}"
  admin_password = "${var.PASSWORD}"
}