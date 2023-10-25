# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/api_gateway_gateway
# https://didil.medium.com/gcp-api-gateway-demo-with-terraform-go-cloud-run-f76148328e06

resource "google_api_gateway_api" "api_gw" {
  provider = google-beta
  api_id = "latam_challengue"
}

resource "google_api_gateway_api_config" "api_gw" {
  provider = google-beta
  api = google_api_gateway_api.api_gw.api_id
  api_config_id = "latam_challengue_config"

  openapi_documents {
    document {
      path = "spec.yaml"
      contents = filebase64("api.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "api_gw" {
  provider = google-beta
  api_config = google_api_gateway_api_config.api_gw.id
  gateway_id = "latam_challengue_gateway"
}