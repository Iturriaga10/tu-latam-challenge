# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table.html
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigtable_table

resource "google_bigquery_dataset" "latam_challengue_dataset" {
  dataset_id                  = "latam_challengue_foo"
  friendly_name               = "latam_challengue"
  description                 = "This is a bigquery dataset for latam challengue"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}

resource "google_bigquery_table" "latam_challengue_table" {
  dataset_id = google_bigquery_dataset.latam_challengue_dataset.dataset_id
  table_id   = "bar"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "permalink",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "The Permalink"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "State where the head office is located"
  }
]
EOF

}