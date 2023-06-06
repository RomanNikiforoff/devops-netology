data "yandex_compute_image" "centos" {
  family = var.vm_image_family
}

resource "yandex_compute_instance" "ci-01" {
  count       = 2
  name        = "cicd-${count.index}"
  platform_id = var.vm_platform_id
  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.mem
    core_fraction = var.vm_resources.frac
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
      size     = 20
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