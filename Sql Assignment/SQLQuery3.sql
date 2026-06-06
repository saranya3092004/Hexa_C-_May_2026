create database ECOMMERCE_ASSIGNMENT_DB;

use ECOMMERCE_ASSIGNMENT_DB;

create table Customer(customerId int identity(1,1)primary key,
CustomerName varchar(50) not null,
Email varchar(50)not null unique,
MobileNo varchar(10) not null,
City varchar(50)not null,
Address varchar(100)not null,
IsActive bit default 1 not null,
CreatedDate datetime default getdate());

drop table Customer;

create table Seller(SellerID int identity(1,1) primary key,
SellerName varchar(50) not null,
Email varchar(50) not null unique,
MobileNo varchar(10) not null,
City varchar(50) not null,
Rating decimal(3,2),
IsActive bit default 1 not null);

create table Product(ProductId int identity(1,1) primary key,
ProductName varchar(50) not null,
Category varchar(50) not null,
Price decimal(10,2)not null,
StockQuantity int not null,
SellerId int not null Foreign key references Seller(SellerId),
CreateddDate datetime default getDate());

create table Orders(OrderID int identity(1,1) primary key,
CustomerId int not null foreign key references Customer(CustomerId),
OrderDate datetime default getdate(),
OrderStatus varchar(50) not null default 'pending',
PaymentMode varchar(50) not null,
DeliveryCity varchar(50)not null);

create table OrderItem(OrderItemId int identity(1,1) primary key,
OrderId int foreign key references Orders(OrderID),
ProductId int foreign key references Product(ProductId),
Quantity int not null check (Quantity>0),
UnitPrice decimal(10,2) not null);

alter table Product add Constraint CHK_Product_Price check (Price>0);
alter table Product add Constraint CHK_Product_StockQuantity check (StockQuantity >0);


INSERT INTO Customer (CustomerName, Email, MobileNo, City, Address) VALUES
('Anand','anand@gmail.com', '9876543210', 'Chennai', '123 Anna Nagar'),
('Arun Kumar', 'arun.k@gmail.com', '9812345678', 'Bangalore', '45 MG Road'),
('Priya', 'priya@gmail.com', '9123456789', 'Chennai', '78 T Nagar'),
('Suresh Kumar', 'suresh.k@gmail.com', '9873456712', 'Hyderabad', '12 Gachibowli'),
('Vijay', 'vijay@gmail.com', '8123456789', 'Mumbai', '56 Andheri');

INSERT INTO Seller (SellerName, Email, MobileNo, City, Rating) VALUES
('Kumar Traders', 'contact@kumartraders.com', '1122334455', 'Chennai', 4.5),
('Murugan Electronics', 'info@muruganelectronics.com', '2233445566', 'Coimbatore', 4.2),
('Anbu Stores', 'sales@anbustores.com', '3344556677', 'Madurai', 3.9),
('Selvam Retail', 'contact@selvamretail.com', '4455667788', 'Trichy', 4.0);

INSERT INTO Product (ProductName, Category, Price, StockQuantity, SellerId) VALUES
('iPhone 15', 'Mobile', 79900.00, 25, 1),
('Galaxy S24', 'Mobile', 74900.00, 5, 2),
('MacBook Air M3', 'Laptop', 114900.00, 15, 1),
('Dell Inspiron 15', 'Laptop', 45000.00, 8, 3),
('Redmi Note 13', 'Mobile', 17999.00, 50, 2),
('Sony WH-1000XM4', 'Audio', 19990.00, 30, 3),
('iPad Air', 'Tablet', 59900.00, 12, 1);

INSERT INTO Orders (CustomerId, OrderStatus, PaymentMode, DeliveryCity) VALUES
(5, 'Delivered', 'Credit Card', 'Chennai'),
(6, 'Pending', 'UPI', 'Bangalore'),
(7, 'Delivered', 'Net Banking', 'Chennai'),
(5, 'Shipped', 'COD', 'Chennai'),
(8, 'Cancelled', 'UPI', 'Hyderabad');

SELECT CustomerId, CustomerName FROM Customer;

INSERT INTO OrderItem (OrderId, ProductId, Quantity, UnitPrice) VALUES
(2, 1, 1, 79900.00), 
(2, 6, 1, 19900.00), 
(3, 3, 1, 114900.00),
(3, 2, 1, 74900.00), 
(4, 5, 2, 17999.00), 
(4, 7, 1, 59900.00), 
(5, 4, 1, 45000.00), 
(5, 6, 2, 19990.00),
(6, 5, 1, 17999.00),
(6, 2, 1, 74900.00);

select * from Orders;

Update Customer set City = 'Coimbatore' where CustomerId = 5;

update Product set Price = 81900.00 where ProductId = 1;

update Orders set OrderStatus = 'Shipped' where OrderId = 2;

delete from Product where ProductId = 8;

select * from Customer;
select * from Seller;
select * from Product;
select * from Orders;
select * from OrderItem;

select * from Customer where City='chennai';
select * from Customer where City <> 'chennai'; 

select * from Product where Price>50000;
select * from Product where price between 10000 and 60000;
select * from Product where Category ='Mobile' or Category= 'Laptop';
select * from Product where Category in('Mobile','Laptop'); -- above query is same  we can use or (or) in

