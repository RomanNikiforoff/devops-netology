
# Домашнее задание к занятию "3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

---

## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

https://hub.docker.com/repository/docker/rnikiforov/rnikiforov/general


## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- Высоконагруженное монолитное java веб-приложение;
- Nodejs веб-приложение; - *подходит, нода достаточно легковесна и проста*
- Мобильное приложение c версиями для Android и iOS; - *да, подходит*
- Шина данных на базе Apache Kafka; - *нет*
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana; - *возможно с ограничением по использованию памяти в ELK*
- Мониторинг-стек на базе Prometheus и Grafana; - *да*
- MongoDB, как основное хранилище данных для java-приложения; - *нет*
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry. -*нет*

## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.
```shell
nrv@test-vm:~/data$ ls
file-from-host.txt
nrv@test-vm:~/data$ sudo docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS
                NAMES
14fe629f173a   centos/httpd   "/run-httpd.sh"          29 seconds ago   Up 29 seconds   0.0.0.0:5555->80/tcp, :::5555->80/tcp   centos-httpd
123ebf5bbb05   ubuntu/nginx   "/docker-entrypoint.…"   29 minutes ago   Up 29 minutes   0.0.0.0:80->80/tcp, :::80->80/tcp       ubuntu-nginx1
nrv@test-vm:~/data$ sudo docker exec -it ubuntu-nginx1 /bin/bash
root@123ebf5bbb05:/# cd data
root@123ebf5bbb05:/data# ls
file-from-host.txt
root@123ebf5bbb05:/data# touch file-from-contaner-ubuntu.txt
root@123ebf5bbb05:/data# ls
file-from-contaner-ubuntu.txt  file-from-host.txt
root@123ebf5bbb05:/data# exit
exit
nrv@test-vm:~/data$ sudo docker exec -it centos-httpd /bin/bash
[root@38bb11e183e7 /]# cd data
[root@38bb11e183e7 data]# ls
file-from-contaner-ubuntu.txt  file-from-host.txt
[root@38bb11e183e7 data]#
```

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

*пришлось внести корректировки в Dockerfile*

```Dockerfile
# Манифест Docker образа.
FROM alpine:3.14
RUN CARGO_NET_GIT_FETCH_WITH_CLI=1 && apk update && \
apk --no-cache add sudo python3 py3-pip openssl ca-certificates sshpass openssh-client rsync git && \
apk --no-cache --virtual build-dependencies add python3-dev libffi-dev musl-dev gcc cargo openssl-dev libressl-dev build-base && \
pip install --upgrade pip wheel && \
pip install --upgrade cryptography cffi && \
pip install ansible==2.9.24 && \
pip install mitogen ansible-lint jmespath --ignore-installed && \
pip install --upgrade pywinrm --ignore-installed && \
apk del build-dependencies && \
rm -rf /var/cache/apk/* && \
rm -rf /root/.cache/pip && \
rm -rf /root/.cargo
RUN  mkdir /ansible && \
mkdir -p /etc/ansible && \
echo 'localhost' > /etc/ansible/hosts
WORKDIR  /ansible
CMD [ "ansible-playbook", "--version" ]
```
https://hub.docker.com/repository/docker/rnikiforov/ansible/general

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
