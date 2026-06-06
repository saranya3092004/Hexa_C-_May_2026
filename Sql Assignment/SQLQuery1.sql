use ECOMMERCE_ASSIGNMENT_DB;

--SubQuerries--

select * from Product where Price >
(select avg(Price) from Product );

select * from Product where StockQuantity <
(select avg(StockQuantity) from Product);

select * from Customer c where exists
(select 1 from Orders o where o.CustomerId=c.CustomerId);

select * from customer 
where customerid not in (select distinct customerid from orders where customerid is not null);

select * from product 
where productid in (select distinct productid from orderitem);

select * from product 
where productid not in (select distinct productid from orderitem where productid is not null);

select * from seller 
where sellerid in (select distinct sellerid from product);

select * from seller 
where sellerid not in (select distinct sellerid from product where sellerid is not null);

select * from orders 
where customerid in (select customerid from customer where city = 'chennai');

select * from product 
where sellerid in (select sellerid from seller where city = 'bangalore');


select * from customer 
where customerid in (select customerid from orders);

select * from customer 
where customerid not in (select customerid from orders where customerid is not null);

select * from product 
where productid in (select productid from orderitem);

select * from product 
where productid not in (select productid from orderitem where productid is not null);

select * from seller 
where sellerid in (select sellerid from product);

select * from seller 
where sellerid not in (select sellerid from product where sellerid is not null);

select * from orders 
where orderid in (select orderid from orderitem where productid in
(select productid from product where category = 'mobile'));

select * from orders 
where orderid not in 
(select orderid from orderitem where productid in 
(select productid from product where category = 'laptop'));


select * from customer 
where customerid in (select customerid from orders);

select * from customer 
where customerid not in (select customerid from orders where customerid is not null);

select * from product 
where productid in (select productid from orderitem);

select * from product 
where productid not in (select productid from orderitem where productid is not null);

select * from seller 
where sellerid in (select sellerid from product);

select * from seller 
where sellerid not in (select sellerid from product where sellerid is not null);

select * from orders 
where orderid in 
(select orderid from orderitem where productid in 
(select productid from product where category = 'mobile'));

select * from orders 
where orderid not in 
(select orderid from orderitem where productid in 
(select productid from product where category = 'laptop'));



select * from product 
where price = (select max(price) from product);

select * from product 
where price = (select min(price) from product);

select * from product 
where price > (select avg(price) from product);

select * from product 
where price < (select avg(price) from product);

select * from customer where customerid in 
(select o.customerid from orders o join orderitem oi on o.orderid = oi.orderid
group by o.customerid having sum(oi.quantity * oi.unitprice) > 
(select avg(totalamount) from 
(select sum(quantity * unitprice) as totalamount from orderitem 
 group by orderid) as avgorder));

select * from seller where sellerid in 
(select p.sellerid from product p join orderitem oi on p.productid = oi.productid
group by p.sellerid
having sum(oi.quantity * oi.unitprice) > 50000);

select * from product 
where productid in 
(select productid from orderitem group by productid
having sum(quantity) >
(select avg(sumqty) from (select sum(quantity) as sumqty 
from orderitem group by productid) as avgqty));

select top 1 * from customer 
where customerid = 
(select top 1 o.customerid from orders o
join orderitem oi on o.orderid = oi.orderid
group by o.customerid order by sum(oi.quantity * oi.unitprice) desc);

select top 1 * from product 
where productid = 
(select top 1 productid from orderitem group by productid
order by sum(quantity * unitprice) desc);

select top 1 * from seller 
where sellerid =
(select top 1 p.sellerid from product p
join orderitem oi on p.productid = oi.productid
group by p.sellerid
order by sum(oi.quantity * oi.unitprice) desc);


select * from product p1
where price > (select avg(price) from product p2 where p2.category = p1.category);

select * from product p1
where price < (select avg(price) from product p2 where p2.category = p1.category);

select * from seller s
where (select count(*) from product p where p.sellerid = s.sellerid) > 2;

select * from customer c
where (select count(*) from orders o where o.customerid = c.customerid) > 1;

select * from orders o1
where (select sum(quantity * unitprice) from orderitem oi where oi.orderid = o1.orderid) > 
      (select avg(totalamount) from (select sum(quantity * unitprice) as totalamount from orderitem group by orderid) as temp);

