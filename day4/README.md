# Day 4: Terraform Modules

## Problem Statement

As infrastructure grows, code becomes repetitive and hard to maintain. Creating multiple similar resources requires copying and pasting code, leading to errors and maintenance issues. We need a way to create reusable infrastructure components.

## Solution

Use Terraform modules to create reusable infrastructure components. Define the resource once in a module, then reuse it multiple times with different inputs. This follows the DRY (Don't Repeat Yourself) principle.

## Assignment Requirements

* Create a module for nginx container
* Module should accept `container_name` and `host_port` variables
* Root configuration should call the module twice
* Create two containers on ports 8081 and 8082
* Add outputs showing both container URLs

## File Structure

```text
day4/
├── main.tf
├── outputs.tf
├── README.md
└── modules/
    └── nginx_container/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

## File Explanations

### Module Files (modules/nginx_container/)

#### modules/nginx_container/main.tf

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name

  ports {
    internal = 80
    external = var.host_port
  }
}
```

**Explanation:**

* Defines creation of one nginx container
* Uses variables for container name and port
* Docker image is pulled before container creation
* Configuration is reusable across multiple instances

---

#### modules/nginx_container/variables.tf

```hcl
variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "host_port" {
  description = "Port on the host machine"
  type        = number
}
```

**Explanation:**

* No defaults — values must be provided by root
* Keeps module generic and reusable
* Root decides actual values

---

#### modules/nginx_container/outputs.tf

```hcl
output "service_url" {
  description = "URL to access nginx"
  value       = "http://localhost:${var.host_port}"
}

output "container_name" {
  description = "Name of the container"
  value       = docker_container.nginx.name
}
```

**Explanation:**

* Returns useful information to root module
* Enables aggregation of outputs

---

### Root Files (day4/)

#### main.tf

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

module "nginx_container_1" {
  source = "./modules/nginx_container"

  container_name = "nginx-module-1"
  host_port      = 8081
}

module "nginx_container_2" {
  source = "./modules/nginx_container"

  container_name = "nginx-module-2"
  host_port      = 8082
}
```

**Explanation:**

* `source` points to module directory
* Same module reused twice with different values
* Provider defined once and shared
* Demonstrates modular infrastructure design

---

#### outputs.tf

```hcl
output "container_1_info" {
  description = "Information about first container"
  value = {
    name = module.nginx_container_1.container_name
    url  = module.nginx_container_1.service_url
  }
}

output "container_2_info" {
  description = "Information about second container"
  value = {
    name = module.nginx_container_2.container_name
    url  = module.nginx_container_2.service_url
  }
}

output "all_urls" {
  description = "All service URLs"
  value = [
    module.nginx_container_1.service_url,
    module.nginx_container_2.service_url
  ]
}
```

**Explanation:**

* Access module outputs using `module.<name>.<output>`
* Demonstrates use of maps and lists
* Aggregates outputs from multiple module instances

---

## Commands to Execute

```bash
# 1. Navigate to day4 directory
cd day4

# 2. Initialize Terraform
terraform init

# 3. Preview (should show 4 resources: 2 images + 2 containers)
terraform plan

# 4. Apply configuration
terraform apply -auto-approve

# 5. Verify containers
docker ps

# 6. Test services
curl http://localhost:8081
echo "---"
curl http://localhost:8082

# 7. Check outputs
terraform output

# 8. Clean up
terraform destroy -auto-approve
```

---

## Expected Output

### After terraform apply

```text
Apply complete! Resources: 4 added (2 images, 2 containers)

Outputs:

all_urls = [
  "http://localhost:8081",
  "http://localhost:8082",
]

container_1_info = {
  "name" = "nginx-module-1"
  "url"  = "http://localhost:8081"
}

container_2_info = {
  "name" = "nginx-module-2"
  "url"  = "http://localhost:8082"
}
```

### After docker ps

```text
CONTAINER ID   IMAGE          PORTS                  NAMES
abc123...      99133eed2307   0.0.0.0:8081->80/tcp   nginx-module-1
def456...      99133eed2307   0.0.0.0:8082->80/tcp   nginx-module-2
```

---

## Key Concepts Learned

| Concept        | Description                      |
| -------------- | -------------------------------- |
| Module         | Reusable Terraform configuration |
| Source         | Path to module code              |
| Module inputs  | Variables passed into module     |
| Module outputs | Values returned to root          |
| Root module    | Main configuration               |
| Child module   | Reusable component               |
| DRY            | Don't Repeat Yourself            |

---

## Benefits of Modules

* Reusability: Write once, use many times
* Consistency: Same module ensures uniform setup
* Maintainability: Update in one place
* Readability: Cleaner code structure
* Shareability: Can be reused across projects

---

## Adding a Third Container

```hcl
module "nginx_container_3" {
  source = "./modules/nginx_container"
  container_name = "nginx-module-3"
  host_port      = 8083
}
```

---

## Real-World Application

Typical module structure in companies:

```text
modules/
├── networking/
├── database/
├── compute/
├── kubernetes/
└── monitoring/
```

---

## Learning Outcomes

* Created reusable Terraform module
* Understood module structure
* Used modules multiple times
* Accessed module outputs
* Built scalable and maintainable infrastructure
