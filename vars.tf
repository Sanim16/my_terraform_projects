variable "AWS_CREDENTIALS" {} #empty to prevent uploading secrets
variable "VSCODE_PROFILE" {} #empty to prevent uploading secrets
variable "AWS_REGION" {
    type = string
    default = "us-east-1"
  
}
variable "AMIS" {
  type = map
  default = {
    us-east-1 = "ami-0a24ce26f4e187f9a"
    us-east-2 = "ami-0a5e8065e5b04c679"
  }
  
}
variable "KEY_PAIR" {} #empty to prevent uploading secrets
variable "PUB_KEY" {} #public key used for key pair creation
variable "PRIVATE_KEY" {} #public key used for key pair creation
#variable "AWS_KEY" {}
#variable "AWS_SECRET_KEY" {}
variable "PROJECT_NAME" {
  type = string
  default = "project"
}
variable "VPC_CIDR" {
  default = "10.0.0.0/16"
}
variable "DB_NAME" {
  sensitive = true
}
variable "USERNAME" {
  sensitive = true
  description = "Database username"
}
variable "PASSWORD" {
  sensitive = true
  description = "Database password"
}
variable "MY_IP" {
  default = "0.0.0.0/0" #edit this to the ip address that needs ssh access. prefably your Ip address.
}