select * from product p1
where stockquantity > (select avg(stockquantity) from product p2 where p2.category = p1.category);

select * from seller s
where (select avg(price) from product p where p.sellerid = s.sellerid) > (select avg(price) from product);




select * from customer c
where exists (select 1 from orders o where o.customerid = c.customerid);

select * from customer c
where not exists (select 1 from orders o where o.customerid = c.customerid);

select * from product p
where exists (select 1 from orderitem oi where oi.productid = p.productid);

select * from product p
where not exists (select 1 from orderitem oi where oi.productid = p.productid);

select * from seller s
where exists (select 1 from product p where p.sellerid = s.sellerid);

select * from seller s
where not exists (select 1 from product p where p.sellerid = s.sellerid);

select * from customer c
where exists 
(select 1 from orders o join orderitem oi on o.orderid = oi.orderid
join product p on oi.productid = p.productid
where o.customerid = c.customerid and p.category = 'mobile');

select * from customer c
where not exists 
(select 1 from orders o join orderitem oi on o.orderid = oi.orderid
 join product p on oi.productid = p.productid
 where o.customerid = c.customerid and p.category = 'laptop');



--stored procedures

CREATE PROCEDURE sp_GetAllCustomers AS
BEGIN
SELECT * FROM Customer;
END;
GO


CREATE PROCEDURE sp_GetAllProducts AS
BEGIN
SELECT * FROM Product;
END;
GO

CREATE PROCEDURE sp_GetAllSellers AS
BEGIN
SELECT * FROM Seller;
END;
GO

CREATE PROCEDURE sp_GetAllOrders AS
BEGIN 
SELECT * FROM Orders;
END;
GO

CREATE PROCEDURE sp_GetAllOrderItems AS
BEGIN
SELECT * FROM OrderItem;
END;
GO



CREATE PROCEDURE sp_GetCustomerById @CustomerId INT AS
BEGIN
SELECT * FROM Customer WHERE CustomerId = @CustomerId;
END;
GO

CREATE PROCEDURE sp_GetProductById @ProductId INT AS
BEGIN
SELECT * FROM Product WHERE ProductId = @ProductId;
END;
GO

CREATE PROCEDURE sp_GetSellerById @SellerId INT AS
BEGIN
SELECT * FROM Seller WHERE SellerId = @SellerId;
END;
GO

CREATE PROCEDURE sp_GetOrderById @OrderId INT AS
BEGIN
SELECT * FROM Orders WHERE OrderId = @OrderId;
END;
GO

CREATE PROCEDURE sp_GetCustomersByCity @City VARCHAR(50) AS
BEGIN
SELECT * FROM Customer WHERE City = @City;
END;
GO

CREATE PROCEDURE sp_GetProductsByCategory @Category VARCHAR(50) AS
BEGIN
SELECT * FROM Product WHERE Category = @Category;
END;
GO

CREATE PROCEDURE sp_GetProductsBySellerId @SellerId INT AS
BEGIN
SELECT * FROM Product WHERE SellerId = @SellerId;
END;
GO

CREATE PROCEDURE sp_GetOrdersByCustomerId @CustomerId INT AS
BEGIN
SELECT * FROM Orders WHERE CustomerId = @CustomerId;
END;
GO

CREATE PROCEDURE sp_GetOrderItemsByOrderId @OrderId INT AS
BEGIN
SELECT * FROM OrderItem WHERE OrderId = @OrderId;
END;
GO

CREATE PROCEDURE sp_GetProductsPriceGreaterThan @Price DECIMAL(10,2) AS
BEGIN
SELECT * FROM Product WHERE Price > @Price;
END;
GO

CREATE PROCEDURE sp_InsertCustomer 
@CustomerName VARCHAR(100), @Email VARCHAR(100), @MobileNo VARCHAR(15), @City VARCHAR(50), @Address VARCHAR(255)
AS
BEGIN
INSERT INTO Customer (CustomerName, Email, MobileNo, City, Address)
VALUES (@CustomerName, @Email, @MobileNo, @City, @Address);
END;
GO

