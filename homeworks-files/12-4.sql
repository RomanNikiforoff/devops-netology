
# 12-4-1

SELECT DISTINCT customer.store_id, staff.first_name , staff.last_name, city.city,
(SELECT COUNT(customer.customer_id) FROM customer where customer.store_id = (select customer.store_id from customer GROUP BY customer.store_id having count(customer.store_id) >300)) as usercount
FROM customer
JOIN staff ON staff.store_id = customer.store_id
join store on store.store_id = customer.store_id
join address on address.address_id = store.address_id
join city on city.city_id = address.city_id
HAVING customer.store_id=(select customer.store_id
FROM customer
GROUP BY customer.store_id
HAVING count(customer.store_id) >300)

# 12-4-2

SELECT COUNT(film_id)
FROM sakila.film
WHERE film.`length` > (SELECT avg(`length`) FROM sakila.film)

# 12-4-3

SELECT SUM(amount) as summa, MONTH(payment_date) as mounth, COUNT(rental_id) as rent_count
FROM sakila.payment
GROUP BY MONTH(payment_date)
ORDER BY summa DESC LIMIT 1

# 12-4-4*

SELECT rental.staff_id, count(staff_id),
CASE
	WHEN count(staff_id)>8000 THEN 'YES'
	ELSE 'NO'
end as 'премия'
FROM rental
GROUP BY rental.staff_id

# 12-4-5*

SELECT film.film_id, film.title
FROM film
WHERE film.film_id NOT IN (SELECT inventory.film_id FROM inventory)