select * from Customer where CustomerName like 'A%';
select * from Customer where Email Like '%gmail%';
select * from Product where ProductName like '%phone%';
select * from Orders where Orderstatus = 'delivered';
select * from Product where Price not between 10000and 50000;
select * from Customer where City in ('chennai','bangalore');
select * from Customer where City='chennai' and IsActive =1;

select * from Customer where City <> 'Hyderabad';

select city,count(CustomerID) as TotalCount from Customer group by city;
select Category,count(ProductId) as Totalcount from Product group by Category;
select Category, sum(StockQuantity) as TotalStock from Product group by Category;
select Category, max(Price) as MaxPrice from Product group by Category;
select Category, min(Price) as MinPrice from Product group by Category;
select Category, avg(Price) as AvgPrice from Product group by Category;


select o.CustomerId, sum(oi.Quantity * oi.UnitPrice) as TotalOrderAmount
from Orders o
join OrderItem oi on o.OrderId = oi.OrderId
group by o.CustomerId;

select ProductId, sum(Quantity * UnitPrice) as TotalSalesAmount
from OrderItem
group by ProductId;

select ProductId,sum(Quantity) as TotalQuantity 
from OrderItem	  group by ProductId;

select Category, count(ProductId) as ProductCount
from Product
group by Category
having count(ProductId) > 1;

select o.CustomerId, sum(oi.Quantity * oi.UnitPrice) as TotalOrderAmount
from Orders o
join OrderItem oi on o.OrderId = oi.OrderId
group by o.CustomerId
having sum(oi.Quantity * oi.UnitPrice) > 50000;

select SellerId, count(ProductId) as TotalProducts
from Product
group by SellerId;

select p.SellerId, sum(oi.Quantity * oi.UnitPrice) as TotalSales
from OrderItem oi
join Product p on oi.ProductId = p.ProductId
group by p.SellerId;

select OrderStatus, count(OrderId) as OrderCount
from Orders
group by OrderStatus;

select City, count(CustomerId) as CustomerCount
from Customer
group by City
order by CustomerCount desc;

select * from Product order by Price;

select * from Product order by Price desc;

select * from Customer order by City, CustomerName;

select * from Orders order by OrderDate desc;

select * from Product order by Category, Price desc;

select top 3 * from Product order by Price desc;

select top 5 * from Orders order by OrderDate desc;

select * from Customer order by IsActive desc, CustomerName;



select o.OrderId, o.OrderDate, o.OrderStatus, c.CustomerName, c.Email
from Orders o
inner join Customer c on o.CustomerId = c.CustomerId;

select p.ProductId, p.ProductName, p.Price, s.SellerName, s.Email as SellerEmail
from Product p
inner join Seller s on p.SellerId = s.SellerId;

select oi.OrderItemId, oi.OrderId, p.ProductName, oi.Quantity, oi.UnitPrice
from OrderItem oi
inner join Product p on oi.ProductId = p.ProductId;

select o.OrderId, o.OrderDate, c.CustomerName,
p.ProductName, oi.Quantity, oi.UnitPrice, s.SellerName
from Orders o
inner join Customer c on o.CustomerId = c.CustomerId
inner join OrderItem oi on o.OrderId = oi.OrderId
inner join Product p on oi.ProductId = p.ProductId
inner join Seller s on p.SellerId = s.SellerId;

select c.CustomerId, c.CustomerName, o.OrderId, o.OrderStatus
from Customer c
left join Orders o on c.CustomerId = o.CustomerId;

select o.OrderId, o.OrderStatus, c.CustomerId, c.CustomerName
from Orders o
right join Customer c on o.CustomerId = c.CustomerId;

select c.CustomerId, c.CustomerName, o.OrderId, o.OrderStatus
from Customer c
full outer join Orders o on c.CustomerId = o.CustomerId;

select c.CustomerName, p.ProductName
from Customer c
cross join Product p;

select c.*
from Customer c
left join Orders o on c.CustomerId = o.CustomerId
where o.OrderId is null;

select p.*
from Product p
left join OrderItem oi on p.ProductId = oi.ProductId
where oi.OrderItemId is null;

select s.SellerName, p.ProductName, p.Category, p.Price
from Seller s
left join Product p on s.SellerId = p.SellerId
order by s.SellerName;

select distinct c.CustomerName, p.ProductName
from Customer c
inner join Orders o on c.CustomerId = o.CustomerId
inner join OrderItem oi on o.OrderId = oi.OrderId
inner join Product p on oi.ProductId = p.ProductId;

select OrderId, sum(Quantity * UnitPrice) as TotalAmount
from OrderItem
group by OrderId;

select s.SellerId, s.SellerName,
isnull(sum(oi.Quantity * oi.UnitPrice), 0) as TotalSales
from Seller s
left join Product p on s.SellerId = p.SellerId
left join OrderItem oi on p.ProductId = oi.ProductId
group by s.SellerId, s.SellerName;

select p.ProductId, p.ProductName,
isnull(sum(oi.Quantity), 0) as TotalQuantitySold
from Product p
left join OrderItem oi on p.ProductId = oi.ProductId
group by p.ProductId, p.ProductName;

