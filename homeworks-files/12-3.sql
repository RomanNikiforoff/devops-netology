SELECT DISTINCT district from address
WHERE district like'K%a' and district not like '% %';

SELECT * FROM payment p
WHERE payment_date BETWEEN '2005-06-15'and '2005-06-18'
AND amount > 10
ORDER BY payment_date;

SELECT * FROM rental r
order by rental_date DESC  LIMIT 5;