CREATE PROCEDURE sp_InsertSeller 
@SellerName VARCHAR(100), @Email VARCHAR(100), @MobileNo VARCHAR(15), @City VARCHAR(50), @Rating DECIMAL(3,2)
AS
BEGIN
INSERT INTO Seller (SellerName, Email, MobileNo, City, Rating)
VALUES (@SellerName, @Email, @MobileNo, @City, @Rating);
END;
GO

CREATE PROCEDURE sp_InsertProduct 
@ProductName VARCHAR(150), @Category VARCHAR(50), @Price DECIMAL(10,2), @StockQuantity INT, @SellerId INT
AS
BEGIN
INSERT INTO Product (ProductName, Category, Price, StockQuantity, SellerId)
VALUES (@ProductName, @Category, @Price, @StockQuantity, @SellerId);
END;
GO

CREATE PROCEDURE sp_InsertOrder 
@CustomerId INT, @OrderStatus VARCHAR(20), @PaymentMode VARCHAR(30), @DeliveryCity VARCHAR(50)
AS
BEGIN
INSERT INTO Orders (CustomerId, OrderStatus, PaymentMode, DeliveryCity)
VALUES (@CustomerId, @OrderStatus, @PaymentMode, @DeliveryCity);
END;
GO

CREATE PROCEDURE sp_InsertOrderItem 
@OrderId INT, @ProductId INT, @Quantity INT, @UnitPrice DECIMAL(10,2)
AS
BEGIN
INSERT INTO OrderItem (OrderId, ProductId, Quantity, UnitPrice)
VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice);
END;
GO


CREATE PROCEDURE sp_UpdateCustomerCity @CustomerId INT, @City VARCHAR(50) AS
BEGIN
UPDATE Customer SET City = @City WHERE CustomerId = @CustomerId;
END;
GO

CREATE PROCEDURE sp_UpdateCustomerMobile @CustomerId INT, @MobileNo VARCHAR(15) AS
BEGIN
UPDATE Customer SET MobileNo = @MobileNo WHERE CustomerId = @CustomerId;
END;
GO

CREATE PROCEDURE sp_UpdateProductPrice @ProductId INT, @Price DECIMAL(10,2) AS
BEGIN
UPDATE Product SET Price = @Price WHERE ProductId = @ProductId;
END;
GO

CREATE PROCEDURE sp_UpdateProductStock @ProductId INT, @StockQuantity INT AS
BEGIN
UPDATE Product SET StockQuantity = @StockQuantity WHERE ProductId = @ProductId;
END;
GO

CREATE PROCEDURE sp_UpdateOrderStatus @OrderId INT, @OrderStatus VARCHAR(20) AS
BEGIN
UPDATE Orders SET OrderStatus = @OrderStatus WHERE OrderId = @OrderId;
END;
GO

CREATE PROCEDURE sp_UpdateSellerRating @SellerId INT, @Rating DECIMAL(3,2) AS
BEGIN
UPDATE Seller SET Rating = @Rating WHERE SellerId = @SellerId;
END;
GO

CREATE PROCEDURE sp_UpdateCustomerActiveStatus @CustomerId INT, @IsActive BIT AS
BEGIN
UPDATE Customer SET IsActive = @IsActive WHERE CustomerId = @CustomerId;
END;
GO

CREATE PROCEDURE sp_UpdateSellerActiveStatus @SellerId INT, @IsActive BIT AS
BEGIN
UPDATE Seller SET IsActive = @IsActive WHERE SellerId = @SellerId;
END;
GO


CREATE PROCEDURE sp_DeleteCustomer @CustomerId INT AS
BEGIN
DELETE FROM Customer WHERE CustomerId = @CustomerId;
END;
GO

CREATE PROCEDURE sp_DeleteSeller @SellerId INT AS
BEGIN
DELETE FROM Seller WHERE SellerId = @SellerId;
END;
GO

CREATE PROCEDURE sp_DeleteProduct @ProductId INT AS
BEGIN
DELETE FROM Product WHERE ProductId = @ProductId;
END;
GO

CREATE PROCEDURE sp_DeleteOrder @OrderId INT AS
BEGIN
DELETE FROM Orders WHERE OrderId = @OrderId;
END;
GO

CREATE PROCEDURE sp_DeleteOrderItem @OrderItemId INT AS
BEGIN
DELETE FROM OrderItem WHERE OrderItemId = @OrderItemId;
END;
GO

