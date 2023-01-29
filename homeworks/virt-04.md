# Домашнее задание к занятию "4. Оркестрация группой Docker контейнеров на примере Docker Compose"

---

## Задача 1

Создать собственный образ  любой операционной системы (например, ubuntu-20.04) с помощью Packer ([инструкция](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/packer-quickstart))

Для получения зачета вам необходимо предоставить скриншот страницы с созданным образом из личного кабинета YandexCloud.
```shell
nrv@wsl:~/virt-04$ yc compute images list
+----------------------+------------+-----------+----------------------+--------+
|          ID          |    NAME    |  FAMILY   |     PRODUCT IDS      | STATUS |
+----------------------+------------+-----------+----------------------+--------+
| fd83it0eje27j8lpv5b9 | yc-toolbox | my-images | f2ea07nu3lns12491hku | READY  |
| fd8a8guqk9hleui06dkq | nrv-ubuntu | my-images | f2ea07nu3lns12491hku | READY  |
+----------------------+------------+-----------+----------------------+--------+

nrv@wsl:~/virt-04$
```

## Задача 2

Создать вашу первую виртуальную машину в YandexCloud с помощью terraform. 
Используйте terraform код в директории ([src/terraform](https://github.com/netology-group/virt-homeworks/tree/virt-11/05-virt-04-docker-compose/src/terraform))

Для получения зачета, вам необходимо предоставить вывод команды terraform apply и страницы свойств созданной ВМ из личного кабинета YandexCloud.

```shell
  Enter a value: yes

yandex_vpc_network.default: Creating...
yandex_vpc_network.default: Creation complete after 1s [id=enp39mb7fh20oaijpo7q]
yandex_vpc_subnet.default: Creating...
yandex_vpc_subnet.default: Creation complete after 1s [id=e9bg4vji787gnhfdb7db]
yandex_compute_instance.node01: Creating...
yandex_compute_instance.node01: Still creating... [10s elapsed]
yandex_compute_instance.node01: Still creating... [20s elapsed]
yandex_compute_instance.node01: Still creating... [30s elapsed]
yandex_compute_instance.node01: Still creating... [40s elapsed]
yandex_compute_instance.node01: Creation complete after 49s [id=fhm2l78trsrrm6qjj1qt]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_node01_yandex_cloud = "51.250.12.194"
internal_ip_address_node01_yandex_cloud = "192.168.101.15"
nrv@wsl:~/virt-04/terraform$
nrv@wsl:~/virt-04/terraform$ yc compute instance list
+----------------------+------------+---------------+---------+---------------+----------------+
|          ID          |    NAME    |    ZONE ID    | STATUS  |  EXTERNAL IP  |  INTERNAL IP   |
+----------------------+------------+---------------+---------+---------------+----------------+
| epd9l3jlm7pqsvcnv02o | test-vm    | ru-central1-b | RUNNING | 51.250.18.174 | 10.129.0.30    |
| fhm2l78trsrrm6qjj1qt | node01     | ru-central1-a | RUNNING | 51.250.12.194 | 192.168.101.15 |
| fhm5d8gog40lisgl1s9i | toolbox-vm | ru-central1-a | STOPPED |               | 10.128.0.14    |
+----------------------+------------+---------------+---------+---------------+----------------+

nrv@wsl:~/virt-04/terraform$ yc compute instance describe fhm2l78trsrrm6qjj1qt
id: fhm2l78trsrrm6qjj1qt
folder_id: b1gkuhr7ssi0qfamt3uq
created_at: "2023-01-28T19:20:31Z"
name: node01
zone_id: ru-central1-a
platform_id: standard-v1
resources:
  memory: "8589934592"
  cores: "8"
  core_fraction: "100"
status: RUNNING
metadata_options:
  gce_http_endpoint: ENABLED
  aws_v1_http_endpoint: ENABLED
  gce_http_token: ENABLED
  aws_v1_http_token: ENABLED
boot_disk:
  mode: READ_WRITE
  device_name: fhmjp0gcfnncvt50ga63
  auto_delete: true
  disk_id: fhmjp0gcfnncvt50ga63
network_interfaces:
  - index: "0"
    mac_address: d0:0d:2a:9d:1d:df
    subnet_id: e9bg4vji787gnhfdb7db
    primary_v4_address:
      address: 192.168.101.15
      one_to_one_nat:
        address: 51.250.12.194
        ip_version: IPV4
fqdn: node01.netology.cloud
scheduling_policy: {}
network_settings:
  type: STANDARD
placement_policy: {}

nrv@wsl:~/virt-04/terraform$
```

## Задача 3

С помощью ansible и docker-compose разверните на виртуальной машине из предыдущего задания систему мониторинга на основе Prometheus/Grafana .
Используйте ansible код в директории ([src/ansible](https://github.com/netology-group/virt-homeworks/tree/virt-11/05-virt-04-docker-compose/src/ansible))

Для получения зачета вам необходимо предоставить вывод команды "docker ps" , все контейнеры, описанные в ([docker-compose](https://github.com/netology-group/virt-homeworks/blob/virt-11/05-virt-04-docker-compose/src/ansible/stack/docker-compose.yaml)),  должны быть в статусе "Up".
```shell
nrv@node01:~$ sudo docker ps
CONTAINER ID   IMAGE                              COMMAND                  CREATED         STATUS                    PORTS
                                                                              NAMES
9d56c79616fd   caddy:2.3.0                        "caddy run --config …"   6 minutes ago   Up 6 minutes              80/tcp, 443/tcp, 0.0.0.0:3000->3000/tcp, 0.0.0.0:9090-9091->9090-9091/tcp, 2019/tcp, 0.0.0.0:9093->9093/tcp   caddy
9f726f715d42   prom/pushgateway:v1.2.0            "/bin/pushgateway"       12 hours ago    Up 37 minutes             9091/tcp
                                                                              pushgateway
06055e617038   grafana/grafana:7.4.2              "/run.sh"                12 hours ago    Up 37 minutes             3000/tcp
                                                                              grafana
0887fbe70d3a   prom/prometheus:v2.17.1            "/bin/prometheus --c…"   12 hours ago    Up 37 minutes             9090/tcp
                                                                              prometheus
3700d0060c4d   gcr.io/cadvisor/cadvisor:v0.47.0   "/usr/bin/cadvisor -…"   12 hours ago    Up 37 minutes (healthy)   8080/tcp
                                                                              cadvisor
965022f487e2   prom/node-exporter:v0.18.1         "/bin/node_exporter …"   12 hours ago    Up 37 minutes             9100/tcp
                                                                              nodeexporter
26dae0f05623   prom/alertmanager:v0.20.0          "/bin/alertmanager -…"   12 hours ago    Up 37 minutes             9093/tcp
                                                                              alertmanager
nrv@node01:~$
```

## Задача 4

1. Откройте веб-браузер, зайдите на страницу http://<внешний_ip_адрес_вашей_ВМ>:3000.
2. Используйте для авторизации логин и пароль из ([.env-file](https://github.com/netology-group/virt-homeworks/blob/virt-11/05-virt-04-docker-compose/src/ansible/stack/.env)).
3. Изучите доступный интерфейс, найдите в интерфейсе автоматически созданные docker-compose панели с графиками([dashboards](https://grafana.com/docs/grafana/latest/dashboards/use-dashboards/)).
4. Подождите 5-10 минут, чтобы система мониторинга успела накопить данные.

Для получения зачета, вам необходимо предоставить: 
- Скриншот работающего веб-интерфейса Grafana с текущими метриками, как на примере ниже
<p align="center">
  <img width="1200" height="600" src="./assets/yc_02.png">
</p>

## Задача 5 (*)

Создать вторую ВМ и подключить её к мониторингу развёрнутому на первом сервере.

Для получения зачета, вам необходимо предоставить:
- Скриншот из Grafana, на котором будут отображаться метрики добавленного вами сервера.
