resource "aws_instance" "ms_web_server" {
  #ami           = data.aws_ami.ubuntu.id
  ami = "${lookup(var.AMIS, var.AWS_REGION)}" #selects the AMI based on AWS region
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "${var.KEY_PAIR}"
  user_data = file("user-data.sh")

  tags = {
    Name = "MS_Server"
  }
}

resource "aws_key_pair" "terraformawskey" {
  key_name   = "terraformawskey"
  public_key = file("${var.PUB_KEY}")
}