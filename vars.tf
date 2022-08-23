variable "AWS_CREDENTIALS" {} #empty to prvent uploading secrets
variable "VSCODE_PROFILE" {} #empty to prvent uploading secrets
variable "AWS_REGION" {
    type = "string"
    default = "us-east-1"
  
}
