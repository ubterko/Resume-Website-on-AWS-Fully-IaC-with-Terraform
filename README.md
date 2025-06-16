# Overview
## 🌐 Resume Website on AWS (Fully IaC with Terraform)

This project is a **cloud-native resume website** built using **Terraform**, featuring a complete AWS serverless stack. It demonstrates infrastructure automation with Terraform, serverless computing - AWS, and modern web hosting on the cloud.

---

## 🚀 Features

- **Static website** hosted on **Amazon S3** and served via **CloudFront**
- **Page visit counter** using:
  - Frontend-triggered **AWS Lambda function**
  - Serverless data persistence via **DynamoDB**
- **Infrastructure as Code (IaC)** using **Terraform**
- Simple HTML + CSS frontend
- Modular, production-grade Terraform layout

---

## 🧱 Technologies Used

| Technology   | Purpose                        |
|--------------|--------------------------------|
| Terraform    | Infrastructure provisioning    |
| AWS S3       | Static site hosting            |
| AWS CloudFront | CDN and HTTPS support         |
| AWS Lambda   | Serverless backend logic       |
| AWS DynamoDB | Storing and updating page views |
| HTML & CSS   | Frontend design                |

---

## 📁 Project Structure

```

.
├── backend/
│   ├── lambda/
│   │   ├── script.py            # Lambda function code
│   │   └── lambda\_script.zip    # Deployment package
│   ├── main.tf                  # Backend resources (Lambda, IAM, DynamoDB)
│   └── output.tf
├── frontend/
│   ├── main.tf                  # S3 bucket, CloudFront, and static site config
│   ├── output.tf
│   └── variables.tf
├── main.tf                      # Root module that integrates frontend and backend
├── terraform.tfvars             # Variable values

````

---

## 🛠️ How It Works

1. **Frontend Hosting**
   - HTML/CSS files are hosted on S3 and delivered via CloudFront.
   - Website is accessible over HTTP globally.

2. **Page Visit Tracking**
   - Every time the page loads, frontend JavaScript sends a request to a public API endpoint (API Gateway or Lambda URL).
   - The Lambda function:
     - Reads and increments the visit count from DynamoDB.
     - Returns the updated count to display on the page.

3. **Terraform**
   - Fully automates the provisioning of all AWS resources.
   - Modular structure keeps `frontend` and `backend` decoupled but manageable.

---

## 📦 Deployment Instructions

> Prerequisites:
> - AWS CLI configured
> - Terraform v1.3+
> - Zip Lambda code before applying (`zip lambda_script.zip script.py`)

### Step 1: Initialize Terraform
```bash
terraform init
````

### Step 2: Review the Execution Plan

```bash
terraform plan
```

### Step 3: Apply the Infrastructure

```bash
terraform apply
```

### Step 4: Upload Website Files (after infra is created)

```bash
aws s3 cp ./frontend/website s3://ebonko-resume-bucket-ie25 --recursive
```

## 🧑‍💻 Author

Israel Ebonko – a cloud enthusiast and backend engineer.

