	#DAY 3
    use classicmodels;
    select*from products;
    #Q1) Show customer number, customer name, state and credit limit from customers table for below conditions.
    SELECT customerNumber, customerName, state, creditLimit FROM customers 
    WHERE state IS NOT NULL AND creditLimit BETWEEN 50000 AND 100000 ORDER BY creditLimit DESC;
    
    #Q2) Show the unique productline values containing the word cars at the end from products table.
  SELECT DISTINCT productLine FROM products WHERE productLine LIKE '%cars';



#DAY 4
use classicmodels;
select*from orders;

#Q1) Show the orderNumber, status and comments from orders table for shipped status only. If some comments are having null values then show them as “-“.
SELECT orderNumber, status, COALESCE(comments, '-') AS comments FROM orders WHERE status = 'Shipped';

#Q2) Select employee number, first name, job title and job title abbreviation from employees table based on following conditions.
SELECT employeeNumber, firstName, jobTitle, CASE WHEN jobTitle = 'President' THEN 'P'
 WHEN jobTitle ='Manager' THEN 'SM' WHEN jobTitle = 'Sales Rep' THEN 'SR'
 WHEN jobTitle LIKE 'VP' THEN 'VP' ELSE jobTitle END AS jobTitleAbbreviation FROM employees;
 
 
 
 #DAY 5
use classicmodels;
select*from payments;

#Q1) For every year, find the minimum amount value from payments table.
select YEAR(paymentDate) AS paymentYear, MIN(amount) AS minimumAmount FROM payments GROUP BY paymentYear;

#Q2) For every year and every quarter, find the unique customers and total orders from orders table. Make sure to show the quarter as Q1,Q2 etc.
SELECT YEAR(orderDate) AS orderYear, CONCAT('Q', QUARTER(orderDate)) AS quarter,
 COUNT(DISTINCT customerNumber) AS uniqueCustomers, COUNT(orderNumber) AS totalOrders 
 FROM orders GROUP BY orderYear, quarter ORDER BY orderYear, quarter;
 
 #Q3) Show the formatted amount in thousands unit (e.g. 500K, 465K etc.) for every month (e.g. Jan, Feb etc.) with filter on total amount as 500000 to 1000000.
 SELECT DATE_FORMAT(paymentDate, '%b') AS month, CONCAT(FORMAT(SUM(amount) / 1000, 0), 'K') 
 AS formattedAmount FROM payments GROUP BY month HAVING SUM(amount) BETWEEN 500000 AND 1000000 ORDER BY SUM(amount) DESC;
 
 
 
 #DAY 6
#Q1) Create a journey table with following fields and constraints.
create table journey(Bus_id int not null,Bus_Name VARCHAR(200) NOT NULL,
Source_station varchar(200) not null,Destination varchar(200) not null,
Email varchar(200) not null unique, primary key(Bus_id));
select*from journey;

#Q2) Create vendor table with following fields and constraints
create table vendor( Vendor_ID 	int not null primary key,
Name varchar(200) not null,Email varchar(200) not null unique,
Country varchar(200) default 'N/A');
select*from vendor;

#Q3) Create movies table with following fields and constraints
CREATE TABLE movies ( Movie_ID INT NOT NULL PRIMARY KEY,
 Name VARCHAR(255) NOT NULL, Release_Year INT, Cast VARCHAR(255) NOT NULL, 
 Gender ENUM('Male', 'Female') NOT NULL, No_of_shows INT CHECK (No_of_shows > 0) );
 select*from movies;
 
 #Q4) Create the following tables. Use auto increment wherever applicable.
 CREATE TABLE Suppliers ( supplier_id INT AUTO_INCREMENT PRIMARY KEY, supplier_name VARCHAR(255) NOT NULL, location VARCHAR(255) );
 
 CREATE TABLE Product ( product_id INT AUTO_INCREMENT PRIMARY KEY, 
 product_name VARCHAR(255) NOT NULL UNIQUE, 
 description TEXT, supplier_id INT, FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) );
 select*from product;
 
 create table stock(id int primary key,balance_stock int,product_id int ,foreign key(product_id) references product(product_id));
 select*from stock;
 
 
 
 #DAY 7
select*from employees;
select*from customers;

