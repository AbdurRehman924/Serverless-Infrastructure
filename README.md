# Serverless API with Lambda + API Gateway

This project demonstrates how to create a serverless API using AWS Lambda and API Gateway, managed with Terraform. The infrastructure is created in a modular way, making it easy to reuse and manage.

## Project Structure

The project is structured as follows:

```
.
├── lambda
│   └── lambda_function.py
├── modules
│   ├── api-gateway
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── iam
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── lambda
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── s3
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── main.tf
├── outputs.tf
└── variables.tf
```

- **`lambda/lambda_function.py`**: This is the Python code for our Lambda function. It's a simple function that returns a "Hello from Lambda!" message.
- **`modules/`**: This directory contains the reusable Terraform modules for creating the different parts of our infrastructure.
  - **`api-gateway/`**: This module creates the API Gateway, which acts as the entry point for our API.
  - **`iam/`**: This module creates the IAM role and policy for the Lambda function, giving it the necessary permissions to run and write logs.
  - **`lambda/`**: This module creates the Lambda function itself.
  - **`s3/`**: This module creates the S3 bucket and uploads the Lambda function code to it.
- **`main.tf`**: This is the root Terraform file that brings everything together. It defines the AWS provider and calls the modules to create the infrastructure.
- **`outputs.tf`**: This file defines the output of our Terraform project, which in this case is the URL of the API Gateway endpoint.
- **`variables.tf`**: This file defines the variables used in our Terraform project, such as the AWS region and the name of the Lambda function.

## How it Works

1.  **API Gateway**: The API Gateway provides a publicly accessible HTTP endpoint. When a request is made to this endpoint, the API Gateway is configured to trigger our Lambda function.
2.  **Lambda Function**: The Lambda function is a small, serverless piece of code that runs in response to an event, in this case, an HTTP request from the API Gateway. The function executes its code and returns a response.
3.  **IAM Role**: The IAM role is attached to the Lambda function and grants it permission to access other AWS services. In this project, the Lambda function is granted permission to write logs to CloudWatch.
4.  **S3 Bucket**: The Lambda function's code is zipped and stored in an S3 bucket. When the Lambda function is deployed, AWS retrieves the code from this bucket.

This setup allows you to have a fully functional, scalable, and cost-effective API without managing any servers.

## Step-by-Step Execution Flow

1.  **Terraform Deployment**:
    *   You run `terraform apply`.
    *   Terraform reads all the `.tf` files and builds a dependency graph of the resources.
    *   The `s3` module creates an S3 bucket.
    *   The `s3` module then zips the `lambda` directory and uploads the `lambda.zip` file to the newly created S3 bucket.
    *   The `iam` module creates the IAM role and policy for the Lambda function.
    *   The `lambda` module creates the Lambda function, pointing to the S3 bucket for the code and attaching the IAM role.
    *   The `api-gateway` module creates the API Gateway, configures a proxy endpoint, and integrates it with the Lambda function. It also grants the API Gateway permission to invoke the Lambda function.

2.  **Client Request**:
    *   A user or client sends an HTTP request to the API Gateway endpoint URL provided by the Terraform output (e.g., using `curl`).

3.  **API Gateway to Lambda**:
    *   API Gateway receives the request.
    *   It uses the integration configuration to trigger the associated Lambda function.
    *   The request data (headers, body, path, etc.) is passed as an `event` object to the Lambda function.

4.  **Lambda Execution**:
    *   AWS Lambda service uses the attached IAM role to get temporary credentials.
    *   It fetches the `lambda.zip` file from the S3 bucket, unzips it, and prepares the execution environment.
    *   It executes the `lambda_handler` function in the `lambda_function.py` file, passing the `event` object.
    *   The function runs, prints "Hello from Lambda!" to CloudWatch Logs (using the permissions from the IAM role), and returns a JSON response with a `statusCode` and `body`.

5.  **Response to Client**:
    *   The Lambda function's response is sent back to the API Gateway.
    *   API Gateway formats the response and sends it back to the original client.
    *   The client receives the `"Hello from Lambda!"` message in the response body.

## Deployment

To deploy the project, you will need to have Terraform and the AWS CLI installed and configured.

1.  **Initialize Terraform**:
    ```bash
    terraform init
    ```
2.  **Plan the deployment**:
    ```bash
    terraform plan
    ```
3.  **Apply the changes**:
    ```bash
    terraform apply
    ```

After the deployment is complete, Terraform will output the URL of the API Gateway endpoint.

## Testing

You can test the API endpoint using `curl`. The `api_gateway_endpoint` output from `terraform apply` will give you a URL ending in `/hello`.

```bash
curl <api_gateway_endpoint_url>
```

You should see the following response:

```
"Hello from Lambda!"
```

**Note on "Missing Authentication Token" Error:**

If you invoke the API Gateway endpoint without a path after the stage name (e.g., `https://<api-id>.execute-api.<region>.amazonaws.com/prod`), you will get a `{"message":"Missing Authentication Token"}` error. This is because the API Gateway is configured with a `{proxy+}` resource, which expects a path to be present. The output of this project provides a valid URL with `/hello` appended.

## Cleanup

To destroy the infrastructure, run the following command:

```bash
terraform destroy
```