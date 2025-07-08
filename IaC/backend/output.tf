output "dynamodb_id" {
    description = "Dynmodb Id"
    value = aws_dynamodb_table.visits.id
}

output "dynamodb_arn" {
    description = "Dynmodb Id"
    value = aws_dynamodb_table.visits.arn
}

output "lambda_function_arn" {
    description = "Dynmodb Id"
    value = aws_lambda_function.visits_lambda.arn
}

output "function_url" {
    description = "Function url for accessing the lambda function" 
    value = aws_lambda_function_url.function_url
}