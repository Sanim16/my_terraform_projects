terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = "${var.AWS_REGION}"
  shared_credentials_files = ["C:\\Users\\hp\\.aws\\credentials"]
  profile                  = "${var.VSCODE_PROFILE}"
}