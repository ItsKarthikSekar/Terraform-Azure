variable "subscription_id" {
  description = "Azure Subscription ID for bootstrap resources"
  type        = string
  default     = "<YOUR_SUBSCRIPTION_ID>"
}

variable "project_name" {
  description = "Project name used for naming bootstrap resources"
  type        = string
}

variable "location" {
  description = "Azure location for bootstrap resources"
  type        = string
  default     = "East US 2"
}
