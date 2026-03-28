# Serverless College Event Notification App 

**Course**: Google Cloud Digital Leader  
**Services Used**: Cloud Run, Firestore, Pub/Sub, Cloud Build (CI/CD)  
**Objective**: Infrastructure & application modernization + Operational excellence (Modules 4 & 6)

## Architecture
- Frontend: Flask web app (HTML form)
- Database: Firestore (NoSQL)
- Messaging: Pub/Sub (real-time notifications)
- Hosting: Cloud Run (serverless)
- CI/CD: Google Cloud Build

## Local Setup
1. `pip install -r requirements.txt`
2. `python app.py`

## CI/CD with Google Cloud Build (Google DevOps)
- Every push to `main` automatically builds Docker image and deploys to Cloud Run.
- See `cloudbuild.yaml`

## Deployment Steps (One-time)
1. Create Firestore database (Native mode, asia-south1)
2. Create Pub/Sub topic: `event-registrations`
3. Enable Cloud Build, Cloud Run, Firestore, Pub/Sub APIs
4. Connect this GitHub repo to Cloud Build (Triggers → Create Trigger)
5. Push code → CI/CD runs automatically

Live Demo URL will appear after first successful build.