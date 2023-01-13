provider "aws" {
  region = "us-east-1"
}

variable "is_this_a_test" {
  type = string
  default = "please-no"
}

resource "aws_s3_bucket" "what" {
  bucket = var.is_this_a_test

  tags = {
    Name        = var.is_this_a_test
    Environment = "My Brain Hurts"
  }
}