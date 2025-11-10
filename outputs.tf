output "api_gateway_url" {
  description = "Base URL for API Gateway stage"
  value       = aws_api_gateway_deployment.api.invoke_url
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.api_function.function_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket storing Lambda code"
  value       = aws_s3_bucket.lambda_code.id
}
