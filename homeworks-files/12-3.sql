#12-3-1
SELECT DISTINCT district from address
WHERE district like'K%a' and district not like '% %';

#12-3-2
SELECT * FROM payment p
WHERE payment_date BETWEEN '2005-06-15'and '2005-06-18'
AND amount > 10
ORDER BY payment_date;

#12-3-3
SELECT * FROM rental r 
order by rental_date DESC  LIMIT 5;

#12-3-4
SELECT REPLACE (LOWER (first_name), 'll', 'pp'), LOWER (last_name) 
FROM sakila.customer c
WHERE first_name LIKE 'Kelly' OR first_name LIKE 'Willie';

#12-3-5
SELECT
LEFT (email, (locate ('@', email)-1)),
RIGHT (email, LENGTH (email)-(locate ('@', email)))
FROM sakila.customer c
ORDER by email LIMIT 10;

#12-3-6
SELECT
CONCAT(LEFT(email, 1), SUBSTRING(LOWER (LEFT (email, (locate ('@', email)-1))), 2)) as firstname,
RIGHT (email, LENGTH (email)-(locate ('@', email))) as domenname
FROM sakila.customer c
ORDER by email LIMIT 10;