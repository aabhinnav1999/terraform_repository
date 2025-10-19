terraform {
  backend "s3" {
    bucket = "aabhinnav-terraform-bucket"
    key = "workspaces/terraform.tfstate"
    region = "eu-west-1"

    use_lockfile = true

  }

}