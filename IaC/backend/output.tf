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