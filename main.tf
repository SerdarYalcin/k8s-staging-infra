resource "google_identity_platform_tenant" "flexer_stage" {
  project      = var.project_id
  tenant_id    = var.tenant_name
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

resource "google_identity_platform_tenant_default_supported_idp_config" "custom_token" {
  project    = var.project_id
  tenant     = google_identity_platform_tenant.flexer_stage.name
  provider_id = "custom"
  enabled    = true
}

resource "google_identity_platform_tenant_default_supported_idp_config" "phone" {
  project    = var.project_id
  tenant     = google_identity_platform_tenant.flexer_stage.name
  provider_id = "phone"
  enabled    = false
}

resource "google_identity_platform_tenant_default_supported_idp_config" "anonymous" {
  project    = var.project_id
  tenant     = google_identity_platform_tenant.flexer_stage.name
  provider_id = "anonymous"
  enabled    = false
}

resource "google_identity_platform_tenant_config" "tenant_settings" {
  project = var.project_id
  tenant  = google_identity_platform_tenant.flexer_stage.name

  allow_duplicate_emails = false

  sign_in {
    email {
      enabled = true
      password {
        enabled = true
      }
      link_accounts {
        action = "linkAccountsWithSameEmail"
      }
    }
  }

  user_account_management {
    sign_up_allowed = true
    delete_allowed  = true
  }
}
