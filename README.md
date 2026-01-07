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

```bash
cd terraform/azure
terraform init
terraform apply
```

*Note: Terraform will display the VM's public_ip in the outputs.*

### 2. Configure Ansible Inventory

Edit the `ansible/inventory.ini` file and replace the placeholders with your environment values:

```bash
[servers]
ubuntu_server ansible_host=<TARGET_IP> ansible_user=<SSH_USER>
```

> [!IMPORTANT]
> **Azure (Cloud):** Replace `<TARGET_IP>` with the public IP provided by Terraform after deployment.

> [!NOTE]
> **Local (On-premises):** Replace `<TARGET_IP>` with the local IP address of your server (e.g. `10.0.0.4`, `192.168.0.2`).

> [!TIP]
> **User configuration:** Replace `<SSH_USER>` with the SSH username of the target machine (e.g. `sysadmin01`, `azureuser`).

### 3. Deploy Configuration (Ansible)
Run the following command to start the automation process. This will apply all roles (`common`, `users`, `nginx`, `maintenance`) to your target server:


From the /ansible directory:

```bash
ansible-playbook -i inventory.ini site.yml -k -K
```

> [!TIP]
> **What do these flags mean?**
> * `-i inventory.ini`: Tells Ansible which servers to connect to.
> * `-k`: Prompts for the **SSH password** of the user.
> * `-K`: Prompts for the **Sudo password** (to install software).

---

## 📂 Repository Structure

Below is the organized directory structure of this hybrid environment:

```text

├── terraform/
│   └── azure/
│       ├── main.tf             # Infrastructure definition
│       └── outputs.tf          # Public IP and resource outputs
└── ansible/
    ├── ansible.cfg             # Ansible configuration and defaults
    ├── inventory.ini           # Server definitions (Cloud & On-prem)
    └── playbooks/
        ├── site.yml            # Main execution playbook
        └── roles/              # Modular automation tasks
            ├── common/         # Security & Updates
            ├── users/          # Identity management
            ├── nginx/          # Web server deployment
            └── maintenance/    # Backups & Cron jobs
```

## 🧹 Resource Cleanup
> [!CAUTION]
> **Resource Cleanup**
> To avoid unexpected costs in your Azure account, always destroy the infrastructure when finished:

```bash
terraform destroy
```

---

## 🏆 Academic Recognition

This project was developed as my **Final Degree Project**, representing the culmination of my studies and my specialization in Cloud Infrastructure and DevOps.

* **Final Grade**: **10 / 10 (Honors)** 🎓
* **Competencies**: Infrastructure as Code (IaC), Configuration Management, Hybrid Cloud Architecture, and Security Hardening.

---
*Developed with ❤️ as a demonstration of professional DevOps practices.*








