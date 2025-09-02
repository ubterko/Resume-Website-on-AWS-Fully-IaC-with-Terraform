provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-ie25"
    key            = "envs/dev/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

module "frontend" {
  source             = "./frontend"
  resume_bucket_name = var.resume_bucket_name
  logs_bucket_name   = var.logs_bucket_name
}

module "backend" {
  source               = "./backend"
  dynamodb_table_name  = var.dynamodb_table_name
  lambda_function_name = var.lambda_function_name
}
