terraform {
  backend "gcs" {
    bucket = "terraform-state-smart-processor-489814-r7" 
    prefix = "event-app"
  }
}