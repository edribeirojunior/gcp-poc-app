data "google_compute_image" "my_image" {
  name  = "${var.family}"
  project = "${module.project.project_id}"
}