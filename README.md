<img width="532" height="302" alt="image" src="https://github.com/user-attachments/assets/1fe8ceea-a65a-4df5-8aa7-bb66e8a19727" />

# GCP Multi-VPC Secure Architecture & IaC Automation

Hands-on cloud infrastructure project designing, provisioning, and validating a multi-VPC network architecture on Google Cloud Platform (GCP) using **Terraform (HCL)**, **Git version control**, and **HCP Terraform Cloud**.

---

## 📐 Network Architecture Overview

The infrastructure provisions three isolated VPC networks across multiple regions (`us-central1` and `europe-west1`) to validate L3 routing, IP addressing schemes, firewall boundary controls, and compute instance connectivity.

## 🛠️ Tech Stack & Tools

* **Cloud Provider:** Google Cloud Platform (GCP)
* **Infrastructure as Code:** HashiCorp Terraform (HCL)
* **Remote State & Operations:** HCP Terraform (Terraform Cloud)
* **Version Control:** Git / GitHub Desktop
* **IDE:** VS Code
* **Compute:** Compute Engine (Debian 12 Linux instances)

---

## ✨ Key Features & Best Practices

* **Infrastructure as Code (IaC):** Modular code structure separated into `main.tf`, `variables.tf`, `outputs.tf`, `terraform.tfvars`, and `versions.tf`.
* **Multi-VPC & Regional Design:** Provisioned both Auto-mode and Custom-mode VPC networks across `us-central1` and `europe-west1`.
* **Boundary Security:** Configured granular GCP Firewall rules (`allow-ssh`, `allow-icmp`) targeting specific instance tags to isolate management and private workloads.
* **Remote State Management:** Integrated GitHub repository with **HCP Terraform Cloud** for remote execution plans and state tracking.
* **FinOps & Lifecycle Control:** Implemented full lifecycle management, utilizing `terraform destroy` workflows for environment teardown and cost control.

---

## 🚀 Execution Workflow

1. **Initialize & Validate Code:**
   ```bash
   terraform init
   terraform validate

   Plan & Apply Infrastructure (HCP Terraform Cloud / CLI):

Bash
terraform plan
terraform apply
Validate L3 Connectivity:
SSH into VM instances to test ICMP/IP routing across subnets and verify firewall rule enforcement.

Resource Teardown:

Bash
terraform destroy


👤 Author
Camilo Andres

Senior Network & Security Engineer | SASE & Cloud Networking Specialist
