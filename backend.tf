##Used to create a remote backend in s3 so that the .tfstate file can
##be accessed by more than one person in a team setting

##The file doesn't accept variables

# terraform {
#   backend "s3" {
#     bucket = "ms-tfstate-bucket" #Bucket name in S3
#     key    = "terraform/remotestate" #Key to object in S3
#     region = "us-east-1"
#     shared_credentials_file = "C:\\Users\\hp\\.aws\\credentials" #path to shared credentials for login to Aws
#     profile = "admin_vscode" #profile to use
#   }
# }