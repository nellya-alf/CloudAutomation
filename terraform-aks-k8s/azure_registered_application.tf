# Generates a random password for SPN
resource "random_password" "password" {
  length  = 32
  special = true
}

#Generates a random password for the the database server
# resource "random_password" "db_password"{
#   length  = 16
#   special = true
# }

# Creates registered applcation
resource "azuread_application" "registered_application" {
  name                       = "${var.region_prefix}-${var.cluster_name}-application"
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
}

# Creates Service Principal
resource "azuread_service_principal" "service_principal" {
  application_id = azuread_application.registered_application.application_id

}

# Creates a SPN 
resource "azuread_service_principal_password" "spn_password" {
  service_principal_id = azuread_service_principal.service_principal.id
  value                = random_password.password.result
  end_date_relative    = "8765h"
}
