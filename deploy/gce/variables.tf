variable "name" {
  description = "Project Name"
  default= "gke-service-project"
}

variable "activate_apis" {
  description = "Google Apis required list for the project e.g. iam.googleapis.com,container.googleapis.com"
  default     = "iam.googleapis.com,container.googleapis.com,compute.googleapis.com"
}

variable "apis_authority" {
  default = false
}

variable "org_id" {
  description = "Organization ID"
  default     = ""
}

variable "folder_id" {
  description = "Folder ID"
  default     = "184515897165"
}

variable "credentials_path" {
  default = "sa_account.json"
}

variable "billing_account" {
  default = "01BD07-2E6EE4-EDF01B"
  description = "ID from Billing Account"
}

variable "user_roles" {
  default = "roles/user"
  description = "Roles for User"
}

variable "admin_roles" {
  default = "roles/owner"
  description = "Roles for Admin"
}

variable "shared_vpc_project" {
  type        = string
  default     = "edsharedvpc-1"
  description = "ID from a Shared VPC Host Project"
}

variable "shared_vpc_project_name" {
  type        = string
  default = "vpc-edsharedvpc-1"
  description = "Name from a VPC from Shared VPC Project"

}

variable "admin_group_email" {
  description = "Admin Group e.g. group:admins@example.com or user:admin@example.com"
  default     = "group:admin@inspiracaosoluvel.com"
}

variable "user_group_email" {
  description = "User Group e.g. group:users@example.com or user:user@example.com"
  default     = "group:users@inspiracaosoluvel.com"
}

variable "disable_services_on_destroy" {
  default = "true"
  type    = string
}

variable "disable_dependent_services" {
  default = "true"
  type    = string
}

variable "primary_ip_cidr_range" {
  description = "Primary IP Range for the Subnet"
  default = "192.168.1.0/24"
  type        = string
}

variable "secondary_ip_cidr_range" {
  description = "Secondary IP Range for the Subnet"
  default = "192.168.2.0/24"
  type        = string
}

variable "environment" {
  description = "Environment Label related to this Project"
  default = "staging"
}

variable "machine_type" {
  description = "Machine-type e.g f1-micro"
  default = "f1-micro"  
}

variable "disk_size_gb" {
  description = "Disk Size"
  default = 20
}

variable "instance_size" {
  description = "Instance size"
  default = 2
}

variable "service_port" {
  description = "Service Port"
  default = 3000
}

variable "autoscaling_cpu" {
  description = "CPU MAX Value for scale in e.g 0.8"
  default = 0.8
}

variable "location" {
  description = "Location for the GKE Cluster e.g. southamerica-east1 to Regional and southamerica-east1-a for Zonal"
  default = "southamerica-east1"
}

variable "family" {
  description = "Image Name from GCP"
  default = "myhelloworldapp"
}

variable "image_project" {
  description = "Project from a Family Image"
}