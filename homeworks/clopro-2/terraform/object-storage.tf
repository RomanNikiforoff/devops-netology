resource "yandex_iam_service_account" "sa" {
  name = "bucket-sa"
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Создаем бакет
resource "yandex_storage_bucket" "nrv-test-1" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = var.backet_name
  anonymous_access_flags {
    read = true
    list = false
    config_read = true
  }
  max_size = var.backet_max_size
}

// Загружаем файл в бакет
resource "yandex_storage_object" "nrv-pic" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "nrv-test-1"
  key        = "test-pic.png"
  source     = "~/devops-netology/homeworks/clopro-2/files/test-pic.png"
  depends_on = [yandex_storage_bucket.nrv-test-1]
}