output "project_name" {
  value = module.project.project_name
}

output "project_id" {
  value = module.project.project_id
}

output "project_number" {
  value = module.project.project_number
}

output "service_account_id" {
  value       = module.project.service_account_id
  description = "The id of the default service account"
}

output "service_account_display_name" {
  value       = module.project.service_account_display_name
  description = "The display name of the default service account"
}

output "service_account_email" {
  value       = module.project.service_account_email
  description = "The email of the default service account"
}

output "service_account_name" {
  value       = module.project.service_account_name
  description = "The fully-qualified name of the default service account"
}

output "service_account_unique_id" {
  value       = module.project.service_account_unique_id
  description = "The unique id of the default service account"
}

output instance_template {
  description = "Link to the instance_template for the group"
  value = module.autoscaler.instance_template
}

output region_instance_group {
  description = "Link to the `instance_group` property of the region instance group manager resource."
  value       = module.autoscaler.region_instance_group
}

output target_tags {
  description = "Pass through of input `target_tags`."
  value       = module.autoscaler.target_tags
}

output service_port {
  description = "Pass through of input `service_port`."
  value       = module.autoscaler.service_port
}

output service_port_name {
  description = "Pass through of input `service_port_name`."
  value       = module.autoscaler.service_port_name
}

output region_depends_id {
  description = "Id of the dummy dependency created used for intra-module dependency creation with regional groups."
  value       = module.autoscaler.region_depends_id
}

output network_ip {
  description = "Pass through of input `network_ip`."
  value       = module.autoscaler.network_ip
}

output health_check {
  description = "The healthcheck for the managed instance group"
  value       = module.autoscaler.health_check
}