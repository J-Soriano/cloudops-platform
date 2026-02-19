variable "location" {
  type        = string
  description = "Azure region"
  default     = "eastus"
}

variable "env" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "project" {
  type        = string
  description = "Project name/tag"
  default     = "cloudops-platform"
}
variable "log_analytics_retention_days" {
  type        = number
  description = "Log Analytics retention in days (keep low for lab cost control)"
  default     = 30
}