run "valid_string_concat" {
  command = plan
  
  assert {
    condition     = azurerm_resource_group.rg.name == "rg-holm-terraform-01"
    error_message = "S3 bucket name did not match expected"
  }
}
