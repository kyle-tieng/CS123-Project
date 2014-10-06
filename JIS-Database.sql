DROP DATABASE IF EXISTS JIS_Database;
CREATE DATABASE JIS_Database;
USE JIS_Database;

CREATE TABLE IF NOT EXISTS Clients(
TIN INT(9) UNSIGNED ZEROFILL NOT NULL,
Name VARCHAR(30) NOT NULL, 
Address VARCHAR(50),
Email VARCHAR(20),
Owner_Name VARCHAR(30),
Client_Type CHAR(8) NOT NULL,
PRIMARY KEY(TIN)
);

CREATE TABLE IF NOT EXISTS Tel_No(
Tel_No INT(10) UNSIGNED,
TIN INT(9) UNSIGNED ZEROFILL NOT NULL,
FOREIGN KEY(TIN) REFERENCES Clients(TIN),
PRIMARY KEY (Tel_No)
);

CREATE TABLE IF NOT EXISTS Fax_No(
Fax_No INT(10) UNSIGNED,
TIN INT(9) UNSIGNED ZEROFILL NOT NULL,
FOREIGN KEY(TIN) REFERENCES Clients(TIN),
PRIMARY KEY (Fax_No)
);

CREATE TABLE IF NOT EXISTS ITEM(
Model_No VARCHAR(12) NOT NULL,
Description VARCHAR(20) NOT NULL,
Price DECIMAL(8,2),
Quantity INT(6),
Storage_Location VARCHAR(30),
PRIMARY KEY(Model_No)
);

CREATE TABLE IF NOT EXISTS Invoice(
Invoice_No INT(8) UNSIGNED NOT NULL,
Customer_Name VARCHAR(30) NOT NULL,
Delivery_Address VARCHAR(50),
Customer_PO INT(10) UNSIGNED,
Total_Price DECIMAL(10,2),
PRIMARY KEY(Invoice_No),
FOREIGN KEY (Customer_Name) REFERENCES Clients(Name)
);

CREATE TABLE IF NOT EXISTS Invoice_Quantity(
Invoice_No INT(8) UNSIGNED NOT NULL,
Model_No VARCHAR(12) NOT NULL,
Quantity INT(6) UNSIGNED,
Unit VARCHAR(8),
Final_Price DECIMAL(9,2),
FOREIGN KEY (Invoice_No) REFERENCES Invoice(Invoice_No),
FOREIGN KEY (Model_No) REFERENCES Item(Model_No),
CONSTRAINT Invoice_Quantity_No PRIMARY KEY (Invoice_No, Model_No)
);

CREATE TABLE IF NOT EXISTS Discount_Invoice(
Discount_No INT(2) UNSIGNED NOT NULL,
Discount_Rate INT(5) UNSIGNED,
Invoice_No INT(6) UNSIGNED NOT NULL,
Model_No VARCHAR(12) NOT NULL,
FOREIGN KEY (Invoice_No) REFERENCES Invoice_Quantity(Invoice_No),
FOREIGN KEY (Model_No) REFERENCES Item(Model_No),
CONSTRAINT Discount_Invoice_No PRIMARY KEY (Discount_No, Invoice_No, Model_No)
);

CREATE TABLE IF NOT EXISTS Purchase_Order(
PO_No INT(6) UNSIGNED NOT NULL,
Supplier_Name VARCHAR(30) NOT NULL,
Total_Price DECIMAL(10,2),
PRIMARY KEY (PO_No),
FOREIGN KEY (Supplier_Name) REFERENCES Clients(Name)
);

CREATE TABLE IF NOT EXISTS PO_Quantity(
PO_No INT(6) UNSIGNED NOT NULL,
Model_No VARCHAR(12) NOT NULL,
Quantity INT(6) UNSIGNED,
Unit VARCHAR(8),
Final_Price DECIMAL(9,2),
FOREIGN KEY (PO_No) REFERENCES Purchase_Order(PO_No),
FOREIGN KEY (Model_No) REFERENCES Item(Model_No),
CONSTRAINT PO_Quantity_No PRIMARY KEY (PO_No, Model_No)
);

CREATE TABLE IF NOT EXISTS Discount_PO(
Discount_No INT(2) UNSIGNED NOT NULL,
Discount_Rate INT(5) UNSIGNED,
PO_No INT(6) UNSIGNED NOT NULL,
Model_No VARCHAR(12) NOT NULL,
FOREIGN KEY (PO_No) REFERENCES PO_Quantity(PO_No),
FOREIGN KEY (Model_No) REFERENCES Item(Model_No),
CONSTRAINT Discount_PO_No PRIMARY KEY (Discount_No, PO_No, Model_No)
);