# Q1) Show employee number, Sales Person (combination of first and last names of employees), unique customers for each employee number and sort the data by highest to lowest unique customers.
SELECT e.employeeNumber AS employeeNumber, CONCAT(e.firstName, ' ', e.lastName) AS SalesPerson, 
COUNT(DISTINCT c.customerNumber) AS uniqueCustomers FROM Employees e LEFT JOIN Customers c ON e.employeeNumber = c.salesRepEmployeeNumber 
GROUP BY e.employeeNumber, SalesPerson ORDER BY uniqueCustomers DESC;

# Q2) Show total quantities, total quantities in stock, left over quantities for each product and each customer. Sort the data by customer number.


# Q3) Create below tables and fields. (You can add the data as per your wish)
create table laptop(laptop_name varchar(100) not null);
create table colour(colour_name varchar(100) not null);
insert into laptop (laptop_name)values ('Apple'),('Dell'),('HP');
insert into colour(colour_name)values ('Black'),('White'),('Grey');
select l.laptop_name,c.colour_name from laptop l cross join colour c;

# Q4) Create table project with below fields.
create table project(EmployeeID int,FullName varchar(100),Gender varchar(100),ManagerID int);
insert into project values(1,'Pranaya','Male',3);
insert into project values(2,'Priyanka','Female',1);
insert into project values(3,'Preeti','Female',null);
insert into project values(4,'Anurag','Male',1);
insert into project values(5,'Sambhit','Male',1);
insert into project values(6,'Rajesh','Male',3);
insert into project values(7,'Hina','Female',3);
select*from project;
drop table project;
SELECT p1.FullName AS "Manager Name", p2.FullName AS "Emp Name" FROM Project p1 JOIN Project p2 ON p1.EmployeeID = p2.ManagerID;



#Day 8
#Q1) Create table facility. Add the below fields into it.
create table facility(Facility_ID int not null,Name varchar(200),State varchar(200),Country varchar(200));
alter table facility modify column Facility_ID int primary key auto_increment;
alter table facility add column city varchar(100) not null after name;



#Day 9
#Q1) Create table university with below fields.
create table university(ID int,Name varchar(100));
insert into university values(1,'Pune University'),(2,'Mumbai University'),(3,'Delhi University'),(4,'Madras University'),(5,'Nagpur University');
select*from university;



#Day 10
#Q1) Create the view products status. Show year wise total products sold. Also find the percentage of total value for each year. The output should look as shown in below figure.
CREATE VIEW products_status AS SELECT YEAR(o.orderDate) AS Year, 
CONCAT( count(od.priceEach), ' (', ROUND((SUM(od.priceEach * od.quantityOrdered) / (SELECT SUM(od2.priceEach * od2.quantityOrdered) 
FROM OrderDetails od2)) * 100), '%)' ) AS Value FROM Orders o JOIN OrderDetails od ON o.orderNumber = od.orderNumber GROUP BY Year ORDER BY Value desc;

#Day 11
# Q1 Create a stored procedure GetCustomerLevel which takes input as customer number and gives the output as either Platinum, Gold or Silver as per below criteria.
select * from customers;

CALL GetCustomerLevel(103,@level);
SELECT @level AS "Customer Level";

# Q2 Create a stored procedure Get_country_payments which takes in year and country as inputs and gives year wise, country wise total amount as an output.
drop procedure Get_country_payments;
CALL Get_country_payments(2003, 'France');



# DAY 12
#Q1 Calculate year wise, month name wise count of orders and year over year (YoY) percentage change. Format the YoY values in no decimals and show in % sign.
SHOW COLUMNS FROM Orders;
WITH YearMonthOrders AS (
  SELECT
    EXTRACT(YEAR FROM orderDate) AS order_year,
    DATE_FORMAT(orderDate, '%M') AS order_month,
    COUNT(*) AS order_count
  FROM
    Orders
  GROUP BY
    order_year, order_month
  ORDER BY
    order_year, order_month
),

