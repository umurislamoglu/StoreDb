---ürün verisi gör
CREATE VIEW showProductData
AS 
SELECT p.id, p.product_name,b.brand_name,c.category_name, p.list_price,p.stock 
FROM products p
JOIN Brands b ON p.brand_id=b.id
JOIN Category c ON p.category_id=c.id

---Sipariþ verisi gör
CREATE VIEW showOrderData
AS 
SELECT o.id,o.order_date,concat(c.first_name,c.last_name) as customerName,s.store_name,
concat(e.first_name,e.last_name) as employeeName,p.product_name,o.order_quantity,b.brand_name
FROM orders o
JOIN Customers c ON c.id = o.customer_id
JOIN Employees e ON e.id = o.employee_id
JOIN stores s ON s.id = o.store_id
JOIN Products p ON p.id = o.product_id
JOIN Brands b ON p.brand_id=b.id


--Çalýþan verisi gör
CREATE VIEW showEmployeeData
AS 
SELECT e.id,concat(e.first_name,e.last_name) as employeeName,concat(m.first_name,m.last_name) as managerName,
s.store_name,s.city,e.isactive,e.phone
FROM Employees e
JOIN Managers m ON m.id=e.manager_id
JOIN stores s ON s.id=e.store_id



--Ürün isminden fiyat görme
CREATE PROCEDURE showPriceFromName @product_name nvarchar(250)
AS
SELECT product_name,list_price FROM Products WHERE product_name = @product_name


--ürün isminden stok görme
CREATE PROCEDURE showStockFromName @product_name nvarchar(250)
AS
SELECT product_name,Stock FROM Products WHERE product_name = @product_name


--- Ürün satma (Kasadan Satýþ iþlemi)

CREATE PROCEDURE sellProduct (@product_name NVARCHAR(250), @quantity INT)
AS

DECLARE @stok int,@product_id int ,@order_date date,@list_price int;


SET @stok = (
    SELECT stock FROM products where product_name = @Product_name
);

SET @product_id = (
   select id from products where product_name = @product_name
);

SET @order_date = (
    select getdate()
);

SET @list_price = (
   select list_price from Products where product_name= @product_name
);

BEGIN

IF @stok - @quantity >= 0 
BEGIN
UPDATE Products SET Stock = Stock - @Quantity WHERE Product_name = @Product_name
INSERT INTO Orders(customer_id, store_id, product_id , employee_id,order_date,order_quantity,Order_price) 
VALUES(1,1,@product_id,1,@order_date,@quantity,@quantity*@list_price);
END

ELSE
BEGIN
PRINT '***Insufficent Stock***'
END


END