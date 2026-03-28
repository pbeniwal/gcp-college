# Serverless College Event Notification App - Project 3 (Full CI/CD + Terraform)

**Google Cloud Digital Leader Capstone**  
**Services**: Cloud Run, Firestore, Pub/Sub, Cloud Build (CI/CD), Terraform (IaC)

## 🚀 CI/CD Flow (Automatic on every `git push`)
1. Push code to `main` → GitHub triggers Cloud Build
2. Terraform runs → Updates Firestore + Pub/Sub + IAM
3. Docker image built & pushed
4. Cloud Run service updated with new revision

## One-time Setup (Do this before first push)

1. **Create Terraform State Bucket** (manual, one time)
   ```bash
   gsutil mb -l asia-south1 gs://terraform-state-YOUR_PROJECT_ID
   gsutil versioning set on gs://terraform-state-YOUR_PROJECT_ID