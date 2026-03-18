# Day 3: Managing Containers with Terraform

## Problem Statement

Modern applications run in containers for consistency and portability. Manually running Docker commands is error-prone and not repeatable. We need a way to define and manage containers as code.

## Solution

Use Terraform's Docker provider to define and manage containers. Write configuration that pulls images, creates containers, and maps ports — all as reusable, version-controlled code.

## Assignment Requirements

* Configure Docker provider in Terraform
* Pull nginx image
* Create Docker container mapping port 80 to 8080
* Add output for service URL
* Verify container is running and accessible

## Files Created

| File           | Purpose                                                |
| -------------- | ------------------------------------------------------ |
| `main.tf`      | Docker provider config, image, and container resources |
| `variables.tf` | Container name and port variables                      |
| `outputs.tf`   | Service URL and container information                  |
| `README.md`    | This documentation file                                |

---

## File Explanations

### main.tf

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

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name

  ports {
    internal = var.container_port
    external = var.host_port
  }
}
```

**Explanation:**

* `provider "docker"` connects to the local Docker daemon
* `docker_image` pulls the nginx image from Docker Hub
* `docker_container` creates and runs a container
* `ports` maps container port (80) to host port (8080)
* `image = docker_image.nginx.image_id` ensures dependency (image is created first)

---

### variables.tf

```hcl
variable "container_name" {
  description = "Name of the Docker container"
  type        = string
  default     = "nginx-terraform"
}

variable "container_port" {
  description = "Port inside the container"
  type        = number
  default     = 80
}

variable "host_port" {
  description = "Port on the host machine"
  type        = number
  default     = 8080
}
```

**Explanation:**

* `container_name`: Identifies the container in Docker
* `container_port`: nginx runs internally on port 80
* `host_port`: Port used to access the service from browser

---

### outputs.tf

```hcl
output "service_url" {
  description = "URL to access nginx"
  value       = "http://localhost:${var.host_port}"
}

output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.nginx.id
}

output "container_name" {
  description = "Name of the Docker container"
  value       = docker_container.nginx.name
}
```

**Explanation:**

* `service_url`: URL to access the running web server
* `container_id`: Docker’s unique identifier
* `container_name`: Name assigned to the container

---

## Commands to Execute

```bash
# 1. Navigate to day3 directory
cd day3

# 2. Initialize Terraform (downloads Docker provider)
terraform init

# 3. Preview what will be created
terraform plan

# 4. Create the container
terraform apply -auto-approve

# 5. Verify container is running
docker ps

# 6. Test nginx is working
curl http://localhost:8080
# Or open browser: http://localhost:8080

# 7. Check outputs
terraform output

# 8. Clean up
terraform destroy -auto-approve

# 9. Verify container is removed
docker ps
```

---

## Expected Output

### After terraform apply

```text
Apply complete! Resources: 2 added (1 image, 1 container)

Outputs:

container_id = "03c395e2027fb8e0eab5518c2a01ffe..."
container_name = "nginx-terraform"
service_url = "http://localhost:8080"
```

### After docker ps

```text
CONTAINER ID   IMAGE          PORTS                  NAMES
03c395e2027f   99133eed2307   0.0.0.0:8080->80/tcp   nginx-terraform
```

### Browser / curl output

```text
Welcome to nginx! (HTML welcome page)
```

---

## Key Concepts Learned

| Concept             | Description                                            |
| ------------------- | ------------------------------------------------------ |
| Docker provider     | Enables Terraform to manage Docker                     |
| Image               | Template/blueprint for containers (e.g., nginx:latest) |
| Container           | Running instance of an image                           |
| Port mapping        | Connects container port to host port (8080:80)         |
| Image vs Container  | Image is the recipe, container is the execution        |
| Resource dependency | Container depends on image creation                    |

---

## Docker Commands Comparison

| Action          | Docker CLI                    | Terraform                   |
| --------------- | ----------------------------- | --------------------------- |
| Pull image      | `docker pull nginx`           | `docker_image` resource     |
| Run container   | `docker run -p 8080:80 nginx` | `docker_container` resource |
| List containers | `docker ps`                   | `terraform output`          |
| Stop container  | `docker stop`                 | `terraform destroy`         |
| Remove image    | `docker rmi`                  | Handled during destroy      |

---

## Real-World Application

This pattern is used to deploy:

* Web applications (like nginx)
* Databases (MySQL, PostgreSQL)
* API services
* Microservices architectures
* Development environments

---

## Learning Outcomes

* Configured and used Docker provider
* Pulled images from Docker Hub
* Created containers with port mapping
* Understood resource dependencies
* Accessed running services via browser
* Properly cleaned up container resources
