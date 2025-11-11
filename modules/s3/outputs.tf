output "s3_bucket_id" {
  description = "The ID of the S3 bucket."
  value       = aws_s3_bucket.lambda_bucket.id
}

output "s3_object_key" {
  description = "The key of the S3 object."
  value       = aws_s3_object.lambda_object.key
}

output "s3_object_etag" {
  description = "The ETag of the S3 object."
  value       = aws_s3_object.lambda_object.etag
}
