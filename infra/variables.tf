variable "aws_region" {
  description = "The region"
  type        = string
}

variable "logs_bucket_name" {
  description = "The logs bucket"
  type        = string
}

variable "resume_bucket_name" {
  description = "The resume bucket"
  type        = string
}

variable "dynamodb_table_name" {
  description = "The dynamodb table"
  type        = string
}

variable "lambda_function_name" {
  description = "The lambda function name"
}
