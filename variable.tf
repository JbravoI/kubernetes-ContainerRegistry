
variable "resource_group_name" {
  description = "name of resource group"
  default     = "kube"
}


variable "location" {
  description = "azure location to deploy resources"
  default     = "eastus"
}

variable "retention" {
  description = "Change to false if you don`t want any retion policy and you can adjust the days"
  default     = true
}