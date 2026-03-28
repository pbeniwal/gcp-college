output "firestore_database_name" {
  value = google_firestore_database.default.name
}

output "pubsub_topic_name" {
  value = google_pubsub_topic.event_registrations.name
}

output "pubsub_subscription_name" {
  value = google_pubsub_subscription.event_registrations_sub.name
}

#output "cloud_run_service_account_email" {
#  value = google_service_account.cloud_run_sa.email
#}