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

variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vpc_name_public" {
  type        = string
  default     = "public-subnet"
  description = "public subnet name"
}
variable "vm_name" {
  type        = string
  default     = "node"
  description = "vm name"
}

variable "vm_image_family" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "image family name"
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "vm name"
}

variable "vm_resources" {
  type        = map
  default     = {
    cores     = 2,
    mem       = 2,
    frac      = 20,
    disk      = 15
  }
}

## Backet var's
variable "backet_name" {
  type        = string
  default     = "nrv-test-1"
  description = "backet name"
}

variable "backet_max_size" {
  default     = 104857600
  description = "backet max size in bytes"
}

## Instance group var's
variable "ig_name" {
  type        = string
  default     = "ig-1"
  description = "ig name"
}
variable "fixed_scale_size" {
  default     = 3
  description = "scale size"
}
variable "ig_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "ig platform id"
}