provider "aws" {
    region = "eu-west-1"
}

resource "aws_s3_bucket" "example" {
    bucket = "abhinav-terraform-bucket-${replace(timestamp(), "[^0-9]", "")}"

    tags = {
        Name        = "terraform-bucket"
        Environment = "Development"
    }

}

resource "aws_s3_object" "example-object" {
    bucket = aws_s3_bucket.example.bucket
    key    = "scriptfiles/script.sh"
    source = "script.sh"
}

resource "aws_s3_bucket_versioning" "demo-versioning" {
    bucket = aws_s3_bucket.example.id
    versioning_configuration {
        status = "Enabled"
    }
}