CREATE PROCEDURE sp_GetCustomerOrderDetails AS
BEGIN
SELECT c.CustomerId, c.CustomerName, o.OrderId, o.OrderDate, o.OrderStatus
FROM Customer c
LEFT JOIN Orders o ON c.CustomerId = o.CustomerId;
END;
GO


CREATE PROCEDURE sp_GetSellerProductDetails AS
BEGIN
SELECT s.SellerId, s.SellerName, p.ProductId, p.ProductName, p.Price
FROM Seller s
LEFT JOIN Product p ON s.SellerId = p.SellerId;
END;
GO


CREATE PROCEDURE sp_GetOrderProductDetails AS
BEGIN
SELECT oi.OrderId, p.ProductId, p.ProductName, oi.Quantity, oi.UnitPrice
FROM OrderItem oi
INNER JOIN Product p ON oi.ProductId = p.ProductId;
END;
GO


CREATE PROCEDURE sp_GetCompleteOrderReport AS
BEGIN
SELECT 
o.OrderId, c.CustomerName, p.ProductName, s.SellerName, 
oi.Quantity, oi.UnitPrice, (oi.Quantity * oi.UnitPrice) AS TotalAmount
FROM Orders o
INNER JOIN Customer c ON o.CustomerId = c.CustomerId
INNER JOIN OrderItem oi ON o.OrderId = oi.OrderId
INNER JOIN Product p ON oi.ProductId = p.ProductId
INNER JOIN Seller s ON p.SellerId = s.SellerId;
END;
GO


CREATE PROCEDURE sp_GetCustomerTotalOrderAmount AS
BEGIN
SELECT c.CustomerId, c.CustomerName, ISNULL(SUM(oi.Quantity * oi.UnitPrice), 0) AS TotalSpent
FROM Customer c
LEFT JOIN Orders o ON c.CustomerId = o.CustomerId
LEFT JOIN OrderItem oi ON o.OrderId = oi.OrderId
GROUP BY c.CustomerId, c.CustomerName;
END;
GO


CREATE PROCEDURE sp_GetSellerTotalSales AS
BEGIN
SELECT s.SellerId, s.SellerName, ISNULL(SUM(oi.Quantity * oi.UnitPrice), 0) AS TotalSales
FROM Seller s
LEFT JOIN Product p ON s.SellerId = p.SellerId
LEFT JOIN OrderItem oi ON p.ProductId = oi.ProductId
GROUP BY s.SellerId, s.SellerName;
END;
GO


CREATE PROCEDURE sp_GetProductTotalSalesQuantity AS
BEGIN
SELECT p.ProductId, p.ProductName, ISNULL(SUM(oi.Quantity), 0) AS TotalQuantitySold
FROM Product p
LEFT JOIN OrderItem oi ON p.ProductId = oi.ProductId
GROUP BY p.ProductId, p.ProductName;
END;
GO



CREATE PROCEDURE sp_GetTotalCustomersCount
@TotalCustomers INT OUTPUT
AS
BEGIN
SELECT @TotalCustomers = COUNT(*) FROM Customer;
END;
GO


CREATE PROCEDURE sp_GetTotalProductsCount
@TotalProducts INT OUTPUT
AS
BEGIN
SELECT @TotalProducts = COUNT(*) FROM Product;
END;
GO


CREATE PROCEDURE sp_GetTotalOrdersCount
@TotalOrders INT OUTPUT
AS
BEGIN
SELECT @TotalOrders = COUNT(*) FROM Orders;
END;
GO


CREATE PROCEDURE sp_GetProductTotalSalesAmount
@ProductId INT,
@TotalSales DECIMAL(10,2) OUTPUT
AS
BEGIN
SELECT @TotalSales = ISNULL(SUM(Quantity * UnitPrice), 0) 
FROM OrderItem 
WHERE ProductId = @ProductId;
END;
GO


CREATE PROCEDURE sp_GetCustomerTotalPurchaseAmount
@CustomerId INT,
@TotalPurchase DECIMAL(10,2) OUTPUT
AS
BEGIN
SELECT @TotalPurchase = ISNULL(SUM(oi.Quantity * oi.UnitPrice), 0)
FROM Orders o
JOIN OrderItem oi ON o.OrderId = oi.OrderId
WHERE o.CustomerId = @CustomerId;
END;
GO