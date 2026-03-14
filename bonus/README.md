# Bonus Challenge - Dynamic Infrastructure

## Objective
Dynamically create multiple containers using Terraform expressions and loops.

## Features
- Uses `count` to create containers from a list
- Variable contains list of container specifications
- Automatically creates containers for each entry
- Easy to add/remove containers by modifying the list

## Commands Executed
```bash
# Test with default configuration
terraform init
terraform plan
terraform apply -auto-approve
docker ps
terraform output

# Test with custom configuration
terraform apply -var-file="custom.tfvars" -auto-approve
docker ps
terraform output

# Clean up
terraform destroy -auto-approve
Expected URLs
http://localhost:8081

http://localhost:8082

http://localhost:8083

http://localhost:8084 (with custom config)

Learning Outcomes
Dynamic infrastructure creation

Terraform expressions and loops

count parameter

List and object variables
