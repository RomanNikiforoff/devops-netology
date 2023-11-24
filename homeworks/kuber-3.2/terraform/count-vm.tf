data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_family
}

resource "yandex_compute_instance" "loop_test" {
  count       = 5
  name        = "${var.vm_name}-${count.index+1}"
  platform_id = var.vm_platform_id
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
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }

}
