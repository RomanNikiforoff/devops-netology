# Домашнее задание к занятию "3. MySQL"

## Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/blob/virt-11/additional/README.md).

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-03-mysql/test_data) и 
восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

Используя команду `\h` получите список управляющих команд.

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

```shell
mysql> SELECT VERSION();
+-----------+
| VERSION() |
+-----------+
| 8.0.32    |
+-----------+
1 row in set (0.00 sec)

mysql> SHOW VARIABLES LIKE '%version%';
+--------------------------+------------------------------+
| Variable_name            | Value                        |
+--------------------------+------------------------------+
| admin_tls_version        | TLSv1.2,TLSv1.3              |
| immediate_server_version | 999999                       |
| innodb_version           | 8.0.32                       |
| original_server_version  | 999999                       |
| protocol_version         | 10                           |
| replica_type_conversions |                              |
| slave_type_conversions   |                              |
| tls_version              | TLSv1.2,TLSv1.3              |
| version                  | 8.0.32                       |
| version_comment          | MySQL Community Server - GPL |
| version_compile_machine  | x86_64                       |
| version_compile_os       | Linux                        |
| version_compile_zlib     | 1.2.13                       |
+--------------------------+------------------------------+
13 rows in set (0.00 sec)
mysql> status;
--------------
mysql  Ver 8.0.32 for Linux on x86_64 (MySQL Community Server - GPL)
```

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

**Приведите в ответе** количество записей с `price` > 300.

```shell
mysql> select count(id) from orders where price>300;
+-----------+
| count(id) |
+-----------+
|         1 |
+-----------+
1 row in set (0.00 sec)

mysql>
```

В следующих заданиях мы будем продолжать работу с данным контейнером.

## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"

```shell
mysql> CREATE USER test IDENTIFIED WITH mysql_native_password BY 'test-pass' WITH MAX_QUERIES_PER_HOUR 100 PASSWORD EXPIRE INTERVAL 180 DAY FAILED_LOGIN_ATTEMPTS 3  ATTRIBUTE '{"surname":"Pretty", "name":"james"}';
Query OK, 0 rows affected (0.00 sec)
```

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.

```shell
mysql> grant select on test_db.* TO 'test';
Query OK, 0 rows affected (0.00 sec)
```
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.

```shell
mysql> select * from INFORMATION_SCHEMA.USER_ATTRIBUTES where user='test'
    -> ;
+------+------+----------------------------------------+
| USER | HOST | ATTRIBUTE                              |
+------+------+----------------------------------------+
| test | %    | {"name": "james", "surname": "Pretty"} |
+------+------+----------------------------------------+
1 row in set (0.00 sec)

mysql>
```

## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.
```shell
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> show profiles;
+----------+------------+-------------------+
| Query_ID | Duration   | Query             |
+----------+------------+-------------------+
|        1 | 0.00019400 | SET profiling = 1 |
+----------+------------+-------------------+
1 row in set, 1 warning (0.00 sec)
```

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.
```shell
mysql> SHOW TABLE STATUS FROM test_db LIKE 'orders'\G;
*************************** 1. row ***************************
           Name: orders
         Engine: InnoDB
```

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`

```shell
mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.06 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW TABLE STATUS FROM test_db LIKE 'orders'\G;
*************************** 1. row ***************************
           Name: orders
         Engine: MyISAM

mysql> SHOW PROFILES;
+----------+------------+----------------------------------------------+
| Query_ID | Duration   | Query                                        |
+----------+------------+----------------------------------------------+
|        1 | 0.00019400 | SET profiling = 1                            |
|        2 | 0.00055150 | SHOW TABLE STATUS FROM orders LIKE 'plugin'  |
|        3 | 0.00148375 | SHOW TABLE STATUS FROM test_db LIKE 'plugin' |
|        4 | 0.00195925 | SHOW TABLE STATUS FROM test_db LIKE 'plugin' |
|        5 | 0.00071100 | SHOW CREATE TABLE plugin                     |
|        6 | 0.00147175 | SHOW TABLE STATUS FROM test_db LIKE 'plugin' |
|        7 | 0.00062875 | SHOW CREATE TABLE plugin                     |
|        8 | 0.00666675 | SHOW TABLE STATUS FROM test_db LIKE 'orders' |
|        9 | 0.06715950 | ALTER TABLE orders ENGINE = MyISAM           |
|       10 | 0.00222675 | SHOW TABLE STATUS FROM test_db LIKE 'orders' |
+----------+------------+----------------------------------------------+
10 rows in set, 1 warning (0.00 sec)
```
## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
