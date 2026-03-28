# Enable required APIs (prerequisites)
resource "google_project_service" "firestore" {
  service            = "firestore.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "pubsub" {
  service            = "pubsub.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "run" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "iam" {
  service            = "iam.googleapis.com"
  disable_on_destroy = false
}

# Firestore Database (Native mode)
#resource "google_firestore_database" "default" {
#  depends_on = [google_project_service.firestore]

#  project     = var.project_id
#  name        = "(default)"
#  location_id = var.region
#  type        = "FIRESTORE_NATIVE"

#  delete_protection_state = "DELETE_PROTECTION_DISABLED"  # For student project
#}

# Pub/Sub Topic
#resource "google_pubsub_topic" "event_registrations" {
#  depends_on = [google_project_service.pubsub]
#  name       = "event-registrations"
#}

# Pub/Sub Subscription (pull-based)
#resource "google_pubsub_subscription" "event_registrations_sub" {
#  depends_on = [google_pubsub_topic.event_registrations]
#  name       = "event-registrations-sub"
#  topic      = google_pubsub_topic.event_registrations.name

#  ack_deadline_seconds = 20
#}

# Service Account for Cloud Run (least privilege)
#resource "google_service_account" "cloud_run_sa" {
#  account_id   = "event-app-cloud-run"
#  display_name = "Service Account for Event App Cloud Run"
#}

# IAM Roles for Cloud Run SA
resource "google_project_iam_member" "firestore_access" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

resource "google_project_iam_member" "pubsub_publisher" {
  project = var.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

resource "google_project_iam_member" "pubsub_subscriber" {
  project = var.project_id
  role    = "roles/pubsub.subscriber"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

# Optional: Cloud Run Service (can be deployed via Terraform too)
# (Comment out if you prefer Cloud Build deployment)
# resource "google_cloud_run_service" "event_app" {
#   name     = "event-app"
#   location = var.region
#   template {
#     spec {
#       containers {
#         image = "gcr.io/${var.project_id}/event-app:latest"  # Will be updated by CI/CD
#       }
#     }
#   }
#   depends_on = [google_project_service.run]
# }