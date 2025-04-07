# 🔐 Terraform + Ansible Hybrid Lab for EC2 Security Patching

## 🚀 Project Goal

This project demonstrates a hybrid DevOps approach using **Terraform** for provisioning infrastructure and **Ansible** for automating configuration tasks — specifically focusing on **security patching** of an AWS EC2 instance.

By combining both tools, we create a reliable and repeatable infrastructure pipeline that goes from creating a server to keeping it updated securely.

---

## 🛠️ Tools & Technologies Used

| Tool/Service     | Description |
|------------------|-------------|
| **Terraform**     | Infrastructure as Code (IaC) tool used to provision AWS resources like EC2, Security Groups, and Key Pairs. |
| **Ansible**       | Configuration management tool used to automate package updates and system patching. |
| **AWS EC2**       | Cloud compute instance running Amazon Linux 2. |
| **SSH**           | Secure remote login to the instance using a generated key pair. |
| **Ubuntu VM (Local)** | Control node used to run Terraform and Ansible commands. |

---

## 🤝 Why Use Terraform + Ansible?

| Aspect                | Terraform                          | Ansible                                   |
|-----------------------|------------------------------------|-------------------------------------------|
| Infrastructure Setup  | ✅ Manages EC2, Key Pairs, Security Groups | ❌ |
| Configuration Mgmt    | ❌                                   | ✅ Installs packages, patches, runs commands |
| Language              | HCL (Declarative)                  | YAML (Declarative)                        |
| Reusability           | High (Reusable modules/variables)  | High (Roles, playbooks, inventories)      |
| Idempotency           | ✅                                  | ✅                                         |

> 🔄 Together, they ensure **automated, repeatable and secure deployments.**

---

## 📂 Folder Structure

<pre lang="markdown"> 
```
terraform-ansible-hybrid-lab/ 
   ├── terraform/ 
   │ ├── main.tf # Terraform configuration for EC2 and resources 
   │ ├── variables.tf # Input variables 
   │ ├── outputs.tf # Outputs like public IP 
   ├── ansible/ 
   │ ├── aws_inventory.ini # Static Ansible inventory with EC2 IP 
   │ └── playbooks/ 
   │ └── patching.yml # Ansible playbook for security patching 
   ├── .gitignore # Ignore sensitive and generated files 
   └── README.md # Project overview and instructions ``` 
</pre>




---

## 🧪  1️⃣  Prerequisites

- AWS account with access keys
- Terraform and Ansible installed
- SSH key pair (you can generate it with):
  ```bash
  ssh-keygen -t rsa -b 4096

## 2️⃣  Set Environment Variables (Optional but cleaner)

```
   export AWS_ACCESS_KEY_ID=<your-access-key>
   export AWS_SECRET_ACCESS_KEY=<your-secret-key>
   export AWS_DEFAULT_REGION=your_region 
```

## 3️⃣  Provision EC2 with Terraform
```
cd terraform
terraform init
terraform apply
```
## 4️⃣  Update Ansible Inventory File

# ansible/aws_inventory.ini
[aws_targets]
<your-ec2-public-ip> ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/id_rsa

## 6️⃣  Run Security Patching Playbook

```ansible-playbook -i ansible/aws_inventory.ini ansible/playbooks/patching.yml``` 

📦 Example patching.yml:

---
- name: Security patching on AWS EC2
  hosts: aws_targets
  become: yes

  tasks:
    - name: Update all packages (Amazon Linux 2)
      dnf:
        name: '*'
        state: latest
        update_cache: yes

✅  Outcome

🚀 Fully automated EC2 instance setup with Terraform

🔐 SSH key-based secure login

⚙️ Ansible-automated system update/patching

🧹 Clean and reusable infrastructure + config



📌  Future Improvements
 
Automate Ansible inventory using Terraform output

Set up dynamic inventory with EC2 tags

Push logs and patch reports to CloudWatch or S3

Add a CI/CD pipeline with GitHub Actions or Jenkins







👨‍ 💻 Author
 [Harsh Rathod]
