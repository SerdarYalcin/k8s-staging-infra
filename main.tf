resource "google_identity_platform_tenant" "flexer_stage" {
  project      = var.project_id
  display_name = "Flexer Stage"
}

resource "google_identity_platform_tenant_default_supported_idp_config" "email" {
  project    = var.project_id
  tenant     = google_identity_platform_tenant.flexer_stage.name
  provider   = "password"
  enabled    = true
}

resource "google_identity_platform_config" "default" {
  project = var.project_id

  sign_in {
    allow_duplicate_emails = false

    email {
      enabled = true
      password {
        enabled = true
      }
    }
  }

  user_management {
    allow_user_delete = true
    allow_user_sign_up = true
  }

  linking {
    link_accounts_with_same_email = true
  }
}
