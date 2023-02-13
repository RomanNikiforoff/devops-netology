# Домашнее задание к занятию "2. SQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/blob/virt-11/additional/README.md).

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.
```shell
sudo docker run -d  --name postgres-latest3 -p 5432:5432    -e POSTGRES_PASSWORD=postgres   -e PGDATA=/var/lib/postgresql/data/pgdata       -v ~/pgdata:/var/lib/postgresql/data -v ~/pgbackup:/var/lib/postgresql/data/bacup       postgres
```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db

```shell
test_db=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)

test_db=#
test_db=# \d orders
                                    Table "public.orders"
 Column |          Type          | Collation | Nullable |              Default
--------+------------------------+-----------+----------+------------------------------------
 id     | integer                |           | not null | nextval('orders_id_seq'::regclass)
 name   | character varying(200) |           |          |
 price  | integer                |           |          |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_order_id_fkey" FOREIGN KEY (order_id) REFERENCES orders(id)

test_db=#
test_db=# \d clients
                                     Table "public.clients"
  Column  |          Type          | Collation | Nullable |               Default
----------+------------------------+-----------+----------+-------------------------------------
 id       | integer                |           | not null | nextval('clients_id_seq'::regclass)
 surname  | character varying(200) |           |          |
 country  | character varying(200) |           |          |
 order_id | integer                |           |          |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "clients_order_id_fkey" FOREIGN KEY (order_id) REFERENCES orders(id)

test_db=#

SELECT * from information_schema.table_privileges WHERE grantee = 'test_simple_user' LIMIT 20;

 grantor  |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy
----------+------------------+---------------+--------------+------------+----------------+--------------+----------------
 postgres | test_simple_user | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test_simple_user | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test_simple_user | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test_simple_user | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test_simple_user | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test_simple_user | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test_simple_user | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test_simple_user | test_db       | public       | clients    | DELETE         | NO           | NO
(8 rows)

test_db=# SELECT * from information_schema.table_privileges WHERE grantee = 'test_admin_user' LIMIT 20;
 grantor  |     grantee     | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy
----------+-----------------+---------------+--------------+------------+----------------+--------------+----------------
 postgres | test_admin_user | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test_admin_user | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test_admin_user | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test_admin_user | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test_admin_user | test_db       | public       | orders     | TRUNCATE       | NO           | NO
 postgres | test_admin_user | test_db       | public       | orders     | REFERENCES     | NO           | NO
 postgres | test_admin_user | test_db       | public       | orders     | TRIGGER        | NO           | NO
 postgres | test_admin_user | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test_admin_user | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test_admin_user | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test_admin_user | test_db       | public       | clients    | DELETE         | NO           | NO
 postgres | test_admin_user | test_db       | public       | clients    | TRUNCATE       | NO           | NO
 postgres | test_admin_user | test_db       | public       | clients    | REFERENCES     | NO           | NO
 postgres | test_admin_user | test_db       | public       | clients    | TRIGGER        | NO           | NO
(14 rows)
```

## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|



Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

```shell
test_db=# select * from clients;
 id |       surname        | country | order_id
----+----------------------+---------+----------
  1 | Ritchie Blackmore    | Russia  |
  2 | Иванов Иван Иванович | USA     |
  3 | Петров Петр Петрович | Canada  |
  4 | Иоганн Себастьян Бах | Japan   |
  5 | Ронни Джеймс Дио     | Russia  |
(5 rows)

test_db=# select * from orders;
 id |  name   | price
----+---------+-------
  1 | шоколад |    10
  2 | принтер |  3000
  3 | книга   |   500
  4 | монитор |  7000
  5 | гитара  |  4000
(5 rows)
```

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
```shell
test_db=# select count(id) from orders;
 count
-------
     5
(1 row)

test_db=# select count(id) from clients;
 count
-------
     5
(1 row)
```
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.
```shell
test_db=# update clients set order_id=4 where surname = 'Петров Петр Петрович';
UPDATE 1
test_db=# update clients set order_id=5 where surname = 'Иоганн Себастьян Бах';
UPDATE 1
test_db=# select surname, orders.name from clients, orders where order_id=orders.id;
       surname        |  name
----------------------+---------
 Иванов Иван Иванович | книга
 Петров Петр Петрович | монитор
 Иоганн Себастьян Бах | гитара
(3 rows)
```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.
```shell
test_db=# explain select surname, orders.name from clients, orders where order_id=orders.id;
                              QUERY PLAN
-----------------------------------------------------------------------
 Hash Join  (cost=13.82..24.97 rows=90 width=836)
   Hash Cond: (clients.order_id = orders.id)
   ->  Seq Scan on clients  (cost=0.00..10.90 rows=90 width=422)
   ->  Hash  (cost=11.70..11.70 rows=170 width=422)
         ->  Seq Scan on orders  (cost=0.00..11.70 rows=170 width=422)
(5 rows)

test_db=#
```

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 
```shell
root@a850c1d08e6f:/# pg_dump -U postgres test_db >/var/lib/postgresql/data/bacup/test_db.dump

root@386bf3094d20:/# pg_restore -U postgres -d test_db /var/lib/postgresql/data/bacup/test_db.dump
```

---

### Как cдавать задание

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---