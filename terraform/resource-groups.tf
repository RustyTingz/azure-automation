#
# Ansible managed
#

 resource "azurerm_resource_group" "data-store-rg" {
     name     = "data-store-rg"
     location = "UK South"
 
     tags {
         name = "data-store-rg"
              environment = "staging"
              managedBy = "terraform"
              context = "integration-testing"
              team = "platform-engineering"
          }
 }
