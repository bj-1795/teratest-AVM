
provider "aws" {
  region = "ap-southeast-1"
  
}

variable "bucket_name" {
  description = "The name of the bucket"
  default     = "poc"
}


resource "aws_s3_bucket" "terratest_bucket" {
  bucket = "terratest${var.bucket_name}"
  versioning {
    enabled = true
  }
}

output "bucket_id" {
  value = aws_s3_bucket.terratest_bucket.id
}