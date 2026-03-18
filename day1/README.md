# Day 1: Introduction to Terraform

## Problem Statement

Understanding the basic Terraform workflow and creating a simple infrastructure resource. The goal is to learn how Terraform can create, modify, and manage infrastructure using configuration files instead of manual setup.

## Solution

Create a Terraform configuration that uses the local provider to create a text file with a message. This demonstrates the core Terraform concepts of providers, resources, variables, and outputs.

## Assignment Requirements

* Use the local provider
* Create a file named `hello.txt`
* Write "Hello from Terraform" inside the file
* Add a variable for the message
* Add an output for the file path

## Files Created

| File           | Purpose                                                  |
| -------------- | -------------------------------------------------------- |
| `main.tf`      | Main configuration with local provider and file resource |
| `variables.tf` | Defines input variables (filename, message)              |
| `outputs.tf`   | Shows file path and content after creation               |
| `README.md`    | This documentation file                                  |

---

## File Explanations

### main.tf

```hcl
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

resource "local_file" "hello" {
  filename = var.filename
  content  = var.message
}
```

**Explanation:**

* `terraform` block specifies required providers (local provider from HashiCorp)
* `resource "local_file" "hello"` creates a file on the local system
* Values come from variables defined in `variables.tf`

---

### variables.tf

```hcl
variable "filename" {
  description = "Name of the file to create"
  type        = string
  default     = "hello.txt"
}

variable "message" {
  description = "Message to write in the file"
  type        = string
  default     = "Hello from Terraform"
}
```

**Explanation:**

* Variables make the configuration reusable
* `description` documents the variable
* `type` ensures correct data type
* `default` provides a fallback value

---

### outputs.tf

```hcl
output "file_path" {
  description = "Path of the created file"
  value       = local_file.hello.filename
}

output "file_content" {
  description = "Content of the created file"
  value       = local_file.hello.content
}
```

**Explanation:**

* Outputs display information after `terraform apply`
* `value` references attributes of created resources
* Useful for verifying results

---

## Commands to Execute

```bash
# 1. Navigate to day1 directory
cd day1

# 2. Initialize Terraform (downloads providers)
terraform init

# 3. Preview what will be created
terraform plan

# 4. Create the file
terraform apply -auto-approve

# 5. Verify the file was created
ls -la
cat hello.txt

# 6. Check outputs
terraform output

# 7. Clean up resources
terraform destroy -auto-approve
```

---

## Expected Output

```text
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

file_content = "Hello from Terraform"
file_path = "hello.txt"
```

---

## Key Concepts Learned

| Concept  | Description                                                              |
| -------- | ------------------------------------------------------------------------ |
| Provider | Plugin that enables Terraform to interact with APIs (local, AWS, Docker) |
| Resource | A component of infrastructure (file, server, container)                  |
| Variable | Input parameter to customize configurations                              |
| Output   | Information returned after resource creation                             |
| State    | `terraform.tfstate` file tracking created resources                      |
| Init     | Initializes working directory and downloads providers                    |
| Plan     | Previews changes before applying                                         |
| Apply    | Creates or updates infrastructure                                        |
| Destroy  | Removes all managed resources                                            |

---

## Real-World Application

This simple example demonstrates the same pattern used to create cloud resources like AWS EC2 instances, Azure VMs, or Google Cloud storage buckets. The workflow (`init → plan → apply`) remains identical regardless of infrastructure complexity.

---

## Learning Outcomes

* Understood Terraform initialization process
* Learned execution planning with `terraform plan`
* Successfully applied infrastructure with `terraform apply`
* Implemented variables for configurability
* Used outputs to display resource information
* Properly destroyed resources to clean up
