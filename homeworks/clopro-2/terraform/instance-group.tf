## Создаем сервис аккаунт для ig
resource "yandex_iam_service_account" "ig-sa" {
  name        = "ig-sa"
  description = "service account to manage IG"
}
## Выдаем права
resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id  = var.folder_id
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
  depends_on = [
    yandex_iam_service_account.ig-sa,
  ]
}

## Создаем инстанс групп
resource "yandex_compute_instance_group" "ig-1" {
  name                = var.ig_name
  folder_id           = var.folder_id
  service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
  deletion_protection = false
  depends_on          = [yandex_resourcemanager_folder_iam_member.editor, yandex_storage_object.nrv-pic]
  
  instance_template {
    platform_id = var.ig_platform_id
    resources {
      memory        = var.vm_resources.mem
      cores         = var.vm_resources.cores
      core_fraction = var.vm_resources.frac
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd8gnvkksobme3786ljc"
        size     = var.vm_resources.disk
      }
    }
    
    scheduling_policy {
      preemptible = true
    }

    network_interface {
      network_id = "${yandex_vpc_network.develop.id}"
      subnet_ids = ["${yandex_vpc_subnet.public.id}"]
#      nat        = true
    }

    metadata = {
      user-data = "${file("./meta.yml")}"
    }
  }

  scale_policy {
    fixed_scale {
      size = var.fixed_scale_size
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }
  
  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "load balancer target group"
  }
}