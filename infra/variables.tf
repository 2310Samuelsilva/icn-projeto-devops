# Inputs: values that can change without touching main.tf.
# Override with -var name=value or the TF_VAR_name environment variable.

variable "location" {
  description = "Azure region (Azure for Students only allows a few EU regions)"
  type        = string
  default     = "austriaeast"
}

variable "vm_size" {
  description = "Cheapest size available to the student subscription"
  type        = string
  default     = "Standard_B2ats_v2"
}

variable "prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "icn-devops"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key" {
  description = "Public key Ansible uses to log into the VM"
  type        = string
}
