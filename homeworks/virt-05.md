# Домашнее задание к занятию "5. Оркестрация кластером Docker контейнеров на примере Docker Swarm"

## Задача 1

Дайте письменые ответы на следующие вопросы:

- В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?
- Какой алгоритм выбора лидера используется в Docker Swarm кластере?
- Что такое Overlay Network?

## Задача 2

Создать ваш первый Docker Swarm кластер в Яндекс.Облаке

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```
docker node ls
```

```shell
nrv@node01:~$ sudo docker node ls
ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
jk0x3xm2pgqpeq3na39tawqf3 *   node01     Ready     Active         Leader           20.10.23
yjds8dg36bbv6vkvkn11uwe05     node02     Ready     Active         Reachable        20.10.23
y7tu8c3endc5apjchnidtji3q     node03     Ready     Active         Reachable        20.10.23
imttoz6wth7d2tp0hhezp2a0m     node04     Ready     Active                          20.10.23
walyu67fl8j870naervyxhcmy     node05     Ready     Active                          20.10.23
ywp2vvss4yajwmtse7me0kxjp     node06     Ready     Active                          20.10.23
nrv@node01:~$
```

## Задача 3

Создать ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```
docker service ls
```

```shell
nrv@node01:~$ sudo docker service ls
ID             NAME                                MODE         REPLICAS   IMAGE                                          PORTS
btsz40hmj5ci   swarm_monitoring_alertmanager       replicated   1/1        stefanprodan/swarmprom-alertmanager:v0.14.0
v30l1i72kng4   swarm_monitoring_caddy              replicated   1/1        stefanprodan/caddy:latest                      *:3000->3000/tcp, *:9090->9090/tcp, *:9093-9094->9093-9094/tcp
em3j61fr1scp   swarm_monitoring_cadvisor           global       6/6        google/cadvisor:latest
9dklkkc34v8h   swarm_monitoring_dockerd-exporter   global       6/6        stefanprodan/caddy:latest
xpikfkd7hjbh   swarm_monitoring_grafana            replicated   1/1        stefanprodan/swarmprom-grafana:5.3.4
ai1mf23ol1e7   swarm_monitoring_node-exporter      global       6/6        stefanprodan/swarmprom-node-exporter:v0.16.0
syzw3s6qyxh9   swarm_monitoring_prometheus         replicated   1/1        stefanprodan/swarmprom-prometheus:v2.5.0
jzlr3i6e3pid   swarm_monitoring_unsee              replicated   1/1        cloudflare/unsee:v0.8.0
nrv@node01:~$
```

## Задача 4 (*)

Выполнить на лидере Docker Swarm кластера команду (указанную ниже) и дать письменное описание её функционала, что она делает и зачем она нужна:
```
# см.документацию: https://docs.docker.com/engine/swarm/swarm_manager_locking/
docker swarm update --autolock=true
```
