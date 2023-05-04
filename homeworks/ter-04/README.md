# Домашнее задание к занятию "Продвинутые методы работы с Terraform"

### Цель задания

1. Научиться использовать модули.
2. Отработать операции state.
3. Закрепить пройденный материал.


### Чеклист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент yandex CLI
3. Исходный код для выполнения задания расположен в директории [**04/src**](https://github.com/netology-code/ter-homeworks/tree/main/04/src).
4. Любые ВМ, использованные при выполнении задания должны быть прерываемыми, для экономии средств.

------

### Задание 1

1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания ВМ с помощью remote модуля.
2. Создайте 1 ВМ, используя данный модуль. В файле cloud-init.yml необходимо использовать переменную для ssh ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание что ssh-authorized-keys принимает в себя список, а не строку!
3. Добавьте в файл cloud-init.yml установку nginx.
4. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```.

```shell
ubuntu@develop-web-0:~$ sudo nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
ubuntu@develop-web-0:~$
```
------

### Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля. например: ```ru-central1-a```.
2. Модуль должен возвращать значения vpc.id и subnet.id
3. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet, созданным модулем.
4. Сгенерируйте документацию к модулю с помощью terraform-docs.    
 
Пример вызова:
```
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
}
```

### Задание 3
1. Выведите список ресурсов в стейте.

```shell
nrv@nrv:~/devops-netology/homeworks/ter-04/demonstration1$ terraform state list
data.template_file.cloudinit
module.test-vm.data.yandex_compute_image.my_image
module.test-vm.yandex_compute_instance.vm[0]
module.vpc.null_resource.Creation_of_documentation
module.vpc.yandex_vpc_network.develop
module.vpc.yandex_vpc_subnet.develop
nrv@nrv:~/devops-netology/homeworks/ter-04/demonstration1$
```
2. Удалите из стейта модуль vpc.

```shell
nrv@nrv:~/devops-netology/homeworks/ter-04/demonstration1$ terraform state rm 'module.vpc'
Removed module.vpc.null_resource.Creation_of_documentation
Removed module.vpc.yandex_vpc_network.develop
Removed module.vpc.yandex_vpc_subnet.develop
Successfully removed 3 resource instance(s).
nrv@nrv:~/devops-netology/homeworks/ter-04/demonstration1$
```
3. Импортируйте его обратно. Проверьте terraform plan - изменений быть не должно.
Приложите список выполненных команд и вывод.

```shell
nrv@nrv:~/devops-netology/homeworks/ter-04/demonstration1$ grep -HiRn -e  'module.vpc.' -e '"id"' -e '"type"' ./terraform.tfstate.back
./terraform.tfstate.back:10:      "type": "template_file",
./terraform.tfstate.back:18:            "id": "03cdda2e504d684475113e5581648aa172c6d71ea30293a534b13033e8214b9b",
./terraform.tfstate.back:33:      "type": "yandex_compute_image",
./terraform.tfstate.back:44:            "id": "fd8gfg42q4551cvt340b",
./terraform.tfstate.back:64:      "type": "yandex_compute_instance",
./terraform.tfstate.back:87:                    "type": "network-hdd"
./terraform.tfstate.back:100:            "id": "fhmirokdamcm9t99fv70",
./terraform.tfstate.back:169:            "module.vpc.yandex_vpc_network.develop",
./terraform.tfstate.back:170:            "module.vpc.yandex_vpc_subnet.develop"
./terraform.tfstate.back:176:      "module": "module.vpc",
./terraform.tfstate.back:178:      "type": "null_resource",
./terraform.tfstate.back:185:            "id": "2191273950521778462",
./terraform.tfstate.back:195:      "module": "module.vpc",
./terraform.tfstate.back:197:      "type": "yandex_vpc_network",
./terraform.tfstate.back:208:            "id": "enp8ic4q8421nrrol7b8",
./terraform.tfstate.back:220:      "module": "module.vpc",
./terraform.tfstate.back:222:      "type": "yandex_vpc_subnet",
./terraform.tfstate.back:233:            "id": "e9bcnjhkdvgo1pm3392f",
./terraform.tfstate.back:248:            "module.vpc.yandex_vpc_network.develop"

nrv@nrv:~/devops-netology/homeworks/ter-04/demonstration1$ terraform import 'module.vpc.yandex_vpc_network.develop' 'enp8ic4q8421nrrol7b8'
data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=03cdda2e504d684475113e5581648aa172c6d71ea30293a534b13033e8214b9b]
module.vpc.yandex_vpc_network.develop: Importing from ID "enp8ic4q8421nrrol7b8"...
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.vpc.yandex_vpc_network.develop: Import prepared!
  Prepared yandex_vpc_network for import
module.vpc.yandex_vpc_network.develop: Refreshing state... [id=enp8ic4q8421nrrol7b8]
module.test-vm.data.yandex_compute_image.my_image: Read complete after 0s [id=fd8gfg42q4551cvt340b]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

