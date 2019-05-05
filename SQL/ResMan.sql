CREATE TABLE Shop(
ID int NOT NULL PRIMARY KEY IDENTITY,
Name nvarchar(200),
[Address] nvarchar(200),
CreateDate date NOT NULL,
IsActive int NOT NULL
);

CREATE TABLE Customer(
ID int NOT NULL PRIMARY KEY IDENTITY,
Name nvarchar(200),
Phone nvarchar(200),
ShopID int FOREIGN KEY REFERENCES Shop(ID),
CreateDate date NOT NULL,
IsActive int NOT NULL
);

CREATE TABLE Role(
ID int NOT NULL PRIMARY KEY IDENTITY,
Name nvarchar(200),
[Action] nvarchar(100),
PositionID int FOREIGN KEY REFERENCES Position(ID),
CreateDate date NOT NULL,
IsActive int NOT NULL
);

CREATE TABLE Position(
ID int NOT NULL PRIMARY KEY IDENTITY,
Name nvarchar(200),
CreateDate date NOT NULL,
IsActive int NOT NULL
);

CREATE TABLE [User](
ID int NOT NULL PRIMARY KEY IDENTITY,
UserName nvarchar(200),
[Password] varchar(1000),
PositionID int NOT NULL FOREIGN KEY REFERENCES Position(ID),
ShopID int NOT NULL FOREIGN KEY REFERENCES Shop(ID),
CreateDate date NOT NULL,
IsActive int NOT NULL
);

ALTER TABLE Category
ADD ShopID int FOREIGN KEY REFERENCES Shop(ID);
ALTER TABLE Product
ADD ShopID int FOREIGN KEY REFERENCES Shop(ID);
ALTER TABLE [Order]
ADD ShopID int FOREIGN KEY REFERENCES Shop(ID);

SELECT * FROM Product;

--View
-- lay danh sach san pham tren 100000
CREATE VIEW PRODUCT100K AS
SELECT * FROM Product
WHERE Price>100000

SELECT * FROM PRODUCT100K
--trigger
--khi  them danh muc san pham moi ma trung ten thi khong cho them
CREATE TRIGGER trg_KiemTraTrungTenDMSP on Category AFTER insert AS
BEGIN
	IF (SELECT COUNT(*) FROM Category JOIN inserted ON inserted.ID=Category.ID  WHERE Category.Name=Inserted.Name)>0
	BEGIN
		PRINT 'CategoryError';
	END;	 
END



