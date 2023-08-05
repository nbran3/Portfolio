CREATE TABLE Customers(CustomerID INT NOT NULL PRIMARY KEY, FullName VARCHAR(100) NOT NULL, PhoneNumber INT NOT NULL UNIQUE);

INSERT INTO Customers (CustomerID, FullName, PhoneNumber) VALUES 
(1, 'Vanessa McCarthy', '0757536378'), 
(2, 'Marcos Romero', '0757536379'), 
(3, 'Hiroki Yamane', '0757536376'), 
(4, 'Anna Iversen', '0757536375'), 
(5, 'Diana Pinto', '0757536374'),     
(6, 'Altay Ayhan', '0757636378'),      
(7, 'Jane Murphy', '0753536379'),      
(8, 'Laurina Delgado', '0754536376'),      
(9, 'Mike Edwards', '0757236375'),     
(10, 'Karl Pederson', '0757936374');

CREATE TABLE Bookings (BookingID INT, BookingDate DATE,TableNumber INT, NumberOfGuests INT,CustomerID INT); 

INSERT INTO Bookings 
(BookingID, BookingDate, TableNumber, NumberOfGuests, CustomerID) 
VALUES 
(10, '2021-11-10', 7, 5, 1),  
(11, '2021-11-10', 5, 2, 2),  
(12, '2021-11-10', 3, 2, 4), 
(13, '2021-11-11', 2, 5, 5),  
(14, '2021-11-11', 5, 2, 6),  
(15, '2021-11-11', 3, 2, 7), 
(16, '2021-11-11', 3, 5, 1),  
(17, '2021-11-12', 5, 2, 2),  
(18, '2021-11-12', 3, 2, 4), 
(19, '2021-11-13', 7, 5, 6),  
(20, '2021-11-14', 5, 2, 3),  
(21, '2021-11-14', 3, 2, 4);

CREATE TABLE Courses (CourseName VARCHAR(255) PRIMARY KEY, Cost Decimal(4,2));

INSERT INTO Courses (CourseName, Cost) VALUES 
('Greek salad', 15.50), 
('Bean soup', 12.25), 
('Pizza', 15.00), 
('Carbonara', 12.50), 
('Kabasa', 17.00), 
('Shwarma', 11.30);

--- Creating Table with Constraints
CREATE TABLE DeliveryAddress (ID INT PRIMARY KEY, AddressofDelivery VARCHAR(255) NOT NULL, TypeofDelivery VARCHAR(255) NOT NULL DEFAULT 'Private', CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customers(CustomerID))

-- Altering Table Structure (Adding Columns)
ALTER TABLE Courses ADD Ingredients VARCHAR(255)

--- Filter data using the WHERE clause and logical operators
SELECT *
FROM Bookings
WHERE BookingDate Between '2021-11-11' AND '2021-11-13'

--- Group by query
SELECT BookingDate, Count(BookingDate) as CountofBookingDate
FROM Bookings
GROUP By BookingDate

--- JOIN query
SELECT Customers.FullName, BookingID
FROM Customers
RIGHT Join Bookings
on Customers.CustomerID = Bookings.CustomerID
WHERE BookingDate = '2021-11-11'

-- REPLACE Statement 
REPLACE INTO Courses (CourseName, Cost) VALUES ("Kabasa", 20.00)

--Subquery 
SELECT FullName
FROM Customers 
WHERE Fullname IN (SELECT BookingDate 
FROM Customers
INNER JOIN Bookings
on Customers.CustomerID = Bookings.CustomerID
WHERE BookingDate = '2021-11-11')

--- Creating Views
CREATE VIEW BookingsView As
SELECT BookingDate, BookingID, NumberOfGuests
FROM Bookings
WHERE BookingDate < '2021-11-13'

-- Creating Stored Procedure 
CREATE PROCEDURE GetBookingsData
    @InputDate DATE
AS
BEGIN
    SELECT *
    FROM Bookings
    WHERE BookingsDate = @InputDate;
END;

EXEC GetBookingsData '2021-11-13';


--String Function Example 
SELECT CONCAT("ID: ", BookingID,', Date: ', BookingDate,', Number of guests: ', NumberOfGuests) AS "Booking Details" 
FROM Bookings;
