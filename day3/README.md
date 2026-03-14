# Day 3 - Managing Containers with Terraform

## Steps Performed:
1. Configured Docker provider in Terraform
2. Pulled nginx image
3. Created Docker container mapping port 80 to 8080
4. Added outputs for container information

## Commands Executed:
```bash
terraform init
terraform plan
terraform apply -auto-approve
docker ps
terraform output
# Visit http://localhost:8080 in browser
terraform destroy -auto-approve
Learning Outcomes:
Terraform providers

Container provisioning

Managing services using infrastructure code
