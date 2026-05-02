/* THE STATEMENT: You and your business partner were recently apporoched by another local business owner who is interested
 in purchasing Maven Movies. He primarily own restaurants and bias so he has lots of questions for you about your business and
 the rental business in general. His offer seem very generous so you are going to entertain his questions*/
/*THE OBJECTIVE: Use MYSQL to Leverage your SQL to extract and analyze the data from various tables in the Maven Movies database
to answer your potential Acquirer's questions. Each questions will require you to write a multi-table SQL query, 
joining at least two tables*/
Use mavenmovies;
/*QUESTION 1: My partner and I want to come by each of the stores in person and meet the managers. Please send over the manager's names 
at each store, with the full address of each property(street address, district, city, country please*/
SELECT * FROM staff; -- To explore the columns in the staff table
SELECT * FROM address; -- To explore the columns in the address table
SELECT 
staff.store_id,
staff.first_name,
staff.last_name,
staff.address_id,
address.address,
address.district,
city.city,
country.country
FROM staff
LEFT JOIN address
ON staff.address_id=address.address_id
LEFT JOIN city
ON city.city_id=address.city_id
LEFT JOIN Country
ON city.country_id=country.country_id;


/*QUESTION 2: I would like to get a better understanding of all of the inventory that would come along with the business.
 Please pull together a list of each inventory_id, the name of the film, the film's rating, it's rental rate and replacement cost*/
SELECT * FROM inventory AS I;
SELECT * FROM film AS F;
SELECT 
I.inventory_id,
F.title,
F.rating,
F.rental_rate,
F.replacement_cost
FROM Inventory AS I
LEFT JOIN Film AS F
ON I.film_id= F.film_id;

/* QUESTION 3: From the same list of films you just pulled, please roll that data up and provide a summary level overview of 
your inventory. We would like to know how many inventory items you have with each rating at each store.*/
SELECT * FROM inventory;
SELECT 
F.rating,
I.store_id,
COUNT(I.inventory_id) AS Total_inventory
FROM Film AS F
LEFT JOIN Inventory AS I
ON F.film_id=I.film_id
GROUP BY F.rating,
I.store_id;

/* QUESTION 4: Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to see how big 
of a hit it would be if a certain category of film became unpopular at a certain store. We would like to see the number of films as 
well as the average replacement cost and total replacement cost sliced by store and category*/
SELECT * FROM film_category;
SELECT 
I.store_id,
FC.category_id,
COUNT(F.film_id) AS Total_Number_of_films,
AVG(F.replacement_cost) AS Average_Replacement_cost,
SUM(F.replacement_cost) AS Total_Replacement_cost
FROM Film AS F
LEFT JOIN Inventory AS I
ON F.film_id=I.film_id
LEFT JOIN Film_Category AS FC
ON FC.film_id=I.film_id
GROUP BY I.store_id,
FC.category_id;

/* QUESTION 5: We want to make sure you folks have a good handle on who your customers are. Please provide a list of customer names,
 which store they go to, whether or not they are currently active, and their full addresses, street address, city and country.*/
 SELECT 
 C.first_name,
 C.last_name,
 C.store_id,
 C.active,
 AD.address,
 Cty.city,
 Country.country
 FROM Customer AS C
 LEFT JOIN Address AS AD
 ON C.address_id=AD.address_id
 LEFT JOIN City AS Cty
 ON Cty.city_id=AD.city_id
 LEFT JOIN Country 
 ON Country.country_id=Cty.country_id;


/* QUESTION 6: We would like to understand how much your customers are spending with you and also to know who your
 most valuable cusomers are. Please pull together a list of customer names, their total lifetime rentals, and the sum 
 of all payments you have collected from them. It would be great to see this ordered on total lifetime value, with the 
 most valuable customers at the top of the list.*/
 SELECT * FROM rental;
 SELECT customer_id,
 COUNT( rental_id) AS Total_rentals
 FROM rental
 GROUP BY customer_id
 ORDER BY Total_rentals DESC;
 SELECT * FROM payment;
SELECT customer_id,
COUNT(rental_id) AS Total_Rentals
FROM payment
GROUP BY cuStomer_id
ORDER BY Total_Rentals DESC;
-- Just exploring the data to understand results and compare the results of Total rentals when using the Rental tables and payment tables.
-- Result is the same so I go ahead to work on the whole business question asked

SELECT
payment.customer_id,
customer.first_name,
customer.last_name,
COUNT(payment.rental_id) AS Total_Rentals,
SUM(payment.amount) AS Total_Payments
FROM payment
LEFT JOIN customer
ON payment.customer_id=customer.customer_id
GROUP BY payment.customer_id,
customer.first_name,
customer.last_name
ORDER BY Total_Payments DESC
LIMIT 5;

-- Top 5 Customers in terms of Total payments/Lifetime value are Customer 526(Karl Seal), 148(Eleanor Hunt), 144(Clara Shaw)
-- ,178(Marion Snyder), 137(Rhonda Kennedy)


/*QUESTION 7: My partner and I would like to get to know your board of advisors and any current investors. Could you 
please provide a list of advisor and investor names in one tabl? Could you please note whether they are an investor or 
an advisor and for the investors, it would be good to include which company they work with*/

SELECT * FROM advisor; -- To see the columns in the advisor table
SELECT * FROM investor; -- To see the columns in the Investor table
SELECT 
'Advisor' as Type,
first_name,
last_name,
NULL AS Company_name
FROM Advisor
UNION 
SELECT 
'Investor' as Type,
first_name,
last_name,
company_name
FROM Investor;

/*Question 8: We're interested in how well you have covered the most awarded actors. Of all the actors with three types 
of awards,
 for what % of them do we carry a film? 
 And how about for actors with two types of awards? Same questions finally 
how about actors with just one award?*/
SELECT * FROM actor_award;
SELECT * FROM actor_award
JOIN actor
ON actor_award.actor_id=actor.actor_id
JOIN film_actor
ON film_actor.actor_id=actor.actor_id
JOIN film
ON film.film_id=film_actor.film_id;

-- Implementattion
    SELECT 
    ac.award_types,
    COUNT(DISTINCT ac.actor_id) AS total_actors,
    COUNT(DISTINCT fa.actor_id) AS actors_with_films,
    ROUND(
        COUNT(DISTINCT fa.actor_id) * 100.0 / COUNT(DISTINCT ac.actor_id),
        2
    ) AS percent_with_films
FROM
(
    SELECT 
        actor_id,
        LENGTH(awards) - LENGTH(REPLACE(awards, ',', '')) + 1 AS award_types
    FROM actor_award
) ac
LEFT JOIN film_actor fa
    ON ac.actor_id = fa.actor_id
WHERE ac.award_types IN (1,2,3)
GROUP BY ac.award_types
ORDER BY ac.award_types DESC;
