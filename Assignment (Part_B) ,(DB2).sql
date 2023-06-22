CONNECT TO SAMPLE;

DROP TABLE Customer;
DROP TABLE Buses;
DROP TABLE Bus_Ticket;
DROP TABLE Invoice ;
DROP TABLE Payment_Method ;
DROP TABLE Reservation;
DROP TABLE Route;
DROP TABLE Bus_Operator;


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

CREATE TABLE Reservation (
  Reser_ID VARCHAR(20) NOT NULL,
  Customer_ID VARCHAR(20),
  Bus_ID VARCHAR(20),
  Seat_Num VARCHAR(10),
  Reser_Date_Times DATETIME,
  CONSTRAINT Reser_ID_PK PRIMARY KEY (Reser_ID),
  CONSTRAINT Customer_FK FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
  CONSTRAINT Bus_ID_FK FOREIGN KEY (Bus_ID) REFERENCES Buses(Bus_ID)
);

CREATE TABLE Route (
  Route_ID VARCHAR(20) NOT NULL,
  Bus_ID VARCHAR(20),
  Reser_ID VARCHAR(20),
  Start_Point VARCHAR(20),
  End_Point VARCHAR(20),
  ETA_Start TIME,
  ETA_End TIME,
  CONSTRAINT RouteID_PK PRIMARY KEY (Route_ID),
  CONSTRAINT Bus_ID_FK FOREIGN KEY (Bus_ID) REFERENCES Buses(Bus_ID),
  CONSTRAINT Reser_ID_FK FOREIGN KEY (Reser_ID) REFERENCES Reservation(Reser_ID)
);

CREATE TABLE Bus_Operator (
  Driver_ID VARCHAR(20) NOT NULL,
  Route_ID VARCHAR(20),
  Driver_Name VARCHAR(20),
  Driver_Age VARCHAR(20),
  Driver_Phone VARCHAR(20),
  CONSTRAINT DriverID_PK PRIMARY KEY (Driver_ID),
  CONSTRAINT Route_ID_FK FOREIGN KEY (Route_ID) REFERENCES Route(Route_ID)
);

-- Inserting values into Customer table
INSERT INTO Customer VALUES ('C001','Ali','0123456789', 'ALI@gmail.com');
INSERT INTO Customer VALUES ('C002','Akau','0187654321', 'AKAU@gmail.com');
INSERT INTO Customer VALUES ('C003','Muthu','0156789123', 'MUTHU@gmail.com');
INSERT INTO Customer VALUES ('C004', 'Richard','0121654987','AYAMGORENG@gmail.com');


INSERT INTO Buses VALUES ('B001', 50, '2019-04-06', 'Shuttle bus');
INSERT INTO Buses VALUES ('B002', 50, '2021-06-15', 'Shuttle bus');
INSERT INTO Buses VALUES ('B003', 30, '2013-03-18', 'Express bus');
INSERT INTO Buses VALUES ('B004', 60, '2022-09-20', 'Express bus');


INSERT INTO Bus_Ticket VALUES ('T001', 'B001', 'C001', 5);
INSERT INTO Bus_Ticket VALUES ('T002', 'B002', 'C002', 5);
INSERT INTO Bus_Ticket VALUES ('T003', 'B003', 'C003', 35);
INSERT INTO Bus_Ticket VALUES ('T004', 'B004', 'C004', 40);


INSERT INTO Invoice VALUES ('INV031', 5);
INSERT INTO Invoice VALUES ('INV056', 5);
INSERT INTO Invoice VALUES ('INV023', 15);
INSERT INTO Invoice VALUES ('INV076', 25);


INSERT INTO Payment_Method VALUES ('PAY001', 'CREDIT KAD');
INSERT INTO Payment_Method VALUES ('PAY002', 'E-payment');
INSERT INTO Payment_Method VALUES ('PAY003', 'DEBIT CARD');
INSERT INTO Payment_Method VALUES ('PAY004', 'CREDIT KAD');

----Reser_ID VARCHAR(20) NOT NULL,Customer_ID VARCHAR(20),Bus_ID VARCHAR(20),Seat_Num INTEGER,Reser_Date_Times DATETIME,
INSERT INTO Reservation VALUES ('R100','C001','B001','10','2023-09-20 17:30:00');
INSERT INTO Reservation VALUES ('R101','C002','B002','20','2023-12-25 09:00:00');
INSERT INTO Reservation VALUES ('R102','C003','B003','17','2023-01-15 08:30:00');
INSERT INTO Reservation VALUES ('R103','C004','B004','30','2023-07-30 11:30:00');

---Route_ID VARCHAR(20) NOT NULL,Bus_ID VARCHAR(20),Reser_ID VARCHAR(20),Start_Point VARCHAR(20),End_Point VARCHAR(20),ETA_Start TIME,ETA_End TIME,
INSERT INTO Route VALUES ('RB001','B001','R100','Taman Equine','Sri Serdang','17:30:00','17:50:00');
INSERT INTO Route VALUES ('RB002','B002','R101','Puchong','Subang Jaya','09:00:00','09:20:00');
INSERT INTO Route VALUES ('RB003','B003','R102','Melaka','Kuala Lumpur','08:30:00','10:30:00');
INSERT INTO Route VALUES ('RB004','B004','R103','Penang','Kuala Lumpur','11:30:00','2:50:00');

---Driver_ID VARCHAR(20) NOT NULL,Route_ID VARCHAR(20),Driver_Name VARCHAR(20),Driver_Age VARCHAR(20),Driver_Phone VARCHAR(20),
INSERT INTO Bus_Operator VALUES ('D001','RB001','Johnson','21','0134569810');
INSERT INTO Bus_Operator VALUES ('D002','RB002','Wong Ya Ping','40','0145827891');
INSERT INTO Bus_Operator VALUES ('D003','RB003','Ho Teck Fung','25','0178912378');
INSERT INTO Bus_Operator VALUES ('D004','RB004','Yong En Li','30','0191245789');




SELECT * FROM Customer;


SELECT * FROM Buses;


SELECT * FROM Bus_Ticket;


SELECT * FROM Invoice;


SELECT * FROM Payment_Method;

SELECT * FROM Reservation;

SELECT * FROM Route;

SELECT * FROM Bus_Operator;


-- QUERIES ONE 
SELECT Bus_ID AS OLD_BUS
FROM Buses
WHERE Bus_Production < '2019-09-20';


-- QUERIES TWO
SELECT Ticket_ID AS BELOW_AVERAGE_TICKET
FROM Bus_Ticket
WHERE Bus_Price <= (SELECT AVG(Bus_Price) FROM Bus_Ticket);


-- QUERIES THREE(group by having)
SELECT Bus_ID, COUNT(*) AS Total_Buses, AVG(Seat_Cap) AS Average_Seat_Capacity
FROM Buses
GROUP BY Bus_ID
HAVING AVG(Seat_Cap) > (SELECT AVG(Seat_Cap) FROM Buses)
ORDER BY Total_Buses DESC;


-- QUERIES FOUR(subqueries)
SELECT *
FROM Customer
WHERE Customer_ID IN (SELECT Customer_ID FROM Bus_Ticket WHERE Bus_ID = 'B003');

