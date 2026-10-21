variable "resource_group_name" {
  description = "Name of the existing resource group for the Container Apps resources."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the Container Apps resources."
  type        = string
}

variable "container_app_environment_name" {
  description = "Name of the Container Apps managed environment."
  type        = string
}

variable "container_app_name" {
  description = "Name of the Container App."
  type        = string
}

variable "container_name" {
  description = "Name of the container in the Container App."
  type        = string
  default     = "app"
}

variable "container_image" {
  description = "Container image to deploy, including its tag or digest."
  type        = string
}

variable "target_port" {
  description = "Port on which the container listens and receives ingress traffic."
  type        = number
  default     = 80
}

variable "external_ingress_enabled" {
  description = "Allow ingress to the Container App from outside its environment."
  type        = bool
  default     = true
}

variable "revision_mode" {
  description = "Revision mode for the Container App: Single or Multiple."
  type        = string
  default     = "Single"
}

variable "container_cpu" {
  description = "CPU allocated to the container in cores."
  type        = number
  default     = 0.25
}

variable "container_memory" {
  description = "Memory allocated to the container, such as 0.5Gi."
  type        = string
  default     = "0.5Gi"
}

variable "min_replicas" {
  description = "Minimum number of container replicas."
  type        = number
  default     = 0
}

variable "max_replicas" {
  description = "Maximum number of container replicas."
  type        = number
  default     = 10
}

variable "environment_variables" {
  description = "Non-secret environment variables passed to the container. Values are stored in Terraform state."
  type        = map(string)
  default     = {}
}

variable "log_analytics_workspace_id" {
  description = "Optional resource ID of an existing Log Analytics workspace for environment logs."
  type        = string
  default     = null
}

variable "infrastructure_subnet_id" {
  description = "Optional delegated subnet resource ID for a VNet-integrated environment."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the Container Apps environment and app."
  type        = map(string)
  default     = {}
}
