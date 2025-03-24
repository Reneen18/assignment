

-- Create the Venue table
CREATE TABLE Venue (
    venue_id INT IDENTITY(1,1) PRIMARY KEY,
    venue_name VARCHAR(255) NOT NULL,
    address TEXT NOT NULL
);
GO

-- Create the Event table
CREATE TABLE Event (
    event_id INT IDENTITY(1,1) PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    venue_id INT FOREIGN KEY REFERENCES Venue(venue_id),
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL,
    event_type VARCHAR(20) CHECK (event_type IN ('Movie', 'Sports', 'Concert'))
);
GO

-- Create the Customer table
CREATE TABLE Customer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL
);
GO

-- Create the Booking table
CREATE TABLE Booking (
    booking_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customer(customer_id),
    event_id INT FOREIGN KEY REFERENCES Event(event_id),
    num_tickets INT NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    booking_date DATE NOT NULL
);
GO

-- Insert sample data
INSERT INTO Venue (venue_name, address) VALUES
('Grand Arena', '123 Main St'),
('Stadium X', '456 Broad St'),
('Concert Hall', '789 Music Rd'),
('Theater Y', '101 Drama Ln'),
('Open Air Park', '202 Sunset Blvd');
GO

INSERT INTO Event (event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type) VALUES
('Rock Night', '2025-05-10', '19:00:00', 3, 5000, 3000, 1500.00, 'Concert'),
('Football Cup', '2025-06-20', '18:30:00', 2, 20000, 15000, 2500.00, 'Sports'),
('Drama Play', '2025-07-15', '20:00:00', 4, 1000, 700, 1200.00, 'Movie'),
('Jazz Evening', '2025-08-05', '21:00:00', 3, 3000, 2500, 1800.00, 'Concert'),
('Movie Premiere', '2025-09-10', '17:00:00', 1, 1500, 1400, 900.00, 'Movie');
GO

INSERT INTO Customer (customer_name, email, phone_number) VALUES
('Alice Johnson', 'alice@example.com', '123450000'),
('Bob Smith', 'bob@example.com', '987650000'),
('Charlie Brown', 'charlie@example.com', '543210000'),
('David Lee', 'david@example.com', '112233000'),
('Eve Adams', 'eve@example.com', '998877000');
GO

INSERT INTO Booking (customer_id, event_id, num_tickets, total_cost, booking_date) VALUES
(1, 1, 5, 7500.00, '2025-05-01'),
(2, 2, 3, 7500.00, '2025-06-05'),
(3, 3, 6, 7200.00, '2025-07-10'),
(4, 4, 2, 3600.00, '2025-08-01'),
(5, 5, 1, 900.00, '2025-09-01');
GO

-- Queries
SELECT * FROM Event;
GO

SELECT * FROM Event WHERE available_seats > 0;
GO

SELECT * FROM Event WHERE event_name LIKE '%cup%';
GO

SELECT * FROM Event WHERE ticket_price BETWEEN 1000 AND 2500;
GO

SELECT * FROM Event WHERE event_date BETWEEN '2025-06-01' AND '2025-07-31';
GO

SELECT * FROM Event WHERE available_seats > 0 AND event_name LIKE '%Concert%';
GO

SELECT * FROM Customer ORDER BY customer_id OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;
GO

SELECT * FROM Booking WHERE num_tickets > 4;
GO

SELECT * FROM Customer WHERE phone_number LIKE '%000';
GO

SELECT * FROM Event WHERE total_seats > 15000 ORDER BY total_seats DESC;
GO

SELECT * FROM Event WHERE event_name NOT LIKE 'x%' AND event_name NOT LIKE 'y%' AND event_name NOT LIKE 'z%';
GO

-- Aggregate Functions and Joins
SELECT event_name, AVG(ticket_price) AS avg_ticket_price FROM Event GROUP BY event_name;
GO

SELECT SUM(total_cost) AS total_revenue FROM Booking;
GO

SELECT TOP 1 e.event_id, e.event_name, SUM(b.num_tickets) AS total_tickets_sold 
FROM Booking b 
JOIN Event e ON b.event_id = e.event_id 
GROUP BY e.event_id, e.event_name 
ORDER BY total_tickets_sold DESC;
GO

SELECT e.event_name, SUM(b.num_tickets) AS total_tickets_sold 
FROM Booking b 
JOIN Event e ON b.event_id = e.event_id 
GROUP BY e.event_name;
GO

SELECT event_name FROM Event WHERE event_id NOT IN (SELECT DISTINCT event_id FROM Booking);
GO

SELECT TOP 1 c.customer_name, SUM(b.num_tickets) AS total_tickets 
FROM Booking b 
JOIN Customer c ON b.customer_id = c.customer_id 
GROUP BY c.customer_name 
ORDER BY total_tickets DESC;
GO

SELECT MONTH(booking_date) AS booking_month, e.event_name, SUM(b.num_tickets) AS total_tickets_sold 
FROM Booking b 
JOIN Event e ON b.event_id = e.event_id 
GROUP BY MONTH(booking_date), e.event_name 
ORDER BY booking_month;
GO

SELECT v.venue_name, AVG(e.ticket_price) AS avg_ticket_price 
FROM Event e 
JOIN Venue v ON e.venue_id = v.venue_id 
GROUP BY v.venue_name;
GO

SELECT e.event_type, SUM(b.num_tickets) AS total_tickets_sold 
FROM Booking b 
JOIN Event e ON b.event_id = e.event_id 
GROUP BY e.event_type;
GO

SELECT YEAR(booking_date) AS booking_year, SUM(total_cost) AS total_revenue 
FROM Booking 
GROUP BY YEAR(booking_date);
GO

SELECT c.customer_name FROM Customer c WHERE NOT EXISTS (SELECT 1 FROM Booking b WHERE b.customer_id = c.customer_id);
GO

SELECT event_name FROM Event WHERE event_id NOT IN (SELECT DISTINCT event_id FROM Booking);
GO

SELECT event_type, SUM(num_tickets) AS total_tickets_sold 
FROM Event e 
JOIN Booking b ON b.event_id = e.event_id 
GROUP BY event_type;
GO

SELECT event_name, ticket_price FROM Event WHERE ticket_price > (SELECT AVG(ticket_price) FROM Event);
GO

SELECT c.customer_name, SUM(b.total_cost) AS total_revenue 
FROM Booking b 
JOIN Customer c ON b.customer_id = c.customer_id 
GROUP BY c.customer_name;
GO

SELECT DISTINCT c.customer_name 
FROM Customer c 
WHERE c.customer_id IN (
    SELECT DISTINCT b.customer_id 
    FROM Booking b 
    JOIN Event e ON b.event_id = e.event_id 
    WHERE e.venue_id = (SELECT venue_id FROM Venue WHERE venue_name = 'Grand Arena')
);
GO

SELECT venue_name, 
       (SELECT AVG(ticket_price) FROM Event WHERE Event.venue_id = Venue.venue_id) AS avg_ticket_price 
FROM Venue;
GO
