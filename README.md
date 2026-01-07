# 🚀 Hybrid Infrastructure Automation

This repository contains a full-stack automation suite designed to provision and configure high-availability web infrastructure. It currently features a modular **Ansible** architecture for server hardening and service deployment.

## 🏗 Project Architecture
The project is divided into two main stages:
1.  **Ansible**: Configuration management, security hardening, and service deployment (Nginx).
2.  **Terraform**: (In Progress) Cloud infrastructure provisioning on Azure.

---

## 🛠 Ansible Automation

The Ansible setup is organized into four specialized roles to ensure scalability and maintainability:

* **`common`**: Updates system packages and configures the `UFW` firewall (ports 22, 80, 443).
* **`users`**: Manages identity, creates DevOps/Admin groups, and injects SSH public keys for passwordless access.
* **`nginx`**: Deploys a modular Nginx web server with custom landing pages.
* **`maintenance`**: Schedules automated daily backups and service restarts via Cron.

### 📋 Prerequisites
* Ansible 2.10+ installed.
* SSH access to a target Ubuntu/Debian server.

### ⚙️ Setup & Execution

1.  **Configure Inventory**: Edit `ansible/inventory.ini` and set your server's IP and initial username (e.g., `inaki`).
    ```ini
    [servers]
    ubuntu_server ansible_host=10.0.0.4 ansible_user=inaki
    ```

2.  **First-Time Deployment**: If the server is fresh and requires password authentication, run:
    ```bash
    cd ansible
    ansible-playbook -i inventory.ini playbooks/site.yml --ask-pass --ask-become-pass
    ```

3.  **Subsequent Runs**: Once your SSH key is injected by the `users` role, simply run:
    ```bash
    ansible-playbook -i inventory.ini playbooks/site.yml
    ```

---

## 🛡 Security Features
* **SSH Hardening**: Automated public key injection.
* **Password Security**: All user passwords are managed via secure hashes.
* **Firewalling**: Strict UFW rules applied by default.

## 🔜 Roadmap
- [ ] Implement Terraform providers for Azure.
- [ ] Automate VNET and Subnet provisioning.
- [ ] Link Terraform outputs with Ansible inventory.