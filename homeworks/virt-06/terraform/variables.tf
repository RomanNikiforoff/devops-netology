variable "token" {
  description = "Yandex Cloud security OAuth token"
  default     = "AQAAAAAEVn-NAATuwQWbCukczkWFoKRB1_B38_o"
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID where resources will be created"
  default     = "b1gkuhr7ssi0qfamt3uq"
}

variable "cloud_id" {
  description = "Yandex Cloud ID where resources will be created"
  default     = "b1gtkgpga5h0u3ef67er"
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
  default     = "Minotavr6268"
}

variable "user" {
  type    = string
  default = "nrv"
}
