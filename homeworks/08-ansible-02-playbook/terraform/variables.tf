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
  description = "VPC network&subnet"
}

variable "public_key" {
  type    = string
  default = ""
}

variable "ssh_public_key" {
  default = ""
}

variable "vm_image_family" {
  type        = string
  default     = "centos-7"
  description = "image family name"
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "vm name"
}

variable "vm_resources" {
  type        = map
  default     = {
    cores     = 4,
    mem       = 4,
    frac      = 100
  }
}