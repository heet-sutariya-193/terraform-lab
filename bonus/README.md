# Bonus Challenge: Dynamic Infrastructure Creation

## Problem Statement

Manually defining each resource (even with modules) does not scale. If you need 10, 50, or 100 containers, writing individual module blocks becomes impractical. We need a way to create infrastructure dynamically based on configuration data.

## Solution

Use Terraform's `count` parameter to create multiple resources from a list. Define the desired infrastructure in a list variable, and Terraform automatically creates one resource per list item.

## Assignment Requirements

* Define a variable `container_config` as a list of objects
* Each object should have `name` and `port` fields
* Use `count` to create one container per list item
* Create outputs showing all container URLs
* Support adding/removing containers by changing the list

## Files Created

| File            | Purpose                                  |
| --------------- | ---------------------------------------- |
| `main.tf`       | Uses count to create multiple containers |
| `variables.tf`  | Defines list of container configurations |
| `outputs.tf`    | Dynamically generates URLs and details   |
| `custom.tfvars` | Example with 4 containers                |
| `README.md`     | This documentation file                  |

---

## File Explanations

### variables.tf — Configuration List

```hcl id="b7w2ak"
variable "container_config" {
  description = "List of container configurations"
  type = list(object({
    name = string
    port = number
  }))

  default = [
    {
      name = "web1"
      port = 8081
    },
    {
      name = "web2"
      port = 8082
    },
    {
      name = "web3"
      port = 8083
    }
  ]
}
```

**Explanation:**

* `list(object({...}))` defines a structured list
* Each item contains multiple fields (name, port)
* Default configuration creates 3 containers

---

### main.tf — Dynamic Resource Creation

```hcl id="y0yrd6"
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

# Pull nginx image once
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Create containers dynamically
resource "docker_container" "nginx" {
  count = length(var.container_config)

  image = docker_image.nginx.image_id
  name  = var.container_config[count.index].name

  ports {
    internal = 80
    external = var.container_config[count.index].port
  }
}
```

---

## How `count` Works

| count.index | List Item                  | Result                                |
| ----------- | -------------------------- | ------------------------------------- |
| 0           | `{name="web1", port=8081}` | Creates container "web1" on port 8081 |
| 1           | `{name="web2", port=8082}` | Creates container "web2" on port 8082 |
| 2           | `{name="web3", port=8083}` | Creates container "web3" on port 8083 |

---

### outputs.tf — Dynamic Outputs

```hcl id="k6n4xk"
output "container_urls" {
  description = "List of all container URLs"
  value = [
    for config in var.container_config :
    "http://localhost:${config.port}"
  ]
}

output "container_details" {
  description = "Detailed information about each container"
  value = {
    for idx, container in docker_container.nginx :
    container.name => {
      id  = container.id
      url = "http://localhost:${var.container_config[idx].port}"
    }
  }
}

output "total_containers" {
  description = "Total number of containers created"
  value       = length(docker_container.nginx)
}
```

---

### custom.tfvars — Adding More Containers

```hcl id="z9v6tn"
container_config = [
  {
    name = "nginx-blue"
    port = 8081
  },
  {
    name = "nginx-green"
    port = 8082
  },
  {
    name = "nginx-red"
    port = 8083
  },
  {
    name = "nginx-yellow"
    port = 8084
  }
]
```

---

## Commands to Execute

```bash id="y4w8ak"
# 1. Navigate to bonus directory
cd bonus

# 2. Initialize
terraform init

# 3. Preview (default: 3 containers)
terraform plan

# 4. Apply
terraform apply -auto-approve

# 5. Verify containers
docker ps
curl http://localhost:8081
curl http://localhost:8082
curl http://localhost:8083

# 6. Check outputs
terraform output

# 7. Add a 4th container
terraform apply -var-file="custom.tfvars" -auto-approve

# 8. Verify new container
docker ps
curl http://localhost:8084

# 9. Check updated outputs
terraform output

# 10. Clean up
terraform destroy -auto-approve
```

---

## Expected Output

### Default (3 containers)

```text id="9g7l0s"
container_urls = [
  "http://localhost:8081",
  "http://localhost:8082",
  "http://localhost:8083",
]

total_containers = 3
```

### With custom.tfvars (4 containers)

```text id="r9c2pd"
container_urls = [
  "http://localhost:8081",
  "http://localhost:8082",
  "http://localhost:8083",
  "http://localhost:8084",
]

total_containers = 4
```

---

## Key Concepts Learned

| Concept         | Description                                |
| --------------- | ------------------------------------------ |
| count           | Meta-argument to create multiple instances |
| count.index     | Current iteration index                    |
| List of objects | Structured input with multiple fields      |
| For expressions | Transform collections dynamically          |
| Dynamic outputs | Outputs adapt to configuration             |
| Scalability     | Add/remove resources via data              |

---

## Learning Outcomes

* Created dynamic infrastructure using `count`
* Used complex variable types (list of objects)
* Implemented loops and for expressions
* Built scalable configurations
* Reduced manual repetition in infrastructure code

<img width="845" height="592" alt="image" src="https://github.com/user-attachments/assets/cd1abfb8-4021-4fcc-a7f7-d152fb4e29ee" />
<img width="1462" height="153" alt="image" src="https://github.com/user-attachments/assets/032546fe-f0c1-4ea6-a431-803eb8730b48" />

