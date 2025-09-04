resource "aws_dynamodb_table" "visits" {
  name           = var.dynamodb_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id" //partition key
  range_key      = "views"  //sort key

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "views"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  # GSI is used to create a second key (index) for indexing the data in the database
  # an index that allows you to query a table using different attributes than the primary key

  #   global_secondary_index {
  #     name               = "GameTitleIndex"
  #     hash_key           = "GameTitle"
  #     range_key          = "TopScore"
  #     write_capacity     = 10
  #     read_capacity      = 10
  #     projection_type    = "INCLUDE"
  #     non_key_attributes = ["UserId"]
  #   }

  tags = {
    Name        = "Resume"
    Environment = "Dev"
  }
}

# *****************************************************
# *****************************************************
# lambda EXECUTION ROLE - for granting it permission to 
#                         other aws services
# *****************************************************
# ***************************************************** 

# the permission policy for IAM role 
# resource "aws_iam_policy" "iam_policy_for_resume_project" {
#   name        = "aws_iam_policy_for_terraform_resume_project_policy"
#   path        = "/"
#   description = "AWS IAM Policy for managing the resume project role"
#   policy = jsonencode(
#     {
#       "Version" : "2012-10-17",
#       "Statement" : [
#         {
#           "Action" : [
#             "logs:CreateLogGroup",
#             "logs:CreateLogStream",
#             "logs:PutLogEvents"
#           ],
#           "Resource" : "arn:aws:logs:*:*:*",
#           "Effect" : "Allow"
#         },
#         {
#           "Effect" : "Allow",
#           "Action" : [
#             "dynamodb:UpdateItem",
#             "dynamodb:GetItem"
#           ],
#           "Resource" : "arn:aws:dynamodb:*:*:table/resume-challenge"
#         },
#       ]
#   })
# }

data "aws_iam_policy_document" "lambda_dynamodb_policy" {
  statement {
    actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:UpdateItem"
    ]
    resources = [
      aws_dynamodb_table.visits.arn // how to dynamically get table arn as the dynamodb is created in the same tf file.
    ]
  }
}

resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name   = "lambda_dynamodb_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_dynamodb_policy.json
}

# Assume role policy document - Trust policy is created for lambda function
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# Assume role policy
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# If the file is not in the current working directory you will need to include a
# path.module in the filename.
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda/script.py"
  output_path = "${path.module}/lambda/lambda_script.zip"
}

resource "aws_lambda_function" "visits_lambda" {
  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256
  role             = aws_iam_role.iam_for_lambda.arn
  function_name    = var.lambda_function_name
  handler          = "index.test"
  runtime          = "python3.9"
  # environment {
  #   variables = {
  #   foo = "bar"
  #   }
  # }
}

resource "aws_lambda_function_url" "visits" {
  function_name = var.lambda_function_name 
  authorization_type = "NONE"
}