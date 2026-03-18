# Day 5: CI/CD Automation with GitHub Actions

## Problem Statement

Manual validation of Terraform code is error-prone and easy to forget. Team members might push invalid code, causing issues for others. We need automated validation that runs on every code push to catch errors early.

## Solution

Use GitHub Actions to automatically validate Terraform code whenever code is pushed to the repository. The workflow runs `terraform fmt`, `init`, `validate`, and `plan` to ensure code quality and correctness.

## Assignment Requirements

* Create GitHub Actions workflow
* Workflow runs on push to main branch
* Run commands: `terraform fmt`, `terraform init`, `terraform validate`, `terraform plan`
* Place workflow file in `.github/workflows/terraform-check.yml`

## Files Created

| File                                    | Purpose                             |
| --------------------------------------- | ----------------------------------- |
| `main.tf`                               | Simple Terraform config for testing |
| `variables.tf`                          | Variables for test file             |
| `outputs.tf`                            | Outputs for test file               |
| `.github/workflows/terraform-check.yml` | GitHub Actions workflow             |
| `README.md`                             | This documentation file             |

---

## File Explanations

### .github/workflows/terraform-check.yml

```yaml id="q2bx3q"
name: 'Terraform Validation'

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

permissions:
  contents: read

jobs:
  terraform:
    name: 'Terraform Format, Validate and Plan'
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.5.7

      - name: Terraform Format
        run: terraform fmt -check -recursive
        continue-on-error: true

      - name: Terraform Init
        run: cd day5 && terraform init

      - name: Terraform Validate
        run: cd day5 && terraform validate

      - name: Terraform Plan
        run: cd day5 && terraform plan
```

---

## Workflow Explanation

| Section         | Purpose                                   |
| --------------- | ----------------------------------------- |
| name            | Identifies workflow in GitHub Actions tab |
| on.push         | Triggers workflow on push to main         |
| on.pull_request | Also triggers on PRs                      |
| permissions     | Limits access for security                |
| jobs            | Group of tasks                            |
| runs-on         | Defines runner environment                |
| steps           | Individual execution steps                |

---

## Step Explanations

| Step               | What it does              | Why it matters             |
| ------------------ | ------------------------- | -------------------------- |
| Checkout           | Downloads repository code | Required to run Terraform  |
| Setup Terraform    | Installs Terraform CLI    | Enables Terraform commands |
| Terraform Format   | Checks formatting         | Ensures consistency        |
| Terraform Init     | Downloads providers       | Required before validation |
| Terraform Validate | Checks syntax             | Prevents errors            |
| Terraform Plan     | Shows changes             | Verifies correctness       |

---

## How to Test Locally

```bash id="8m9b2x"
# Navigate to day5 directory
cd day5

# Initialize
terraform init

# Validate
terraform validate

# Plan
terraform plan

# (Optional) Apply
terraform apply -auto-approve
cat test.txt
terraform destroy -auto-approve
```

---

## What Happens on GitHub

When you push code:

1. GitHub detects push to main branch
2. Creates a fresh Ubuntu runner
3. Executes workflow steps sequentially
4. Displays results in the Actions tab

---

## Expected Results

### Success (Green)

```text id="f07hje"
All checks passed!
✓ Terraform Format
✓ Terraform Init
✓ Terraform Validate
✓ Terraform Plan
```

### Failure (Red)

```text id="v1djsg"
Terraform Validate failed!
Error: Invalid character
  on main.tf line 10: syntax error
```

---

## Key Concepts Learned

| Concept        | Description                                  |
| -------------- | -------------------------------------------- |
| CI/CD          | Continuous Integration / Continuous Delivery |
| GitHub Actions | Automation platform by GitHub                |
| Workflow       | YAML file defining automation                |
| Event          | Trigger for workflow (push, PR)              |
| Job            | Group of steps                               |
| Step           | Individual command or action                 |
| Runner         | Virtual machine executing jobs               |
| Action         | Reusable component                           |

---

## Real-World CI/CD Pipeline

```yaml id="7u2l9c"
steps:
  - name: Checkout
  - name: Terraform Validate
  
  - name: Terraform Plan
  - name: Manual Approval
  
  - name: Terraform Apply
  - name: Run Tests
  - name: Notify Slack
```

---

## Learning Outcomes

* Created GitHub Actions workflow
* Understood YAML workflow syntax
* Automated Terraform validation
* Learned CI/CD fundamentals
* Integrated checks into development workflow
