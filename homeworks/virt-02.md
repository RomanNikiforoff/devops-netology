## Задача 1

- Опишите своими словами основные преимущества применения на практике IaaC паттернов.

* автоматизация рутинных операций
* сокращение времени вывода версий продукта в продакшн
* стандартизация и стабильность среды
* авто документирование

- Какой из принципов IaaC является основополагающим?

По моему мнению - всегда одинаковый результат.

## Задача 2

- Чем Ansible выгодно отличается от других систем управление конфигурациями?

* использование простого декларативного языка
* структурированность и модульность
* отлично документирован
* море готовых решений.
* низкий порог входа
* отсутствие клиентской части
* возможности интеграции

- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

*Push проще и дает больше контроля над конфигурацией и упрощает управление.*
 
## Задача 3

Установить на личный компьютер:

- VirtualBox
```text
VirtualBox Graphical User Interface
Version 7.0.4 r154605 (Qt5.15.2)
Copyright © 2022 Oracle and/or its affiliates.
```
- Vagrant
```shell
nrv@wsl:~$ vagrant --version
Vagrant 2.3.4
nrv@wsl:~$
```
- Ansible
```shell
nrv@wsl:~$ ansible --version
ansible [core 2.13.6]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/nrv/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.8/dist-packages/ansible
  ansible collection location = /home/nrv/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/local/bin/ansible
  python version = 3.8.10 (default, Jun 22 2022, 20:18:18) [GCC 9.4.0]
  jinja version = 3.1.2
  libyaml = True
nrv@wsl:~$
```

*Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.*

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

- Создать виртуальную машину.
- Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
```
docker ps
```
