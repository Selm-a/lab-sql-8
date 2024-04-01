use sakila;

#1. rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select * from film;
select film.length , title,
	rank() over(order by film.length) as "rank"
	from film 
    where film.length != 0 and film.length is not null  ;  
    
#2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
select film.length , title, rating,
	rank() over(partition by rating order by film.length) as "rank"
	from film 
    where film.length != 0 and film.length is not null  ;  
    
#3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select * from category ;
select * from film_category;
#common key = category_id 

select count(film_id) as number_of_film, category.category_id, category.name
from film_category
left join category on category.category_id = film_category.category_id
group by category_id;

#4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select * from actor;
select * from film_actor;
#common key = actor_id 

select count(film_id) as number_of_film, actor.first_name, actor.last_name
from film_actor
left join actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id
order by number_of_film desc ;

#5. Which is the most active customer (the customer that has rented the most number of films)? 
# Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select * from rental; 
select * from customer; 
#common key = customer_id 

select count(rental_id) as number_film, customer.first_name, customer.last_name
from customer
left join rental on rental.customer_id = customer.customer_id
group by customer.customer_id 
order by number_film desc;

#Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
#This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
#Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.

select * from film;
select * from inventory ; #common key = film_id
select * from rental; # common key = inventory_id 

select count(r.rental_id) as number_rental, f.title
from rental r 
join inventory i
on i.inventory_id = r.inventory_id
join film f 
on f.film_id = i.film_id
group by f.title
order by number_rental desc limit 1;







