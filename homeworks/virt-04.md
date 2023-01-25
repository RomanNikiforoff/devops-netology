# Домашнее задание к занятию "4. Оркестрация группой Docker контейнеров на примере Docker Compose"

---

## Задача 1

Создать собственный образ  любой операционной системы (например, centos-7) с помощью Packer ([инструкция](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/packer-quickstart))

Для получения зачета вам необходимо предоставить скриншот страницы с созданным образом из личного кабинета YandexCloud.

```shell
nrv@wsl:~/netology-homeworks/virt-04$ yc compute image list
+----------------------+------------+-----------+----------------------+--------+
|          ID          |    NAME    |  FAMILY   |     PRODUCT IDS      | STATUS |
+----------------------+------------+-----------+----------------------+--------+
| fd83it0eje27j8lpv5b9 | yc-toolbox | my-images | f2ea07nu3lns12491hku | READY  |
+----------------------+------------+-----------+----------------------+--------+

nrv@wsl:~/netology-homeworks/virt-04$
```

## Задача 2

Создать вашу первую виртуальную машину в YandexCloud.

Для получения зачета, вам необходимо предоставить cкриншот страницы свойств созданной ВМ из личного кабинета YandexCloud.
```shell
nrv@wsl:~/netology-homeworks/virt-04$ yc compute instance list
+----------------------+------------+---------------+---------+--------------+-------------+
|          ID          |    NAME    |    ZONE ID    | STATUS  | EXTERNAL IP  | INTERNAL IP |
+----------------------+------------+---------------+---------+--------------+-------------+
| epd9l3jlm7pqsvcnv02o | test-vm    | ru-central1-b | STOPPED |              | 10.129.0.30 |
| fhm5d8gog40lisgl1s9i | toolbox-vm | ru-central1-a | RUNNING | 51.250.9.147 | 10.128.0.14 |
+----------------------+------------+---------------+---------+--------------+-------------+

nrv@wsl:~/netology-homeworks/virt-04$ yc compute instance describe --id fhm5d8gog40lisgl1s9i
id: fhm5d8gog40lisgl1s9i
folder_id: b1gkuhr7ssi0qfamt3uq
created_at: "2023-01-25T06:46:22Z"
name: toolbox-vm
zone_id: ru-central1-a
platform_id: standard-v2
resources:
  memory: "8589934592"
  cores: "2"
  core_fraction: "100"
status: RUNNING
metadata_options:
  gce_http_endpoint: ENABLED
  aws_v1_http_endpoint: ENABLED
  gce_http_token: ENABLED
  aws_v1_http_token: ENABLED
boot_disk:
  mode: READ_WRITE
  device_name: fhmk2hfirs0shrcc5sf7
  auto_delete: true
  disk_id: fhmk2hfirs0shrcc5sf7
network_interfaces:
  - index: "0"
    mac_address: d0:0d:56:a2:18:81
    subnet_id: e9bopjo60lbholcap1u2
    primary_v4_address:
      address: 10.128.0.14
      one_to_one_nat:
        address: 51.250.9.147
        ip_version: IPV4
fqdn: toolbox-vm.ru-central1.internal
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}

nrv@wsl:~/netology-homeworks/virt-04$

```

## Задача 3

Создать ваш первый готовый к боевой эксплуатации компонент мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить:
- Скриншот работающего веб-интерфейса Grafana с текущими метриками, как на примере ниже

## Задача 4 (*)

Создать вторую ВМ и подключить её к мониторингу развёрнутому на первом сервере.

Для получения зачета, вам необходимо предоставить:
- Скриншот из Grafana, на котором будут отображаться метрики добавленного вами сервера.
