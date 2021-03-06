CREATE DATABASE ResMan;

CREATE TABLE Category(
ID int NOT NULL PRIMARY KEY IDENTITY(1,1),
Name nvarchar(100) NOT NULL,
CreateDate datetime NOT NULL,
IsActive tinyint NOT NULL
);

CREATE TABLE Product(
ID int NOT NULL PRIMARY KEY IDENTITY(1,1),
Name nvarchar(100) NOT NULL ,
Price int NOT NULL,
CategoryID int FOREIGN KEY REFERENCES Category(ID),
CreateDate datetime NOT NULL,
IsActive tinyint NOT NULL
);

CREATE TABLE [Order](
ID int NOT NULL PRIMARY KEY IDENTITY,
BuyDate datetime NOT NULL,
TotalPrice int,
CreateDate datetime NOT NULL,
IsActive tinyint NOT NULL);

CREATE TABLE OrderDetail(
ID int NOT NULL PRIMARY KEY IDENTITY,
OrderID int NOT NULL FOREIGN KEY REFERENCES [Order] (ID),
ProductID int NOT NULL FOREIGN KEY REFERENCES [Product] (ID),
Amount int NOT NULL,
SumPrice int NOT NULL,
CreateDate datetime NOT NULL,
IsActive tinyint NOT NULL);

DROP TABLE OrderDetail;
TRUNCATE TABLE OrderDetail; --xoa k khoi phuc lai dc
DELETE FROM OrderDetail;

INSERT INTO Category(Name,CreateDate,IsActive) VALUES (N'Trà sữa', GETDATE(),1);
INSERT INTO Category VALUES (N'Thuốc lá', GETDATE(),1);

INSERT INTO Product VALUES  (N'Trà sữa Vải',45000,1,GETDATE(),1);
INSERT INTO Product VALUES  (N'Trà sữa Quất',40000,1,GETDATE(),1);
INSERT INTO Product VALUES  (N'Thuốc lá',40000,2,GETDATE(),1);

INSERT INTO [Order] VALUES (GETDATE(),90000,GETDATE(),1);
INSERT INTO [Order] VALUES (GETDATE(),70000,GETDATE(),1);

INSERT INTO OrderDetail VALUES(1,1,1,70000,GETDATE(),1);
INSERT INTO OrderDetail VALUES(1,2,2,20000,GETDATE(),1);
INSERT INTO OrderDetail VALUES(2,1,1,70000,GETDATE(),1);
INSERT INTO OrderDetail VALUES(2,2,2,20000,GETDATE(),1);



UPDATE Product SET Price=30000 WHERE ID=2;
DELETE FROM Product WHERE ID=3;

SELECT * FROM Product WHERE IsActive=1;

SELECT p.Name, p.Price, c.Name FROM Product p
JOIN Category c ON p.CategoryID=c.ID
WHERE p.IsActive=1

-- COUNT, sum
SELECT COUNT(p.ID) FROM Product p
JOIN Category c on p.CategoryID=c.ID
WHERE c.Name=N'Trà sữa';

SELECT sum(p.Price) FROM Product p
JOIN Category c on p.CategoryID=c.ID
WHERE c.Name=N'Trà sữa';

--group by
--Tính xem mỗi danh mục sản phẩm có bao nhiêu sản phẩm

SELECT c.ID,c.Name, COUNT(p.ID) as'Số SP' FROM Product p
JOIN Category c on p.CategoryID = c.ID
GROUP BY c.ID, c.Name

--Tổng doanh thu ngày hiện tại
SELECT SUM(TotalPrice) FROM [Order]

--Tổng số tiền của hóa đơn 1
SELECT SUM(TotalPrice) FROM [Order]
WHERE [Order].ID=1 
--Món ăn nào bán chạy nhất
SELECT TOP 1 p.Name,SUM(ord.Amount) as Mon_ban_chay_nhat
FROM  product p
JOIN OrderDetail ord on p.ID=ord.ProductID
GROUP BY p.Name
ORDER BY SUM(ord.Amount) DESC;

--Doanh thu tháng hiện tại
SELECT SUM(TotalPrice) as Doanh_Thu_Thang_Hien_tai 
FROM [Order]
WHERE CreateDate<='2018-10-31' AND CreateDate>='2018-10-01';
--Hiển thị TTDS sản phẩm, tên sản phẩm, số lượng của đơn hàng cuối
SELECT Product.ID,Product.Name ,[Order].ID
FROM Product
JOIN OrderDetail on Product.ID=OrderDetail.ProductID
JOIN [Order] on [Order].ID=OrderDetail.OrderID
WHERE [Order].ID=(SELECT MAX(ID) FROM [Order] )


--Hiển thị tổng số lượng đã bán mối sản phẩm
SELECT Product.Name, SUM(OrderDetail.Amount) as Tong_So_Luong
FROM Product
JOIN OrderDeTail on Product.ID=OrderDetail.ProductID
Group By Product.Name 

--Đếm số hóa đơn đã bán
SELECT COUNT([Order].ID) as So_Hoa_Don_Da_Ban
FROM [Order]

--Hiển thị danh sách tên sản phẩm bán được
SELECT Product.ID, Product.Name 
FROM OrderDetail 
JOIN Product ON OrderDetail .ProductID=Product.ID
GROUP BY  Product.ID, Product.Name;
--Số lượng sản phẩm tương ứng mỗi hóa đơn
--C1
SELECT [Order].ID, SUM(OrderDetail.Amount) as So_Luong_SP
FROM OrderDetail
JOIN [Order] on [Order].ID=OrderDetail.OrderID
GROUP BY [Order].ID;
--c2
SELECT OrderDetail.OrderID, SUM(OrderDetail.Amount)
FROM OrderDetail
GROUP BY OrderDetail.OrderID

--Đếm số đơn bán trong tháng
SELECT COUNT([Order].ID) as So_Don_Ban_Trong_Thang
FROM [Order]
WHERE CreateDate<='2018-10-31' AND CreateDate>='2018-10-01';

--Hiển thị tên nhóm sản phẩm có nhiều sản phẩm nhất(group by ID, join, max)
SELECT Category.Name, MAX(OrderDetail.Amount)
FROM OrderDetail 
JOIN Product on Product.ID=OrderDetail.ProductID
JOIN Category on Category.ID=Product.CategoryID
GROUP BY Category.Name;

--Số lượng tiền đã bán mỗi sản phẩm
SELECT Product.ID, Product.Name, SUM(OrderDetail.SumPrice)
FROM OrderDetail
JOIN Product on Product.ID= OrderDetail.ID
GROUP BY Product.ID, Product.Name;




