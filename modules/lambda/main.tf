resource "aws_lambda_function" "serverless_lambda" {
  function_name = var.function_name
  role          = var.iam_role_arn
  handler       = var.handler
  runtime       = var.runtime
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key

  source_code_hash = data.aws_s3_object.lambda_object.etag

  environment {
    variables = {
      GREETING = "Hello from Lambda!"
    }
  }
}

data "aws_s3_object" "lambda_object" {
  bucket = var.s3_bucket
  key    = var.s3_key
}