nrv@nrv:~/devops-netology/homeworks/ter-04/demonstration1$ terraform import 'module.vpc.yandex_vpc_subnet.develop' 'e9bcnjhkdvgo1pm3392f'
data.template_file.cloudinit: Reading...
data.template_file.cloudinit: Read complete after 0s [id=03cdda2e504d684475113e5581648aa172c6d71ea30293a534b13033e8214b9b]
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.vpc.yandex_vpc_subnet.develop: Importing from ID "e9bcnjhkdvgo1pm3392f"...
module.vpc.yandex_vpc_subnet.develop: Import prepared!
  Prepared yandex_vpc_subnet for import
module.vpc.yandex_vpc_subnet.develop: Refreshing state... [id=e9bcnjhkdvgo1pm3392f]
module.test-vm.data.yandex_compute_image.my_image: Read complete after 1s [id=fd8gfg42q4551cvt340b]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

nrv@nrv:~/devops-netology/homeworks/ter-04/demonstration1$ terraform import 'module.vpc.null_resource.Creation_of_documentation' '21912
73950521778462'
data.template_file.cloudinit: Reading...
module.vpc.null_resource.Creation_of_documentation: Importing from ID "2191273950521778462"...
data.template_file.cloudinit: Read complete after 0s [id=03cdda2e504d684475113e5581648aa172c6d71ea30293a534b13033e8214b9b]
module.test-vm.data.yandex_compute_image.my_image: Reading...
module.test-vm.data.yandex_compute_image.my_image: Read complete after 1s [id=fd8gfg42q4551cvt340b]
╷
│ Error: Resource Import Not Implemented
│
│ This resource does not support import. Please contact the provider developer for additional information.
```
*после проверки terraform plan будет создан null_resource (создание документации), так как импортнуть его не удалось (импорт не поддерживается для данного типа ресурса)*

## Дополнительные задания (со звездочкой*)

**Настоятельно рекомендуем выполнять все задания под звёздочкой.**   Их выполнение поможет глубже разобраться в материале.   
Задания под звёздочкой дополнительные (необязательные к выполнению) и никак не повлияют на получение вами зачета по этому домашнему заданию. 


### Задание 4*

1. Измените модуль vpc так, чтобы он мог создать подсети во всех зонах доступности, переданных в переменной типа list(object) при вызове модуля.  
  
Пример вызова:
```
module "vpc_prod" {
  source       = "./vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}
```

Предоставьте код, план выполнения, результат из консоли YC.

### Задание 5**

1. Напишите модуль для создания кластера managed БД Mysql в Yandex Cloud с 1 или 3 хостами в зависимости от переменной HA=true или HA=false. Используйте ресурс yandex_mdb_mysql_cluster (передайте имя кластера и id сети).
2. Напишите модуль для создания базы данных и пользователя в уже существующем кластере managed БД Mysql. Используйте ресурсы yandex_mdb_mysql_database и yandex_mdb_mysql_user (передайте имя базы данных, имя пользователя и id кластера при вызове модуля).
3. Используя оба модуля, создайте кластер example из одного хоста, а затем добавьте в него БД test и пользователя app. Затем измените переменную и превратите сингл хост в кластер из 2х серверов.
4. 
Предоставьте план выполнения и по-возможности результат. Сразу же удаляйте созданные ресурсы, так как кластер может стоить очень дорого! Используйте минимальную конфигурацию.

### Задание 6***  

1. Разверните у себя локально vault, используя docker-compose.yml в проекте.
2. Для входа в web интерфейс и авторизации terraform в vault используйте токен "education"
3. Создайте новый секрет по пути http://127.0.0.1:8200/ui/vault/secrets/secret/create  
Path: example  
secret data key: test 
secret data value: congrats!  
4. Считайте данный секрет с помощью terraform и выведите его в output по примеру:
```
provider "vault" {
 address = "http://<IP_ADDRESS>:<PORT_NUMBER>"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 

можно обратится не к словарю, а конкретному ключу.
terraform console: >nonsensitive(data.vault_generic_secret.vault_example.data.<имя ключа в секрете>)
```
5. Попробуйте разобраться в документации и записать новый секрет в vault с помощью terraform. 


### Правила приема работы

В своём git-репозитории создайте новую ветку terraform-04, закомитьте в эту ветку свой финальный код проекта. Ответы на задания и необходимые скриншоты оформите в md-файле в ветке terraform-04.

В качестве результата прикрепите ссылку на ветку terraform-04 в вашем репозитории.

ВАЖНО!Удалите все созданные ресурсы.

### Критерии оценки

Зачёт:

* выполнены все задания;
* ответы даны в развёрнутой форме;
* приложены соответствующие скриншоты и файлы проекта;
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку:

* задание выполнено частично или не выполнено вообще;
* в логике выполнения заданий есть противоречия и существенные недостатки. 



