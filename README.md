# Infrastructure Setup using Terraform

This guide provides step-by-step instructions for provisioning infrastructure with **Terraform**, deploying the application, and configuring the server.

---

## 📦 Prerequisites

- **Terraform** installed  
  👉 [Install Terraform](https://developer.hashicorp.com/terraform/install#windows)
- **PuTTY / SSH client** for key generation and server access

For adding new Azure services, refer to:  
👉 [AzureRM Terraform Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)

---

## Initialize (first time or after module/provider changes):

Make sure you are in the right folder `environments/development` or `environments/production`

```bash
terraform init
```

---

## Managing Workspaces

Terraform workspaces let you isolate state for each environment (e.g., development, staging, production).

```bash
# View workspace help
terraform workspace --help

# Show the current workspace
terraform workspace show

# List all workspaces
terraform workspace list

# Create a new workspace
terraform workspace new "<PROJECT_NAME>"

# Switch to an existing workspace
terraform workspace select "<PROJECT_NAME>"

# Delete a workspace
terraform workspace delete "<PROJECT_NAME>"
```

---

## 🚀 Provision Infrastructure

Make sure you are in the right folder `environments/development` or `environments/production`

### Development Environment

```bash
# Dry run before apply
terraform plan -var-file="development.tfvars" -var="project_name=<CLIENT NAME>"

# Apply (Create resources)
terraform apply -var-file="development.tfvars" -var="project_name=<CLIENT NAME>"

# Destroy (Tear down resources)
terraform destroy -var-file="development.tfvars" -var="project_name=<CLIENT NAME>"
```

### Production Environment

```bash
# Dry run before apply
terraform plan -var-file="production.tfvars" -var="project_name=<CLIENT NAME>"

# Apply (Create resources)
terraform apply -var-file="production.tfvars" -var="project_name=<CLIENT NAME>"

```

### Destroy (Tear down resources)

⚠️ Warning: Running terraform destroy will permanently delete all resources provisioned by Terraform (databases, servers, storage, networking, etc.).
Only run this command if you are absolutely sure you want to tear down the entire environment.

```bash
terraform destroy -var-file="production.tfvars" -var="project_name=<CLIENT NAME>"
```