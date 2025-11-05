Customer(cust_no,cust_fname,cust_lname,cust_company,cust_addr,city,cust_phone) 
order(order_no,cust_no,ISBN,qty,odate);
 book(ISBN,title,unit_price,author_no,publisher_no,pub_year); 
 author(author_no,author_name,country) 
 publisher(publisher_no,publisher_name,publisher_addr,year);



 Create table Customer (
    cust_no int primary key ,
    cust_fname varchar(50),
    cust_lname varchar(50),
    cust_company varchar(100),
    cust_addr varchar(150),
    city varchar(50),
    cust_phone varchar(50)
 );

 create table author (
    author_no int primary key ,
    author_name varchar(50) ,
    country varchar(50)
 ) ;

 create table publisher (
    publisher_no  int primary key,
    publisher_name varchar(50),
    publisher_addr varchar(50),
    year YEAR
 );

 CREATE TABLE Book (
    ISBN VARCHAR(20) PRIMARY KEY,
    title VARCHAR(100),
    unit_price DECIMAL(10,2),
    author_no INT,
    publisher_no INT,
    pub_year YEAR,
    FOREIGN key (author_no) REFERENCES author(author_no),
    FOREIGN key (publisher_no) REFERENCES publisher(publisher_no)
      

 );


Insert at least 10 records in customer table and insert other tables accordingly.


2. Display all customer details with city pune and mumbai and customer first name starting with 'p' or 'h'.

select * from Customer 
where
(city = 'pune' or city = 'mumbai') and (cust_fname like 'R%' or cust_fname like 'V%') ;



3. lists the number of different customer cities.
select count(distinct city ) as cnt from Customer;


4. Give 5% increase in price of the books with publishing year 2015.

update Book 
set unit_price = unit_price * 0.5
where pub_year = 2004;


5. Delete customer details living in pune.

delete from Customer where city = 'Pune';

6. Find the names of authors living in India or Australia .

select author_name from author where country = 'India'  or country = 'UK' ;

7. Find the publishers who are established between 2015 and 2016

select * from publisher where
year between 1900 and 2004;

8. Find the book having maximum price and find titles of book having price between 300 and 400.

(
    select title , unit_price from Book
where unit_price = (select max(unit_price) from Book)
)
union
(
    select title , unit_price from Book
    where
    unit_price between 200 and 400
);

9. Display all titles of books with price and published year in decreasing order of publishing year.

select title , unit_price  from Book
order by pub_year desc;


10. Display title,author_no and publisher_no of all books published in 2000,2004,2006.

select title , author_no , publisher_no from Book
where pub_year in(2003,2004,2006);



CREATE INDEX idx_city ON Customer(cust_city);


SELECT UPPER(cust_fname) AS FirstNameUpper
FROM Customer;


SELECT CURDATE() AS Today, YEAR(CURDATE()) AS Current_Year;


SELECT title, unit_price
FROM Book
WHERE unit_price > (SELECT AVG(unit_price) FROM Book);


SELECT cust_fname, cust_city FROM Customer WHERE cust_city='Pune'
UNION
SELECT cust_fname, cust_city FROM Customer WHERE cust_city='Mumbai';


SELECT city, COUNT(*) AS total_customers
FROM Customer
GROUP BY city
ORDER BY total_customers DESC;


SELECT  city, COUNT(*) AS total_customers
FROM Customer
GROUP BY city
HAVING COUNT(*) < 2;
