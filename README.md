# Serverless API with Lambda + API Gateway

A minimal serverless API using AWS Lambda, API Gateway, and S3 for code storage.

## Architecture

- **Lambda Function**: Python function returning JSON responses
- **API Gateway**: REST API with proxy integration
- **S3 Bucket**: Stores Lambda deployment package
- **IAM Role**: Minimal permissions for Lambda execution

## Quick Deploy

```bash
./deploy.sh
```

## Manual Steps

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Deploy Infrastructure**:
   ```bash
   terraform apply
   ```

3. **Test API**:
   ```bash
   # Get the API URL
   API_URL=$(terraform output -raw api_gateway_url)
   
   # Test endpoint
   curl $API_URL
   curl $API_URL/test
   ```

## Key Features

- **Automatic S3 Upload**: Lambda code is zipped and uploaded to S3
- **Proxy Integration**: API Gateway forwards all requests to Lambda
- **CORS Enabled**: API includes CORS headers
- **Minimal IAM**: Only basic Lambda execution permissions

## Cleanup

```bash
terraform destroy
```

## Files

- `lambda_function.py` - Lambda function code
- `main.tf` - Terraform infrastructure
- `variables.tf` - Configuration variables
- `outputs.tf` - API endpoint output
- `deploy.sh` - Automated deployment script
