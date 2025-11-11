terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "s3" {
  source            = "./modules/s3"
  bucket_name       = var.bucket_name
  lambda_source_dir = "${path.module}/lambda"
}

module "iam" {
  source        = "./modules/iam"
  function_name = var.function_name
  region        = var.region
  account_id    = data.aws_caller_identity.current.account_id
}

module "lambda" {
  source        = "./modules/lambda"
  function_name = var.function_name
  iam_role_arn  = module.iam.lambda_role_arn
  s3_bucket     = module.s3.s3_bucket_id
  s3_key        = module.s3.s3_object_key
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
}

module "api_gateway" {
  source        = "./modules/api-gateway"
  function_name = var.function_name
  lambda_arn    = module.lambda.lambda_function_arn
  region        = var.region
  account_id    = data.aws_caller_identity.current.account_id
}

data "aws_caller_identity" "current" {}