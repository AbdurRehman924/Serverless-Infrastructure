variable "function_name" {
  description = "The name of the Lambda function."
}

variable "iam_role_arn" {
  description = "The ARN of the IAM role for the Lambda function."
}

variable "s3_bucket" {
  description = "The name of the S3 bucket containing the Lambda function code."
}

variable "s3_key" {
  description = "The S3 key of the Lambda function code."
}

variable "handler" {
  description = "The Lambda function handler."
}

variable "runtime" {
  description = "The Lambda function runtime."
}
