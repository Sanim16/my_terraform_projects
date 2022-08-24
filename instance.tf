resource "aws_instance" "ms_web_server" {
  #ami           = data.aws_ami.ubuntu.id
  ami = "ami-0a24ce26f4e187f9a"
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
  public_key = file("~/.ssh/terraformawskey.pub")
}