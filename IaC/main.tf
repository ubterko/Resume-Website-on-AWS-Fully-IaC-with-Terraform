provider "aws" {
  region = var.aws_region
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
