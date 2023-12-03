data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_family
}

# NAT vm
resource "yandex_compute_instance" "nat-instance" {
  name     = var.nat_vm_name
  hostname = "nat-instance"
  zone     = var.default_zone
  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.mem
    core_fraction = var.vm_resources.frac
  }
  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }
  scheduling_policy {
    preemptible = false
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    nat        = true
    ip_address = "192.168.10.254"
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}

# Public vm
resource "yandex_compute_instance" "public-instance" {
  name     = var.public_vm_name
  hostname = "public-instance"
  zone     = var.default_zone
  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.mem
    core_fraction = var.vm_resources.frac
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_resources.disk
    }
  }
  scheduling_policy {
    preemptible = false
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    nat        = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}

# privat instance

resource "yandex_compute_instance" "privat-instance" {
  name     = var.privat_vm_name
  hostname = "privat-instance"
  zone     = var.default_zone
  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.mem
    core_fraction = var.vm_resources.frac
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_resources.disk
    }
  }
  scheduling_policy {
    preemptible = false
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.private.id
    nat        = false
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}
