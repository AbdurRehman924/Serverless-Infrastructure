output "api_gateway_url" {
  description = "The URL of the API Gateway endpoint."
  value       = "${aws_api_gateway_stage.prod_stage.invoke_url}/hello"
}
