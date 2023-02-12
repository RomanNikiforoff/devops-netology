variable "token" {
  description = "Yandex Cloud security OAuth token"
  default     = ""
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID where resources will be created"
  default     = ""
}

variable "cloud_id" {
  description = "Yandex Cloud ID where resources will be created"
  default     = ""
}

variable "public_key_path" {
  description = "Path to ssh public key, which would be used to access workers"
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to ssh private key, which would be used to access workers"
  default     = "~/.ssh/id_rsa"
}

variable "user_password" {
  type = string
  default     = ""
}

variable "user" {
  type    = string
  default = "nrv"
}