YoYPercentageChange AS (
  SELECT
    a.order_year,
    a.order_month,
    a.order_count,
    b.order_count AS prev_year_order_count,
    CASE
      WHEN b.order_count IS NULL THEN 'N/A' -- Avoid division by zero
      ELSE
        CONCAT(
          ROUND(((a.order_count - b.order_count) / b.order_count) * 100),
          '%'
        )
    END AS yoy_percentage_change
  FROM
    YearMonthOrders a
  LEFT JOIN
    YearMonthOrders b
  ON
    a.order_year = b.order_year + 1
    AND a.order_month = b.order_month
)

SELECT
  order_year,
  order_month,
  order_count,
  yoy_percentage_change
FROM
  YoYPercentageChange;
  
  #Q2 Create the table emp_udf with below fields.
  CREATE TABLE emp_udf (
    Emp_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    DOB DATE
);
  
  INSERT INTO emp_udf (Name, DOB)
VALUES 
    ("Piyush", "1990-03-30"),
    ("Aman", "1992-08-15"),
    ("Meena", "1998-07-28"),
    ("Ketan", "2000-11-21"),
    ("Sanjay", "1995-05-21");
    
  SELECT Emp_ID,Name, DOB, calculate_age(DOB) AS Age FROM emp_udf;
  
  


#DAY 13
#Q1 Display the customer numbers and customer names from customers table who have not placed any orders using subquery
-- Table: Customers, Orders
SELECT CustomerNumber, CustomerName
FROM Customers
WHERE CustomerNumber NOT IN (SELECT CustomerNumber FROM Orders);

#Q2 Write a full outer join between customers and orders using union and get the customer number, customer name, count of orders for every customer.
SELECT C.CustomerNumber, C.CustomerName, IFNULL(COUNT(O.OrderNumber), 0) AS OrderCount
FROM Customers AS C
LEFT JOIN Orders AS O ON C.CustomerNumber = O.CustomerNumber
GROUP BY C.CustomerNumber, C.CustomerName
UNION
SELECT O.CustomerNumber, C.CustomerName, IFNULL(COUNT(O.OrderNumber), 0) AS OrderCount
FROM Customers AS C
RIGHT JOIN Orders AS O ON C.CustomerNumber = O.CustomerNumber
GROUP BY O.CustomerNumber, C.CustomerName;

#Q3 Show the second highest quantity ordered value for each order number.
SELECT
    OrderNumber,
    MAX(QuantityOrdered) AS quantityOrdered
FROM
    Orderdetails AS od1
WHERE
    QuantityOrdered < (
        SELECT MAX(QuantityOrdered)
        FROM Orderdetails AS od2
        WHERE od1.OrderNumber = od2.OrderNumber
    )
GROUP BY OrderNumber;

#Q4 For each order number count the number of products and then find the min and max of the values among count of orders.
 SELECT
    MAX(ProductCount) AS "MAX(Total)",
    MIN(ProductCount) AS "MIN(Total)"
FROM (
    SELECT
        OrderNumber,
        COUNT(*) AS ProductCount
    FROM
        Orderdetails
    GROUP BY
        OrderNumber
) AS Counts;

#Q5  Find out how many product lines are there for which the buy price value is greater than the average of buy price value. Show the output as product line and its count.
SELECT p.ProductLine,
    COUNT(*) AS Total
FROM
    Products AS p
JOIN (
    SELECT
        AVG(BuyPrice) AS AvgBuyPrice
    FROM
        Products
) AS avg_prices
ON p.BuyPrice > avg_prices.AvgBuyPrice
GROUP BY
    p.ProductLine
ORDER BY
    Total DESC;



#DAY 14
#Q1 Create the table Emp_EH. Below are its fields.
CREATE TABLE Emp_EH (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(255),
    EmailAddress VARCHAR(255)
);



#DAY 15
#Q1 Create the table Emp_BIT. Add below fields in it.
CREATE TABLE Emp_BIT (
    Name VARCHAR(255),
    Occupation VARCHAR(255),
    Working_date DATE,
    Working_hours INT
);
INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);

DELIMITER //
CREATE TRIGGER EnsurePositiveWorkingHours
BEFORE INSERT ON Emp_BIT
FOR EACH ROW
BEGIN
    IF NEW.Working_hours < 0 THEN
        SET NEW.Working_hours = -NEW.Working_hours;
    END IF;
END //
DELIMITER ;












 
 
 
 