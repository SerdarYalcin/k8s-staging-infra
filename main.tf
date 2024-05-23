resource "google_project_service" "identitytoolkit" {
  project = var.project_id
  service = "identitytoolkit.googleapis.com"
  disable_on_destroy = true
}

# resource "google_identity_platform_config" "default" {
#   project = var.project_id
#   autodelete_anonymous_users = true
#   sign_in {
#     allow_duplicate_emails = true

#     anonymous {
#         enabled = false
#     }
#     email {
#         enabled = true
#         password_required = true
#     }
#   }
#     # phone_number {
#     #     enabled = true
#     #     test_phone_numbers = {
#     #         "+11231231234" = "000000"
#     #     }
#     #}
#   # }
#   # sms_region_config {
#   #   allowlist_only {
#   #     allowed_regions = [
#   #       "US",
#   #       "CA",
#   #     ]
#   #   }
#   # }
#   # blocking_functions {
#   #   triggers {
#   #     event_type = "beforeSignIn"
#   #     function_uri = "https://us-east1-my-project.cloudfunctions.net/before-sign-in"
#   #   }
#   #   forward_inbound_credentials {
#   #     refresh_token = true
#   #     access_token = true
#   #     id_token = true
#   #   }
#   # }
# #   quota {
# #     sign_up_quota_config {
# #       quota = 1000
# #       start_time = ""
# #       quota_duration = "7200s"
# #     }
# #   }
# #   authorized_domains = [
# #     "localhost",
# #     "my-project.firebaseapp.com",
# #     "my-project.web.app",
# #   ]
#  }


resource "google_identity_platform_config" "default" {
  project = var.project_id

  autodelete_anonymous_users = true

  sign_in {
    allow_duplicate_emails = false

    email {
      enabled           = true
      password_required = true
    }
  }

  user_management {
    allow_user_delete = true
    allow_user_sign_up = true
  }

  linking {
    link_accounts_with_same_email = true
  }

  multi_tenant {
    allow_tenants = true
  }
}

resource "google_identity_platform_tenant" "tenant" {
  project      = var.project_id
  display_name = var.tenant_name
  allow_password_signup = true
}

resource "google_identity_platform_tenant_default_supported_idp_config" "email" {
  project    = var.project_id
  tenant     = google_identity_platform_tenant.tenant.name
  provider_id = "password"
  enabled    = true
}
