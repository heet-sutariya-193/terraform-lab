# Day 2 - Variables and Multiple Configurations

## Steps Performed:
1. Created Terraform configuration with variables
2. Created separate variable files for dev and prod environments
3. Applied configurations with different variable files

## Commands Executed:
```bash
# For development
terraform init
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars" -auto-approve
cat dev.txt
terraform destroy -var-file="dev.tfvars" -auto-approve

# For production
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars" -auto-approve
cat prod.txt
terraform destroy -var-file="prod.tfvars" -auto-approve
Learning Outcomes:
Input variables

Variable files

Environment-based configuration
