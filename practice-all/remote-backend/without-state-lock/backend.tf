terraform {
  backend "s3" {
    bucket = "aabhinnav-terraform-bucket"
    key = "development/terraform.tfstate"
    region = "eu-west-1"
  }
}