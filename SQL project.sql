#Q1 Who is the seniormost employee based on job title?
use music_database;
select*from employee order by levels desc limit 1;

#Q2 Which countries have the most Invoices?
select count(*) as c, billing_country from invoice
group by billing_country order by c desc;

#Q3 What are top 3 values of top invoice?
select total from invoice order by total desc
limit 3;

#Q4 Which city has the best customers?We would like to throw a promotional Music Festival in the city we made the most money.
-- Write a query that returns one city that has the highest sum of invoice totals.Return both the city names and sum of invoice totals.
select sum(total) as invoice_total,billing_city from invoice
group by billing_city
order by invoice_total desc;

#Q5 Write query to return the email, first name, last name, and Genre of all Rock Music listeners.
-- Return your list ordered alphabetically by email starting with letter A.
SELECT DISTINCT c.email, c.first_name, c.last_name
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
WHERE il.track_id IN (
    SELECT t.track_id
    FROM track t
    JOIN genre g ON t.genre_id = g.genre_id
    WHERE g.name LIKE 'Rock'
)
ORDER BY c.email;

