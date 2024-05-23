resource "google_project_service" "identitytoolkit" {
  project = var.project_id
  service = "identitytoolkit.googleapis.com"
  disable_on_destroy = true
}

resource "google_identity_platform_tenant" "tenant" {
  display_name         = var.tenant_name
  allow_password_signup = true
}

