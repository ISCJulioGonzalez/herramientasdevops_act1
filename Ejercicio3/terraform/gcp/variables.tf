variable "project_id" {
  description = "El ID del proyecto de GCP donde se desplegarán los recursos"
  type        = string
}

variable "gcp_region" {
  description = "Región de GCP"
  type        = string
  default     = "us-central1"
}

variable "gcp_zone" {
  description = "Zona de GCP"
  type        = string
  default     = "us-central1-a"
}

variable "key_name" {
  description = "Nombre del archivo de la clave privada"
  type        = string
  default     = "UnirDevOpsAct1.json"
}

variable "image_name" {
  description = "Imagen de GCP creada con Packer"
  type        = string
  default     = "act1-dmd-ubuntu-nodejs-nginx-auto"
}

variable "instance_type" {
  description = "Tipo de máquina en GCP"
  type        = string
  default     = "e2-micro"
}
