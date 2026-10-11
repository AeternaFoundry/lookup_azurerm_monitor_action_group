data "azurerm_monitor_action_group" "monitor_action_group_lookup" {
  for_each = var.monitor_action_group_lookup

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

