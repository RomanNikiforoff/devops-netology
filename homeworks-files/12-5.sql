# sql запросы к заданию 12-5 индексы

# 12-5-1
# v.1 с разбивкой по таблицам
SELECT
table_name AS `Table`,
round(((data_length) / 1024), 2) as 'table-Size Kb',
round(((INDEX_LENGTH) / 1024), 2)as 'index-Size Kb',
round(((INDEX_LENGTH) / 1024), 2)/round(((data_length) / 1024), 2) `proportion`
FROM information_schema.TABLES
WHERE table_schema = "sakila"
ORDER BY data_length desc;

# v.2 общие размеры
SELECT
ROUND((SUM(DATA_LENGTH) / 1024), 2) AS 'table-Size in Kb',
ROUND((SUM(INDEX_LENGTH) /1024),2) AS 'index-Size in Kb',
SUM(INDEX_LENGTH) / SUM(DATA_LENGTH) AS 'proportion'
FROM information_schema.tables
WHERE TABLE_SCHEMA = 'sakila'
