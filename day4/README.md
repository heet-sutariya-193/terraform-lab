# Day 4 - Terraform Modules

## Steps Performed:
1. Created a reusable module for nginx containers
2. Module accepts container_name and host_port as variables
3. Root configuration calls the module twice
4. Created two containers on ports 8081 and 8082

## Commands Executed:
```bash
terraform init
terraform plan
terraform apply -auto-approve
docker ps
curl http://localhost:8081
curl http://localhost:8082
terraform output
terraform destroy -auto-approve
Learning Outcomes:
Terraform modules

Reusable infrastructure components

Modular infrastructure design
