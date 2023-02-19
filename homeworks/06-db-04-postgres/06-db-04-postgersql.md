# Домашнее задание к занятию "4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
```shell
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

postgres=#
```
- подключения к БД
```shell
postgres=# \c postgres
psql (14.6 (Ubuntu 14.6-0ubuntu0.22.04.1), server 13.10 (Debian 13.10-1.pgdg110+1))
You are now connected to database "postgres" as user "postgres".
postgres=#
```
- вывода списка таблиц
```shell
postgres=# \dt
Did not find any relations.
postgres=#
```
- вывода описания содержимого таблиц
```shell
postgres=# \dt+ tablename
```

- выхода из psql
```shell
postgres=# \q
nrv@docker-node:~$
```

## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.
```sql
test_database=# select attname, avg_width from pg_stats where tablename='orders' order by avg_width DESC limit 1;
 title   |        16

test_database=#
```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.
```sql
BEGIN;

CREATE TABLE orders_part (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
)
PARTITION BY RANGE (price); -- create partitioned table

CREATE TABLE orders_1_499
    PARTITION OF orders_part
    FOR VALUES FROM (MINVALUE) TO (499);

CREATE TABLE orders_over_499
    PARTITION OF orders_part
    FOR VALUES FROM (499) TO (MAXVALUE);

INSERT INTO orders_part SELECT * FROM orders;
   
DROP TABLE orders;
   
ALTER TABLE orders_part RENAME TO orders;

COMMIT; 
```
<details><summary>Результат выполнения транзакции</summary>

```shell

test_database=# \dt
 public | orders          | partitioned table | postgres
 public | orders_1_499    | table             | postgres
 public | orders_over_499 | table             | postgres

test_database=# select * from orders
test_database-# ;
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123
  2 | My little database   |   500
  6 | WAL never lies       |   900
  7 | Me and my bash-pet   |   499
  8 | Dbiezdmin            |   501

test_database=# select * from orders_1_499
;
  1 | War and peace        |   100
  3 | Adventure psql time  |   300
  4 | Server gravity falls |   300
  5 | Log gossips          |   123

test_database=# select * from orders_over_499
;
  2 | My little database |   500
  6 | WAL never lies     |   900
  7 | Me and my bash-pet |   499
  8 | Dbiezdmin          |   501

test_database=#
```
</details>


Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

*Да можно изначально создать шардированную таблицу*

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.
```shell
nrv@docker-node:~$ pg_dump -U postgres -h 127.0.0.1 test_database > dump_001.sql
```

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

*можно например так:*
```sql
CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0,
    UNIQUE (title)
)
PARTITION BY RANGE (price);
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
