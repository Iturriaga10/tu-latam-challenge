# Implement Policy
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam

resource "google_artifact_registry_repository" "latam_challengue_repo" {
  provider      = google-beta
  location      = "us-central1"
  repository_id = "latam_challengue"
  description   = "Latam Challengue docker repository"
  format        = "DOCKER"
  cleanup_policy_dry_run = false

  docker_config {
    immutable_tags = true
  }

  cleanup_policies {
    id     = "keep-minimum-versions"
    action = "KEEP"
    most_recent_versions {
      package_name_prefixes = ["api"]
      keep_count            = 5
    }
  }
}