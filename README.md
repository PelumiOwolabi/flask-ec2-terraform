## **flask-ec2-terraform` README (Linked Version)**

```markdown
# Flask EC2 Terraform

This repository contains **Terraform configuration** to automatically deploy a **Dockerized Flask app** on AWS EC2.

It is linked to [`flask-ec2-deploy`](https://github.com/PelumiOwolabi/flask-ec2-deploy), which contains the Flask app and Dockerfile.

---

## Features

- Provision EC2 instance in AWS
- Create security group and key pair
- Install Docker automatically
- Run Flask Docker container on startup
- Output EC2 public IP
- Fully reproducible infrastructure

---

## Requirements

- Terraform >= 1.0
- AWS CLI configured with credentials
- Docker image of the Flask app available on Docker Hub or ECR

---

## Setup & Deployment


```bash
**Clone the repository**
git clone https://github.com/<your-username>/flask-ec2-terraform.git
cd flask-ec2-terraform

Initialize Terraform
terraform init

Check plan
terraform plan

Apply configuration
terraform apply
Type yes when prompted.
Terraform will output the EC2 public IP.

Access Flask app
http://<EC2_PUBLIC_IP>:5000

Linking with Flask App
Make sure you have built and pushed your Docker image from flask-ec2-deploy to Docker Hub or ECR:

```bash
docker tag flask-app <your-dockerhub-username>/flask-app:latest
docker push <your-dockerhub-username>/flask-app:latest

Update the docker_image variable in Terraform:
variable "docker_image" {
  default = "<your-dockerhub-username>/flask-app:latest"
}

Run terraform apply - Terraform will deploy your app automatically using the image you pushed.

Notes
Existing EC2, Key Pair, and Security Group can be imported if needed:
terraform import aws_instance.terraform-flask <EC2_INSTANCE_ID>
terraform import aws_key_pair.flask_key <KEY_PAIR_NAME>
terraform import aws_security_group.flask_sg <SECURITY_GROUP_ID>

Never store AWS credentials or secrets in GitHub.
