provider "aws" {
  region = "us-west-2"

  assume_role {
    role_arn = "arn:aws:iam::877759812082:role/FullAutomationRole"
  }
}

# terraform.camtelstatebucket 

terraform {
  backend "s3" {
    bucket         = "terraform.camtelstatebucket"
    key            = "path/to/my/statebuket"
    region         = "us-west-2"
    dynamodb_table = "camtelstatetable"
  }
}