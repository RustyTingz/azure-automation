#
# Ansible managed
#
resource "azurerm_cosmosdb_account" "cosmosdb-integration-test" {
  name                = "cosmosdb-integration-test"
  location            = "${azurerm_resource_group.data-store-rg.location}"
  resource_group_name = "${azurerm_resource_group.data-store-rg.name}"
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    prefix            = "cosmosdb-integration-test-customid"
    location          = "${azurerm_resource_group.data-store-rg.location}"
    failover_priority = 0
  }

  tags {
        name = "cosmosdb-integration-test"
            environment = "staging"
            managedBy = "terraform"
            context = "integration-testing"
            team = "platform-engineering"
      }
}