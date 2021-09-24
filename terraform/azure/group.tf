data "azuread_user" "user" {
  for_each            = toset(var.kvGroupMembers)
  user_principal_name = each.key
}

resource "azuread_group" "group" {
  display_name = var.kvGroupName
  owners = [
    data.azuread_user.user[var.kvGroupOwner].id
  ]
  security_enabled   = true
  assignable_to_role = false
}

resource "azuread_group_member" "member" {
  for_each         = toset(var.kvGroupMembers)
  group_object_id  = azuread_group.group.id
  member_object_id = data.azuread_user.user[each.key].id
}
