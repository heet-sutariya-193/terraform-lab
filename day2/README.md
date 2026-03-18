# Day 2: Variables and Multiple Configurations

## Problem Statement

Infrastructure often needs different configurations for different environments (development, staging, production). Hardcoding values or manually changing them leads to errors and inconsistencies. We need a way to use the same Terraform code with different values for each environment.

## Solution

Use Terraform variables with separate `.tfvars` files for each environment. The same configuration code can then be applied with different variable files to create environment-specific infrastructure.

## Assignment Requirements

* Create variables for filename and message (NO DEFAULTS)
* Create two variable files: `dev.tfvars` and `prod.tfvars`
* Execute Terraform with different variable files
* Verify different files are created for each environment

## Files Created

| File           | Purpose                                       |
| -------------- | --------------------------------------------- |
| `main.tf`      | Same file resource as Day 1                   |
| `variables.tf` | Variables WITHOUT defaults (must be provided) |
| `outputs.tf`   | Outputs file information                      |
| `dev.tfvars`   | Values for development environment            |
| `prod.tfvars`  | Values for production environment             |
| `README.md`    | This documentation file                       |

---

## File Explanations

### variables.tf (No Defaults)

```hcl
variable "filename" {
  description = "Name of the file to create"
  type        = string
  # NO DEFAULT - must be provided in .tfvars
}

variable "message" {
  description = "Message to write in the file"
  type        = string
  # NO DEFAULT - must be provided
}
```

**Explanation:**

* Removing defaults forces users to provide values
* Prevents accidentally using incorrect values
* Ensures environment-specific values are explicitly set

---

### dev.tfvars

```hcl
filename = "dev.txt"
message  = "Development environment"
```

**Explanation:**

* Contains values for development environment
* Creates `dev.txt` with development message
* Used with `-var-file="dev.tfvars"` flag

---

### prod.tfvars

```hcl
filename = "prod.txt"
message  = "Production environment"
```

**Explanation:**

* Contains values for production environment
* Creates `prod.txt` with production message
* Used with `-var-file="prod.tfvars"` flag

---

## Commands to Execute

### For Development Environment

```bash
# Navigate to day2 directory
cd day2

# Initialize
terraform init

# Preview development environment
terraform plan -var-file="dev.tfvars"

# Apply development configuration
terraform apply -var-file="dev.tfvars" -auto-approve

# Verify development file
cat dev.txt

# Check outputs
terraform output

# Destroy development resources
terraform destroy -var-file="dev.tfvars" -auto-approve
```

---

### For Production Environment

```bash
# Preview production environment
terraform plan -var-file="prod.tfvars"

# Apply production configuration
terraform apply -var-file="prod.tfvars" -auto-approve

# Verify production file
cat prod.txt

# Check outputs
terraform output

# Destroy production resources
terraform destroy -var-file="prod.tfvars" -auto-approve
```

---

## Expected Output

### Development

```text
Outputs:

file_content = "Development environment"
file_path = "dev.txt"
```

### Production

```text
Outputs:

file_content = "Production environment"
file_path = "prod.txt"
```

---

## Key Concepts Learned

| Concept                | Description                                                |
| ---------------------- | ---------------------------------------------------------- |
| `.tfvars` files        | Files containing variable values for specific environments |
| `-var-file` flag       | CLI flag to specify which variable file to use             |
| Environment separation | Same code, different values for different environments     |
| Required variables     | Variables without defaults MUST be provided                |
| Variable precedence    | `-var-file` overrides defaults and other sources           |

---

## Variable Precedence (Highest to Lowest)

1. `-var-file` flag (highest priority)
2. `*.auto.tfvars` files
3. `terraform.tfvars` file
4. Environment variables (`TF_VAR_name`)
5. Defaults in `variables.tf` (lowest priority)

---

## Real-World Application

In real-world scenarios:

* `dev.tfvars`: Smaller resources, debugging enabled
* `staging.tfvars`: Production-like setup with test data
* `prod.tfvars`: Full-scale resources, monitoring and scaling enabled

---

## Learning Outcomes

* Created environment-specific variable files
* Used `-var-file` flag to select environments
* Understood variable precedence
* Practiced separating configuration from values
* Learned to manage multiple environments with the same code
