-- create database ToysGroup;
-- use Toysgroup;

create table product (
productid INT PRIMARY KEY auto_increment,
name varchar (200),
category varchar (150));

create table region (
regionid INT PRIMARY KEY auto_increment,
name varchar (200),
state varchar (100) );

create table sales (
salesid INT PRIMARY KEY auto_increment,
productid INT,
regionid INT,
sale_date date,
amount DECIMAL(10,2),
foreign key (productid) references product (productid),
foreign key (regionid) references region (regionid)
 );
 
 insert into product (name,category) values 
 ('OP01','cardgame'),
 ('OP02','cardgame'),
 ('OP03','cardgame'),
 ('luffy','action_figure'),
 ('zoro','action_figure');
 

-- /*select * from product;/*

insert into region ( name,state) values 
('veneto','Italy'),
('toscana','Italy'),
('sassonia','Germania'),
('canarie','Spagna'),
('frisia','Paesi_Bassi');

insert into sales (productid,regionid,sale_date,amount) values 
(1, 1, '2023-01-15', 230.50),
(2, 1, '2023-02-20', 350.75),
(1, 2, '2023-03-10', 230.50),
(3, 3, '2023-04-05', 420.00),
(5, 3, '2023-05-12', 170.50);

 -- select* from sales

-- 1. Verificare che i campi definiti come PK siano univoci. 
SELECT 
    COUNT(DISTINCT p.productid) AS product_distinct,
    COUNT(DISTINCT r.regionid) AS region_distinct,
    COUNT(DISTINCT s.salesid) AS sale_distinct 
FROM
    product p,
    Region r,
    Sales s;
    
    -- 2. Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno.  
    
SELECT 
    p.name, SUM(s.amount) revenue, YEAR(s.sale_date) year
FROM
    product p
        INNER JOIN
    sales s USING (productid)
GROUP BY sale_date , p.name , s.amount;
    
    
   --  3. Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente. 
   
SELECT 
    SUM(s.amount) total_amount,
    YEAR(s.sale_date) AS year,
    s.sale_date,
    r.state
FROM
    sales s
        INNER JOIN
    region r 
    using(regionid)
GROUP BY YEAR(s.sale_date) , r.state , s.sale_date
ORDER BY s.sale_date DESC,
total_amount DESC;


-- 4.Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato? 

select p.category,count(*)
from product p 
inner join sales s 
using (productid)
group by p.category
limit 1;

-- 5.Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti. 

/*1-
select p.name 
from product p
inner join sales s
using(productid)
where sale_date=null;*/

/*2-
select s.salesid
from sales s
where s.salesid like null;*/

-- 6-Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente).

select p.name,s.sale_date
from product p
join sales s 
using (productid)
order by s.sale_date DESC;







      






