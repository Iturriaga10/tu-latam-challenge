# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_schema

resource "google_pubsub_schema" "latam_challengue_schema" {
  name = "example"
  type = "AVRO"
  definition = "{\n  \"type\" : \"record\",\n  \"name\" : \"Avro\",\n  \"fields\" : [\n    {\n      \"name\" : \"StringField\",\n      \"type\" : \"string\"\n    },\n    {\n      \"name\" : \"IntField\",\n      \"type\" : \"int\"\n    }\n  ]\n}\n"
}

resource "google_pubsub_topic" "latam_challengue_pubsub" {
  name = "latam-challengue"

  labels = {
    createdBy = "Terraform"
  }

  message_retention_duration = "86600s"
  depends_on = [google_pubsub_schema.latam_challengue_schema]
  
  schema_settings {
    schema = "projects/my-project-name/schemas/example"
    encoding = "JSON"
  }
}

resource "google_pubsub_subscription" "example" {
  name  = "latam-challengue-subscription"
  topic = google_pubsub_topic.latam_challengue_pubsub.name

  ack_deadline_seconds = 20

  labels = {
    createdBy = "Terraform"
  }

  push_config {
    push_endpoint = "https://example.com/push"

    attributes = {
      x-goog-version = "v1"
    }
  }
}