###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "environment" {
  type        = string
  default     = "develop"
  description = "environment name"
}

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image family name"
}

variable "vm_web_vm_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "vm name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "vm name"
}

#
#variable "vm_web_cores" {
#  default     = 2
#  description = "cores"
#}

#variable "vm_web_mem" {
#  default     = 1
#  description = "memory"
#}

#variable "vm_web_fraction" {
#  default     = 5
# description = "fraction"
#}

variable "vm_web_resources" {
  type        = map
  default     = {
    cores     = 2,
    mem       = 1,
    frac      = 5
  }
}
###ssh vars

#variable "vms_ssh_root_key" {
#  type        = string
#  default     = ""
#  description = "ssh-keygen -t ed25519"
#}