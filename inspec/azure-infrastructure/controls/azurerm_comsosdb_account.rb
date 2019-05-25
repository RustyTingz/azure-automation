cosmos_db_account = attribute('azure_cosmosdb')

control 'azurerm_azure_cosmosdb_account_rule' do

    cosmosdb_account_name = cosmos_db_account['name']
    location = cosmos_db_account['location']
    describe azurerm_cosmosdb_database_account(resource_group: cosmos_db_account['resource_group'], cosmosdb_database_account: cosmosdb_account_name) do
        its('name') { should eq cosmosdb_account_name }
        its('type') { should eq 'Microsoft.DocumentDB/databaseAccounts' }
        its('location') { should eq location }
      end
end