Flask EC2 Deployment with Terraform & Docker

Overview
This repository contains a simple Flask web application that is Dockerized and deployed to AWS EC2 using Terraform.
It demonstrates a complete DevOps workflow:
Flask app development
Containerization with Docker
Infrastructure as Code using Terraform
Automated EC2 provisioning and deployment
This is ideal for building a portfolio project that showcases cloud deployment and infrastructure management skills.

Project Structure

terraform-flask/
- main.tf          # Terraform configuration for EC2, Security Group, and Docker deployment
- variables.tf     # Terraform variables
- outputs.tf       # Terraform outputs (e.g., EC2 public IP)
- .gitignore       # Ignored files (Terraform binaries, state files, Python caches)
- app/             # Flask application code
   - app.py
   - requirements.txt
- Dockerfile       # Docker configuration for Flask app

Features

- Flask Web App: Simple Python application with a REST endpoint.
- Dockerized: Containerized for easy deployment.
- Terraform-managed EC2: Infrastructure as Code to provision EC2 and Security Groups.
- Automated Deployment: Docker container runs automatically on EC2 using my data on my Docker Hub.
- Versioned Infrastructure: Terraform files allow reproducible infrastructure setup.

Prerequisites
AWS Account with credentials configured
Terraform installed locally
Docker installed (for building the image)
Git installed

Setup Instructions
1. Clone the repository
git clone https://github.com/PelumiOwolabi/flask-ec2-terraform.git
cd flask-ec2-terraform

2. Build the Docker image
docker build -t adubi1e/flask-app:latest ./app
docker push adubi1/flask-app:latest

3. Initialize Terraform
terraform init

4. Review the plan
terraform plan

5. Apply Terraform configuration
terraform apply

6. Access the Flask app
terraform output: 18.135.45.212
