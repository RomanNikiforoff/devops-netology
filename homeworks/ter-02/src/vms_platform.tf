###cloud vars

variable "vm_db_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image family name"
}

variable "vm_db_vm_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "vm name"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "platform name"
}

#variable "vm_db_cores" {
# default     = 2
# description = "cores"
#}

#variable "vm_db_mem" {
#  default     = 2
#  description = "memory"
#}

#variable "vm_db_fraction" {
#  default     = 20
#  description = "fraction"
#}

variable "vm_db_resources" {
  type        = map
  default     = {
    cores     = 2,
    mem       = 2,
    frac      = 20
  }
}

resource "yandex_compute_instance" "platform2" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.vm_db_resources.cores
    memory        = var.vm_db_resources.mem
    core_fraction = var.vm_db_resources.frac
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}