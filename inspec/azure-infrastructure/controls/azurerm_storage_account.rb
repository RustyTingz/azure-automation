storage_account = attribute('azure_tfstate_storage')

control 'azurerm_storage_accounts' do

    describe azurerm_storage_account_blob_container(resource_group: storage_account["resource_group"], storage_account_name: storage_account["account_name"], blob_container_name: storage_account["container_name"]) do
        it          { should exist }
        its('name') { should eq(storage_account["container_name"]) }
    end
end