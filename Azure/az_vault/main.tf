provider "azurerm" {
  features {}
}

resource "random_string" "lower" {
  length = 9
  upper   = false
  lower   = true
  number  = false
  special = false
  override_special = "/@£$"
}

data "azurerm_client_config" "current" {}

# Create Azure AD User Admin
resource "azuread_user" "user-lootsec-sysadmin" {
  user_principal_name = "sysadmin@lootseclabs.com"
  display_name        = "SysAdmin User"
  mail_nickname       = "sysadminuser"
  password            = "Sup3rS3cr3t@"
}
# Create Azure AD User
resource "azuread_user" "user-lootsec-reader" {
  user_principal_name = "jdoe@lootseclabs.com"
  display_name        = "John Doe"
  mail_nickname       = "jdoe"
  password            = "Sup3rS3cr3t@"
}

# Create Azure AD Group for supererusers
resource "azuread_group" "superusers" {
  display_name = "superusers"
  description = "superusers Group"
  members = [ 
    azuread_user.user-lootsec-sysadmin.object_id,
  ]
}

# Create Azure AD Group for readers
resource "azuread_group" "readers" {
  display_name = "readers"
  description = "Readers Group"
  members = [ 
    azuread_user.user-lootsec-reader.object_id,
  ]
}

# Create a resource group 
resource "azurerm_resource_group" "Loot-resourceGroup01" {
  name     = "Loot-resourceGroup01"
  location = "West Europe"
}

# Create the keyvault 
resource "azurerm_key_vault" "LootKeyVault" {
  name                        = "Vault-${random_string.lower.result}"
  location                    = azurerm_resource_group.Loot-resourceGroup01.location
  resource_group_name         = azurerm_resource_group.Loot-resourceGroup01.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = false

  sku_name = "standard"

# data "azuread_group" "superusers" {
#   display_name = "superusers"
# }

# data "azuread_group" "readers" {
#   display_name = "readers"
# } 

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "create",
      "get",
      "list",
    ]

    secret_permissions = [
      "set",
      "get",
      "list",
      "delete",
    ]

    storage_permissions = [
      "get",
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azuread_group.superusers.object_id

    key_permissions = [
      "create",
      "get",
      "list",
    ]

    secret_permissions = [
      "set",
      "get",
      "list",
      "delete",
    ]

    storage_permissions = [
      "get",
    ]
  }

  network_acls {
    default_action = "Allow"
    bypass = "AzureServices"
  }

  tags = {
    environment = "Lootseclabs"
  }
}

resource "azurerm_key_vault_secret" "Vault" {
  name         = "Vault"
  value        = "W!nt3RPa$5word!"
  key_vault_id = azurerm_key_vault.LootKeyVault.id

  tags = {
    environment = "Lootseclabs"
  }
}

data "azurerm_key_vault" "LootKeyVault"{
  name = "Vault-${random_string.lower.result}"
  resource_group_name = "Loot-resourceGroup01"

  depends_on = [
  azurerm_key_vault.LootKeyVault,
  ]
 }

data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "Loot-Config" {
}

resource "azurerm_role_assignment" "Loot-Config" {
  scope                = data.azurerm_key_vault.LootKeyVault.id
  role_definition_name = "Contributor"
  principal_id         =  azuread_group.readers.object_id
}

