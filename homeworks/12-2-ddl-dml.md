## Задание 1.
1.1 Поднимите чистый инстанс MySQL версии 8.0+. Можно использовать локальный сервер или контейнер Docker.

1.2 Создайте учетную запись sys_temp.

1.3 Выполните запрос на получение списка пользователей в Базе Данных. (скриншот)

![image](https://github.com/RomanNikiforoff/devops-netology/blob/main/pic/12-2-users.png)

1.4 Дайте все права для пользователя sys_temp.

1.5 Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)

![image](https://github.com/RomanNikiforoff/devops-netology/blob/main/pic/12-2-grants.png)

1.6 Переподключитесь к базе данных от имени sys_temp.

Для смены типа аутентификации с sha2 используйте запрос:

ALTER USER 'sys_test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';

1.6 По ссылке https://downloads.mysql.com/docs/sakila-db.zip скачайте дамп базы данных.

1.7 Восстановите дамп в базу данных.

1.8 При работе в IDE сформируйте ER-диаграмму получившейся базы данных. При работе в командной строке используйте команду для получения всех таблиц базы данных. (скриншот)

![image](https://github.com/RomanNikiforoff/devops-netology/blob/main/pic/12-2-sakila-ER.png)

![image](https://github.com/RomanNikiforoff/devops-netology/blob/main/pic/12-2-sakila-tab.png)

Результатом работы должны быть скриншоты обозначенных заданий, а так же "простыня" со всеми запросами.

## Задание 2.
Составьте таблицу, используя любой текстовый редактор или Excel, в которой должно быть два столбца, в первом должны быть названия таблиц восстановленной базы, во втором названия первичных ключей этих таблиц. Пример: (скриншот / текст)

Название таблицы | Название первичного ключа
customer         | customer_id

[таблица-ответ](https://github.com/RomanNikiforoff/devops-netology/blob/main/homeworks-files/12-2-table.txt)

Дополнительные задания (со звездочкой*)
Эти задания дополнительные (не обязательные к выполнению) и никак не повлияют на получение вами зачета по этому домашнему заданию. Вы можете их выполнить, если хотите глубже и/или шире разобраться в материале.

## Задание 3.*
3.1 Уберите у пользователя sys_temp права на внесение, изменение и удаление данных из базы sakila.

![image](https://github.com/RomanNikiforoff/devops-netology/blob/main/pic/12-2-revoke.png)

3.2 Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)

![image](https://github.com/RomanNikiforoff/devops-netology/blob/main/pic/12-2-grants2.png)

Результатом работы должны быть скриншоты обозначенных заданий, а так же "простыня" со всеми запросами.
