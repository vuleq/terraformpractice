terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "bootstrap"
  region = var.region
  profile = var.aws_profile   # to switch AWS account to needed profile
}

resource "aws_s3_bucket" "tfstate" {
  provider = aws.bootstrap
  bucket = var.bucket_name
  # tags ={
  #   Environment = "PROD"
  #   Application = "WDR"
  #   Owner       = "MaritimeApps"
  # }
}

# resource "aws_s3_bucket_versioning" "tfstate_versioning" {
#   bucket = aws_s3_bucket.tfstate.id
#   versioning_configuration {
#     status = "Enabled"
    
#   }

  # lifecycle {
  #   prevent_destroy = true
  # }
# }

# resource "aws_dynamodb_table" "tf_lock" {
#   provider = aws.bootstrap

#   name         = var.lock_table_name
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name = "${var.owner}_${var.application}_${var.environment}"
#   }

#   # lifecycle {
#   #   prevent_destroy = true
#   # }

# }
