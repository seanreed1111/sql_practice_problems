DROP DATABASE IF EXISTS northwindpg;
CREATE DATABASE northwindpg;
\connect northwindpg postgres;

CREATE TABLE IF NOT EXISTS Categories(
CategoryID serial PRIMARY KEY,
CategoryName VARCHAR(15) UNIQUE NOT NULL,
Description TEXT
);

CREATE TABLE IF NOT EXISTS Customers(
CustomerID CHAR(5) PRIMARY KEY,
CompanyName VARCHAR(40) NOT NULL,
ContactName VARCHAR(30),
ContactTitle VARCHAR(30),
Address VARCHAR(60),
City VARCHAR(15),
Region VARCHAR(15),
PostalCode VARCHAR(10),
Country VARCHAR(15),
Phone VARCHAR(24),
Fax VARCHAR(24)
);

CREATE INDEX ON
  Customers(City);
CREATE INDEX ON
  Customers(CompanyName);
CREATE INDEX ON
  Customers(PostalCode);
CREATE INDEX ON
  Customers(Region);


CREATE TABLE IF NOT EXISTS
Employees(
EmployeeID serial PRIMARY KEY,
LastName VARCHAR(20) NOT NULL,
FirstName VARCHAR(10) NOT NULL,
Title VARCHAR(30),
TitleOfCourtesy VARCHAR(25),
BirthDate timestamp,
HireDate timestamp,
Address VARCHAR(60),
City VARCHAR(15),
Region VARCHAR(15),
PostalCode VARCHAR(10),
Country VARCHAR(15),
HomePhone VARCHAR(24),
Extension VARCHAR(4),
Photo VARCHAR(255),
Notes TEXT,
ReportsTo INT,
PhotoPath VARCHAR(255)
);
CREATE INDEX ON
  Employees(LastName);

CREATE TABLE IF NOT EXISTS Shippers(
ShipperID serial PRIMARY KEY,
CompanyName VARCHAR(40) NOT NULL,
Phone VARCHAR(24)
);

CREATE TABLE IF NOT EXISTS Orders(
OrderID serial PRIMARY KEY,
CustomerID CHAR(5) REFERENCES Customers(CustomerID),
EmployeeID INT NOT NULL REFERENCES Employees(EmployeeID),
OrderDate timestamp,
RequiredDate timestamp,
ShippedDate timestamp,
ShipVia INT NOT NULL REFERENCES Shippers(ShipperID),
Freight FLOAT DEFAULT 0,
ShipName VARCHAR(40),
ShipAddress VARCHAR(60),
ShipCity VARCHAR(15),
ShipRegion VARCHAR(15),
ShipPostalCode VARCHAR(10),
ShipCountry VARCHAR(15)
);
CREATE INDEX ON Orders(OrderDate);
CREATE INDEX ON Orders(ShippedDate);
CREATE INDEX ON Orders(ShipPostalCode);

CREATE TABLE IF NOT EXISTS Suppliers(
SupplierID serial PRIMARY KEY,
CompanyName VARCHAR(50) NOT NULL,
ContactName VARCHAR(50),
ContactTitle VARCHAR(50),
Address VARCHAR(60),
City VARCHAR(15),
Region VARCHAR(15),
PostalCode VARCHAR(10),
Country VARCHAR(15),
Phone VARCHAR(24),
Fax VARCHAR(24),
HomePage VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Products(
ProductID serial PRIMARY KEY,
ProductName VARCHAR(40) NOT NULL,
SupplierID INT NOT NULL  REFERENCES Suppliers (SupplierID),
CategoryID INT NOT NULL REFERENCES Categories (CategoryID),
QuantityPerUnit VARCHAR(20),
UnitPrice FLOAT DEFAULT 0,
UnitsInStock SMALLINT DEFAULT 0,
UnitsOnOrder SMALLINT DEFAULT 0,
ReorderLevel SMALLINT DEFAULT 0,
Discontinued SMALLINT DEFAULT 0 NOT NULL
);
Create INDEX ON Products(ProductName);

CREATE TABLE IF NOT EXISTS OrderDetails(
OrderID INT NOT NULL REFERENCES Orders(OrderID),
ProductID INT NOT NULL REFERENCES Products(ProductID),
PRIMARY KEY (OrderID , ProductID),
UnitPrice FLOAT DEFAULT 0 NOT NULL,
Quantity SMALLINT DEFAULT 1 NOT NULL,
Discount FLOAT DEFAULT 0 NOT NULL
);

CREATE TABLE IF NOT EXISTS CustomerGroupThresholds(
CustomerGroupName VARCHAR(20) DEFAULT NULL,
RangeBottom DECIMAL(16,5) DEFAULT NULL,
RangeTop DECIMAL(20,5) DEFAULT NULL
);
