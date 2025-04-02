terraform {
  required_providers {
    aws ={
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "eu-west-1"
  
}

resource "aws_s3_bucket" "my-bucket" {
    bucket="kvd-abhinav-tf-bucket"
}

resource "aws_s3_object" "my-object" {
    bucket = "kvd-abhinav-tf-bucket"
    key = "spiderman-image"
    source = "C:/Users/abhin/OneDrive/Pictures/Downloads-images/spider-man.webp"

}

resource "aws_s3_object" "my-object-2" {
    bucket = "kvd-abhinav-tf-bucket"
    key = "secret/sherlock-image"
    source = "C:/Users/abhin/OneDrive/Pictures/Downloads-images/sherlock.jpeg"
}

resource "aws_s3_bucket_versioning" "example" {
    bucket = aws_s3_bucket.my-bucket.id
    versioning_configuration {
      status = "Enabled"
    }  
}

resource "aws_s3_object" "csv-object" {
    bucket = aws_s3_bucket.my-bucket.id
    key = "csv-file"
    source = "./1.csv"

    etag = filemd5("./csv-file.csv")
}