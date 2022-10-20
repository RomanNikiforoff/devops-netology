# Домашнее задание к занятию 12.5 "Реляционные базы данных: Индексы"


## Задание 1.

Напишите запрос к учебной базе данных, который вернет процентное отношение общего размера всех индексов к общему размеру всех таблиц.
```sql
SELECT
table_name AS `Table`,
round(((data_length) / 1024), 2) as 'table-Size Kb',
round(((INDEX_LENGTH) / 1024), 2)as 'index-Size Kb',
round(((INDEX_LENGTH) / 1024), 2)/round(((data_length) / 1024), 2) `proportion`
FROM information_schema.TABLES
WHERE table_schema = "sakila" 
ORDER BY data_length desc;
```
или

```sql
select
round((sum(DATA_LENGTH) / 1024), 2) as 'table-Size in Kb',
round((sum(INDEX_LENGTH) /1024),2) as 'index-Size in Kb',
sum(INDEX_LENGTH) / sum(DATA_LENGTH) as 'proportion'
from information_schema.tables
where TABLE_SCHEMA = 'sakila'
```

## Задание 2.

Выполните explain analyze следующего запроса:
```sql
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and
p.payment_date = r.rental_date and
r.customer_id = c.customer_id and
i.inventory_id = r.inventory_id
```
перечислите узкие места

* в запросе много лишнего
* производится ненужная выборка из больших таблиц

оптимизируйте запрос (внесите корректировки по использованию операторов, при необходимости добавьте индексы).

```sql
SELECT
concat(c.last_name, ' ', c.first_name),
sum(p.amount)
FROM payment p, customer c
WHERE
date(p.payment_date) = '2005-07-30' and
c.customer_id = p.customer_id 
group by p.customer_id
```

## Дополнительные задания (со звездочкой*)
Эти задания дополнительные (не обязательные к выполнению) и никак не повлияют на получение вами зачета по этому домашнему заданию. Вы можете их выполнить, если хотите глубже и/или шире разобраться в материале.

### Задание 3*.

Самостоятельно изучите, какие типы индексов используются в PostgreSQL. Перечислите те индексы, которые используются в PostgreSQL, а в MySQL нет.

Сводная таблица типов индексов

MySQL |	PostgreSQL |	MS SQL |	Oracle
------|------------|---------|---------
B-Tree index |	Есть	| Есть	| Есть	| Есть
Поддерживаемые пространственные индексы(Spatial indexes)|	R-Tree с квадратичным разбиением	| Rtree_GiST(используется линейное разбиение)	| 4-х уровневый Grid-based spatial index (отдельные для географических и геодезических данных) |	R-Tree c квадратичным разбиением; Quadtree
Hash index	|Только в таблицах типа Memory|	Есть	|Нет|	Нет
Bitmap index|	Нет|	Есть|	Нет|	Есть
Reverse index	|Нет|	Нет|	Нет	|Есть
Inverted index|	Есть	|Есть|	Есть|	Есть
Partial index	|Нет	|Есть|	Есть|	Нет
Function based index	|Нет	|Есть|	Есть|	Есть

*Приведите ответ в свободной форме.*
