# ☁️ Hybrid Cloud Automation: Terraform & Ansible Integration (Azure & On-premises)

This repository implements a professional **IaC (Infrastructure as Code)** and **Configuration Management** workflow. It demonstrates a hybrid automation model where infrastructure is provisioned in **Azure** using **Terraform** and managed from a local **On-premises** environment with **Ansible**.

## 🎯 Project Objective
The goal is to bridge the gap between local workstations and cloud providers. By implementing this hybrid model, we achieve:
* **Efficiency**: Eliminating manual configuration errors through automation.
* **Cost Optimization**: Leveraging Azure Free Tier resources with automated lifecycle management.
* **Security**: Enforcing a "Zero Password" policy by using SSH Key Pairs for all remote operations.

## 🏗️ Solution Architecture
* **🚀 Cloud Provisioning (Terraform)**: Automated deployment of a standardized Azure environment, including Networking (VNet, Subnets, Public IP) and Compute resources (Ubuntu VM).
* **⚙️ On-premises Management (Ansible)**: Playbooks executed from a local machine to perform remote configuration, security hardening, and service deployment via secure SSH tunneling.

---

## 🚀 Infrastructure as Code (Terraform Details)

The infrastructure is defined as modular components to ensure a secure and isolated environment in Azure. Terraform manages the following resources:

* **Network Stack**: 
    * **Virtual Network (VNet)**: Dedicated private network space.
    * **Subnet**: Segregated network segment for compute resources.
    * **Network Security Group (NSG)**: Cloud firewall pre-configured for SSH (22) and HTTP (80).
* **Compute**:
    * **Public IP**: Dynamically allocated for remote management.
    * **Ubuntu VM**: A `Standard_B1s` instance optimized for the Azure Free Tier.
* **Security**: Automatic injection of local SSH public keys (`id_rsa.pub`) for secure, passwordless access.

## 🛠️ Ansible Automation Details

The configuration is organized into four specialized roles to ensure scalability and maintainability:

* **`common`**: Updates system packages and configures the **UFW firewall**.
* **`users`**: Manages identity, creates DevOps/Admin groups, and injects SSH keys.
* **`nginx`**: Deploys a modular Nginx web server with custom landing pages.
* **`maintenance`**: Schedules automated daily backups and service restarts via **Cron**.

---

## 💻 Execution Guide

To deploy this hybrid environment, follow these steps from your local terminal:

### 1. Provision Infrastructure (Terraform)
cd terraform/azure
terraform init
terraform apply

*Note: Terraform will display the VM's public_ip in the outputs.*

### 2. Configure Ansible Inventory
Edit your `ansible/inventory.ini` file. This setup supports both Cloud (Azure) and Local (On-premises) targets. Update the IP and user to match your environment:

[servers]
# For Azure: Use the Public IP from Terraform
# For Local: Use your On-premises IP (e.g., 10.0.0.4)
# Change 'ansible_user' to your target username (e.g., inaki, sysadmin01)

ubuntu_server ansible_host=XX.XX.XX.XX ansible_user=sysadmin01

### 3. Deploy Configuration (Ansible)
cd ../../ansible
ansible-playbook site.yml

---

## 📂 Repository Structure
* **📁 /terraform/azure**: IaC files for cloud resources (main.tf, outputs.tf).
* **📁 /ansible**: Playbooks, inventory, and modular roles (common, users, nginx, maintenance).
* **🔒 Security**: All authentication is handled via SSH Key Pairs; no passwords stored.

## 🧹 Resource Cleanup
To avoid costs in Azure after testing:
terraform destroy

---
*🎓 This project was developed as part of a **Final Degree Project (TFG)** with a grade of **10/10**, focused on Hybrid Infrastructure Automation and DevOps best practices.*
