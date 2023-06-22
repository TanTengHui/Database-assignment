CONNECT TO SAMPLE;

DROP TABLE Customer;
DROP TABLE Buses;
DROP TABLE Bus_Ticket;
DROP TABLE Invoice ;
DROP TABLE Payment_Method ;


CREATE TABLE Buses (
  Bus_ID VARCHAR(20) NOT NULL,
  Seat_Cap INTEGER,
  Bus_Production DATE,
  Bus_Model VARCHAR(20),
  CONSTRAINT BUSID PRIMARY KEY (Bus_ID)
);

CREATE TABLE Customer (
  Customer_ID VARCHAR(20) NOT NULL,
  Cus_Name VARCHAR(20),
  Cus_Phone VARCHAR(20),
  Cus_Email VARCHAR(30),
  
  CONSTRAINT Cus_ID_PK PRIMARY KEY (Customer_ID)
);

CREATE TABLE Bus_Ticket (
  Ticket_ID VARCHAR(20) NOT NULL,
  Bus_ID VARCHAR(20),
  Customer_ID VARCHAR(20),
  Bus_Price INTEGER,
  CONSTRAINT B_Tic_ID_PK PRIMARY KEY (Ticket_ID),
  CONSTRAINT B_Bus_FK FOREIGN KEY (Bus_ID) REFERENCES Buses(Bus_ID),
  CONSTRAINT B_Cus_ID_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Invoice (
  Invoice_ID VARCHAR(20) NOT NULL,
  Invoice_Amount INTEGER,
  CONSTRAINT Invoice_Identity_PK PRIMARY KEY (Invoice_ID)
);

CREATE TABLE Payment_Method (
  Pay_ID VARCHAR(20) NOT NULL,
  Pay_Method VARCHAR(20),
  CONSTRAINT Pay_Identity_PK PRIMARY KEY (Pay_ID)
);

-- Inserting values into Customer table
INSERT INTO Customer VALUES ('C001','Ali','123456789', 'ALI@gmail.com');
INSERT INTO Customer VALUES ('C002','Akau','987654321', 'AKAU@gmail.com');
INSERT INTO Customer VALUES ('C003','Muthu','456789123', 'MUTHU@gmail.com');
INSERT INTO Customer VALUES ('C004', 'Richard','321654987','AYAMGORENG@gmail.com');


INSERT INTO Buses VALUES ('B001', 50, '2019-04-06', 'Shuttle bus');
INSERT INTO Buses VALUES ('B002', 50, '2021-06-15', 'Shuttle bus');
INSERT INTO Buses VALUES ('B003', 30, '2013-03-18', 'Tour bus');
INSERT INTO Buses VALUES ('B004', 60, '2022-09-20', 'Express bus');


INSERT INTO Bus_Ticket VALUES ('T001', 'B001', 'C001', 5);
INSERT INTO Bus_Ticket VALUES ('T002', 'B002', 'C002', 5);
INSERT INTO Bus_Ticket VALUES ('T003', 'B003', 'C003', 15);
INSERT INTO Bus_Ticket VALUES ('T004', 'B004', 'C004', 25);


INSERT INTO Invoice VALUES ('INV031', 5);
INSERT INTO Invoice VALUES ('INV056', 5);
INSERT INTO Invoice VALUES ('INV023', 15);
INSERT INTO Invoice VALUES ('INV076', 25);


INSERT INTO Payment_Method VALUES ('PAY001', 'CREDIT KAD');
INSERT INTO Payment_Method VALUES ('PAY002', 'E-payment');
INSERT INTO Payment_Method VALUES ('PAY003', 'DEBIT CARD');
INSERT INTO Payment_Method VALUES ('PAY004', 'CREDIT KAD');


SELECT * FROM Customer;


SELECT * FROM Buses;


SELECT * FROM Bus_Ticket;


SELECT * FROM Invoice;


SELECT * FROM Payment_Method;


-- QUERIES ONE 
SELECT Bus_ID AS OLD_BUS
FROM Buses
WHERE Bus_Production < '2019-09-20';


-- QUERIES TWO
SELECT Ticket_ID AS BELOW_AVERAGE_TICKET
FROM Bus_Ticket
WHERE Bus_Price <= (SELECT AVG(Bus_Price) FROM Bus_Ticket);


-- QUERIES THREE
SELECT Bus_ID, COUNT(*) AS Total_Buses, AVG(Seat_Cap) AS Average_Seat_Capacity
FROM Buses
GROUP BY Bus_ID
HAVING AVG(Seat_Cap) > (SELECT AVG(Seat_Cap) FROM Buses)
ORDER BY Total_Buses DESC;


-- QUERIES FOUR
SELECT *
FROM Customer
WHERE Customer_ID IN (SELECT Customer_ID FROM Bus_Ticket WHERE Bus_ID = 'B003');

