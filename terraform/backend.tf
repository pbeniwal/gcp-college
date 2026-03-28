terraform {
  backend "gcs" {
    bucket = "terraform-state-${var.project_id}"   # Will be created manually once
    prefix = "event-app"
  }
}