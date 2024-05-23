resource "google_identity_platform_tenant" "flexer_stage" {
  project      = var.project_id
  display_name = "Flexer Stage"
}

resource "google_identity_platform_tenant_default_supported_idp_config" "email" {
  project    = var.project_id
  tenant     = google_identity_platform_tenant.flexer_stage.name
  provider_id = "password"
  enabled    = true
}

resource "google_identity_platform_tenant_default_supported_idp_config" "email_link" {
  project    = var.project_id
  tenant     = google_identity_platform_tenant.flexer_stage.name
  provider_id = "emailLink"
  enabled    = true
}

resource "google_identity_platform_project_default_config" "default_config" {
  project = var.project_id

  sign_in {
    email {
      enabled = true
      password {
        enabled = true
      }
    }
  }

  user_management {
    allow_sign_up = true
    allow_delete  = true
  }

  linking {
    link_accounts_with_same_email = true
  }
}
