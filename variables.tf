variable "project_id" {
  type        = string
  description = "ID del proyecto en GCP"
  default     = "gcp-terraform-secure-vpc"
}

variable "region_us" {
  type        = string
  description = "Región principal"
  default     = "us-central1"
}

variable "region_eu" {
  type        = string
  description = "Región secundaria"
  default     = "europe-west1"
}