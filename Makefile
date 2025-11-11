.PHONY: init plan apply destroy test clean

# Initialize Terraform
init:
	terraform init

# Plan Terraform changes
plan:
	terraform plan

# Apply Terraform changes
apply:
	terraform apply

# Destroy infrastructure
destroy:
	terraform destroy

# Test the API endpoint
test:
	@echo "Testing API endpoint..."
	@API_URL=$$(terraform output -raw api_gateway_endpoint 2>/dev/null || echo "Run 'make apply' first"); \
	if [ "$$API_URL" != "" ]; then \
		curl -s "$$API_URL" | jq .; \
	else \
		echo "API endpoint not available. Run 'make apply' first."; \
	fi

# Clean up generated files
clean:
	rm -rf .terraform/
	rm -f .terraform.lock.hcl
	rm -f terraform.tfstate*
	rm -f lambda.zip
