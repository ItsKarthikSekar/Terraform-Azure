variable "project_name" {
  description = "Project name used for naming bootstrap resources"
  type        = string
}

variable "location" {
  description = "Azure location for bootstrap resources"
  type        = string
  default     = "swedencentral"
}
