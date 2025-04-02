terraform {
  backend "s3" {
    bucket = "kvdabhinav-terraform"
    key    = "terraform/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "aabhinnav-terraform"
  }
}
