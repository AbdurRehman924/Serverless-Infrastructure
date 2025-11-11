variable "region" {
  description = "The AWS region to deploy the infrastructure in."
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to store the Lambda function code in."
  default     = "serverless-lambda-code-bucket"
}

variable "function_name" {
  description = "The name of the Lambda function."
  default     = "serverless-api-lambda"
}