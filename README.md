# Terraform Lab - Infrastructure as Code

## Lab Overview

This repository contains my complete solutions for the Infrastructure as Code (IaC) lab using Terraform. The lab demonstrates progressive learning from basic file creation to dynamic infrastructure management.

## Learning Objectives

* Understand Terraform workflow (`init`, `plan`, `apply`, `destroy`)
* Write Terraform configuration files
* Use variables and outputs
* Create reusable Terraform modules
* Manage container infrastructure using Docker
* Perform infrastructure validation using CI/CD
* Dynamically generate infrastructure using Terraform expressions

---

## Repository Structure

```text id="d8q7mn"
terraform-lab/
├── day1/                  # Introduction to Terraform
├── day2/                  # Variables and multiple configurations
├── day3/                  # Docker containers (nginx)
├── day4/                  # Terraform modules
├── day5/                  # CI/CD automation (GitHub Actions)
├── bonus/                 # Dynamic infrastructure (count, for_each)
├── .github/workflows/     # CI/CD workflow files
├── .gitignore             # Git ignore rules
└── README.md              # Root documentation
```

---

## Prerequisites

* Terraform CLI (v1.5.7)
* Docker Desktop / Docker Engine
* Git
* GitHub account

---

## How to Use This Repository

1. Clone the repository
2. Navigate to any day's folder (e.g., `cd day1`)
3. Follow the instructions in the respective README
4. Run the Terraform workflow:

   ```bash
   terraform init
   terraform plan
   terraform apply
   terraform destroy
   ```

---

## Key Achievements

* Successfully created infrastructure using local provider
* Implemented multi-environment configurations (development and production)
* Deployed nginx containers using Docker provider
* Built reusable Terraform modules
* Automated validation using GitHub Actions
* Created dynamic infrastructure using `count`

---

## Author

Heet Sutariya(BT23CSE030)

---

## Submission Date

18th March 2026
