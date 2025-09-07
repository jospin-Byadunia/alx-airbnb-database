-- Step 1: Create a new partitioned Booking table
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);
-- Step 2: Create partitions for each year
CREATE TABLE Booking_2022 PARTITION OF Booking
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');
CREATE TABLE Booking_2023 PARTITION OF Booking
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');
CREATE TABLE Booking_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
-- Step 3: Create indexes on partitions for performance
CREATE INDEX idx_booking_2022_property ON Booking_2022 (property_id);
CREATE INDEX idx_booking_2022_user_id ON Booking_2025(user_id);
CREATE INDEX idx_booking_2023_property ON Booking_2023 (property_id);
CREATE INDEX idx_booking_2024_property ON Booking_2024 (property_id);


EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.first_name,
    u.last_name,
    p.name AS property_name
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
WHERE b.start_date >= '2023-09-01'
  AND b.start_date < '2023-10-01'
ORDER BY b.start_date ASC;

EXPLAIN ANALYZE
SELECT *
FROM Booking
WHERE start_date >= '2024-01-01'
  AND start_date < '2025-01-01';
