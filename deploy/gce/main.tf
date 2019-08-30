terraform {
  required_version = "~> 0.12"
  backend "gcs" {
      bucket = "gcp-foundation-build-projects/gce"
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# Locals
# ----------------------------------------------------------------------------------------------------------------------

locals {
  identifier = "${lower(var.name)}"
}

# ----------------------------------------------------------------------------------------------------------------------
# Project
# ----------------------------------------------------------------------------------------------------------------------

module "project" {
  source             = "git::git@gitlab.com:mandic-labs/terraform/modules/gcp/project.git?ref=master"
  name               = "${var.name}"
  admin_group_email  = "${var.admin_group_email}"
  admin_group_role   = "${var.admin_roles}"
  user_group_email   = "${var.user_group_email}"
  user_group_role    = "${var.user_roles}"
  org_id             = "${var.org_id}"
  project_id         = "${var.name}"
  shared_vpc         = "true"
  shared_vpc_project = "${var.shared_vpc_project}"
  billing_account    = "${var.billing_account}"
  folder_id          = "${var.folder_id}"
  activate_apis      = "${var.activate_apis}"
  //apis_authority              = "${var.apis_authority}"
  manage_group                = var.admin_group_email != "" ? true : false
  disable_services_on_destroy = var.disable_services_on_destroy
  disable_dependent_services  = var.disable_dependent_services
  environment                 = var.environment
}

# ----------------------------------------------------------------------------------------------------------------------
# Shared VPC Service
# ----------------------------------------------------------------------------------------------------------------------

module "shared-vpc-service" {
  source = "git::git@gitlab.com:mandic-labs/terraform/modules/gcp/shared-vpc-service.git?ref=master"
  host_project_name = "${var.shared_vpc_project}"
  service_project_name = "${module.project.project_id}"
}

# ----------------------------------------------------------------------------------------------------------------------
# Shared VPC Subnet
# ----------------------------------------------------------------------------------------------------------------------

module "subnet" {
  source = "git::git@gitlab.com:mandic-labs/terraform/modules/gcp/subnet.git?ref=master"
  project_id = "${var.shared_vpc_project}"
  name = "${var.name}"
  subnet_region = "${var.location}"
  vpc_name = "${var.shared_vpc_project_name}"
  ip_cidr_range = "${var.primary_ip_cidr_range}"
  secondary_ip_range_name = "${var.name}-secondary"
  secondary_ip_cidr = "${var.secondary_ip_cidr_range}"
}

# ----------------------------------------------------------------------------------------------------------------------
# AutoScaler
# ----------------------------------------------------------------------------------------------------------------------

module "autoscaler" {
  source = "git::git@gitlab.com:mandic-labs/terraform/modules/gcp/autoscaler.git?ref=master"

  project                       = "${module.project.project_id}"
  instance_template_name_prefix = "${var.name}-template"

  machine_type  = "${var.machine_type}"
  compute_image = "${data.google_compute_image.my_image.self_link}"
  disk_size_gb  = var.disk_size_gb
  region        = "${var.location}"
  network       = "projects/${var.shared_vpc_project}/global/networks/${var.shared_vpc_project_name}"
  subnetwork    = "${var.name}"

  instance_group_name = "${var.name}-instance-group"
  base_instance_name  = "${var.name}-vms"
  size                = var.instance_size
  service_port        = var.service_port
  service_port_name   = "${var.name}-port"

  autoscaler_name   = "${var.name}-autoscaler"
  health_check_name = "${var.name}-app-healthcheck"

  autoscaling_cpu = var.autoscaling_cpu
  
  instance_labels = {
    environment = "${var.environment}"
    projeto     = "${var.name}"
  }
}