variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "client_id" {
  description = "Azure Service Principal client ID"
  type        = string
}

variable "client_secret" {
  description = "Azure Service Principal client secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the VM and image will be created"
  type        = string
  default     = "myResourceGroup"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "vm_size" {
  description = "VM size for the deployment"
  type        = string
  default     = "Standard_B1s"
}

variable "key_name" {
  description = "Name of the SSH private key file"
  type        = string
  default     = "myapp-key-pair.pem"
}

variable "image_name" {
  description = "Name of the Packer image created in Azure"
  type        = string
  default     = "act1-DMD-ubuntu-nodejs-nginx-auto"
}
