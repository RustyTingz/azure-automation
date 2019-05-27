# Azure Infrastructure

This repository contains modules used to provision resources within Azure.

The automation within this repository can:

- Create a terraform state configuration terraform-config.tf that uses Azure and a prefix to ensure that the state does not conflict with other modules outside this repository
- Create CosmosDb terraform resources using ansible templating and associated resource group using the provided variables file `./src/attributes.yml`

## Requirements

- Pipenv `>=2018.11.26`
- Python `>=2.7.15`
- InSpec `>=3.3.14`
- Terraform `>= 0.11.13`
- Azure CLI Tool `az` `>=2.0.52`
- An Azure Service Principle account with contributor scope on the target subscriptions

## Getting Started

1. Copy .envrc-example to .envrc and fill in the fields with the values from your account.  Because of the inconsistencies between Ansible, Terraform and Inspec the required properties for Azure Service Principle authentication vary.

> The following environment variables are required - [For further details see Configuring the Service Principle in Terraform](https://www.terraform.io/docs/providers/azurerm/auth/service_principal_client_secret.html#configuring-the-service-principal-in-terraform)  

    ``` shell
    # Terraform uses the following variables for Azure Service Principle authentication
    export ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
    export ARM_CLIENT_SECRET="00000000-0000-0000-0000-000000000000"
    export ARM_SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"
    export ARM_TENANT_ID="00000000-0000-0000-0000-000000000000"

    # Inspec uses the following variables for Azure Service Principle authentication
    export AZURE_CLIENT_ID="00000000-0000-0000-0000-000000000000"
    export AZURE_CLIENT_SECRET="00000000-0000-0000-0000-000000000000"
    export AZURE_SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"
    export AZURE_TENANT_ID="00000000-0000-0000-0000-000000000000"

    # Ansible uses the following variables for Azure Service Principle authentication
    # export AZURE_CLIENT_ID - ALREADY DEFINED ABOVE
    # export AZURE_SUBSCRIPTION_ID - ALREADY DEFINED ABOVE
    export AZURE_SECRET="00000000-0000-0000-0000-000000000000"
    export AZURE_TENANT="00000000-0000-0000-0000-000000000000"
    ```


1. Source the .envrc file

    ```bash
        source .envrc
    ```

1. Define the `src/attributes.yml` file for provisioning the environment

## Make file commands

1. Install Python-related dependencies with `make init`
1. Build tf state container and template terraform `make build`
1. Create a terraform plan `make plan`
1. Apply terraform `make deploy`
1. Tear down the environment `make destroy`

## Terraform State

The state for this project relies on an Azure Storage Account, which is created using ansible and templated into the file `terraform-config.tf`
