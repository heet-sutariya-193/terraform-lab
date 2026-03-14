# Day 5 - Automation and Validation

## Steps Performed:
1. Created GitHub Actions workflow
2. Workflow runs on every push to main branch
3. Runs terraform fmt, init, validate, and plan

## Workflow Steps:
- Checkout code
- Setup Terraform
- Check formatting (terraform fmt)
- Initialize Terraform
- Validate configuration
- Generate execution plan

## Commands in Workflow:
```bash
terraform fmt -check -recursive
terraform init
terraform validate
terraform plan
Learning Outcomes:
Infrastructure validation

CI automation

Code quality checks for Terraform configurations
