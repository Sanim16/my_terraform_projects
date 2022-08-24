terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = "${var.AWS_REGION}"
  shared_credentials_files = ["${var.AWS_CREDENTIALS}"]
  profile                  = "${var.VSCODE_PROFILE}"
}