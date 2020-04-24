locals {
  env = terraform.workspace
}

output "env" {
  value = local.env
}

output "is_prod" {
  value = terraform.workspace == "prod"
}

output "is_staging" {
  value = terraform.workspace == "staging"
}
