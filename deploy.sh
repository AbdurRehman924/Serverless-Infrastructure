#!/bin/bash

echo "🚀 Deploying Serverless API..."

# Initialize Terraform
terraform init

# Plan deployment
terraform plan

# Apply configuration
terraform apply -auto-approve

# Get API endpoint
API_URL=$(terraform output -raw api_gateway_url)

echo "✅ Deployment complete!"
echo "📡 API Gateway URL: $API_URL"
echo ""
echo "🧪 Testing endpoint with curl:"
echo "curl $API_URL"
echo ""

# Test the endpoint
curl -s "$API_URL" | python3 -m json.tool

echo ""
echo "🧪 Test with different path:"
echo "curl $API_URL/test"
curl -s "$API_URL/test" | python3 -m json.tool
