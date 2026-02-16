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
