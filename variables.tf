variable "monitor_action_group_lookup" {
  description = <<EOT
Map of monitor_action_group_lookup, attributes below
Required:
    - name
    - resource_group_name
EOT

  type = map(object({
    name                = string
    resource_group_name = string
  }))
  validation {
    condition = alltrue([
      for k, v in var.monitor_action_group_lookup : (
        length(v.name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.monitor_action_group_lookup : (
        length(v.resource_group_name) <= 90
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) > 90]"
  }
  validation {
    condition = alltrue([
      for k, v in var.monitor_action_group_lookup : (
        !endswith(v.resource_group_name, ".")
      )
    ])
    error_message = "[from resourcegroups.ValidateName: must not end with \".\"]"
  }
  validation {
    condition = alltrue([
      for k, v in var.monitor_action_group_lookup : (
        length(v.resource_group_name) != 0
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) == 0]"
  }
  validation {
    condition = alltrue([
      for k, v in var.monitor_action_group_lookup : (
        alltrue([for item in v.event_hub_receiver : (item.name == null || (length(item.name) > 0))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.monitor_action_group_lookup : (
        alltrue([for item in v.event_hub_receiver : (item.event_hub_name == null || (length(item.event_hub_name) > 0))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.monitor_action_group_lookup : (
        alltrue([for item in v.event_hub_receiver : (item.event_hub_namespace == null || (length(item.event_hub_namespace) > 0))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.monitor_action_group_lookup : (
        alltrue([for item in v.event_hub_receiver : (item.tenant_id == null || (can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", item.tenant_id))))])
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.monitor_action_group_lookup : (
        alltrue([for item in v.event_hub_receiver : (item.subscription_id == null || (can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", item.subscription_id))))])
      )
    ])
    error_message = "must be a valid UUID"
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

