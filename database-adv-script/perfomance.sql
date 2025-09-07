SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.total_price,

    -- User details
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,

    -- Property details
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,

    -- Payment details
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pm.method_name AS payment_method

FROM Booking b
JOIN "User" u 
    ON b.user_id = u.user_id
JOIN Property p 
    ON b.property_id = p.property_id
LEFT JOIN Payment pay 
    ON b.booking_id = pay.booking_id
LEFT JOIN PaymentMethod pm
    ON pay.method_id = pm.method_id
ORDER BY b.created_at DESC;
-- This query retrieves comprehensive booking information, including user details, property details, and payment information.
-- It uses INNER JOINs to ensure only bookings with valid users and properties are included, and LEFT JOINs for payments to include bookings without payments.
-- The results are ordered by the booking creation date in descending order.

-- Use EXPLAIN ANALYZE to check the performance of this query and ensure indexes are being utilized effectively.
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.total_price,

    -- User details
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,

    -- Property details
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,

    -- Payment details
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pm.method_name AS payment_method
FROM Booking b
JOIN "User" u   
    ON b.user_id = u.user_id
JOIN Property p   
    ON b.property_id = p.property_id
LEFT JOIN Payment pay   
    ON b.booking_id = pay.booking_id
LEFT JOIN PaymentMethod pm  
    ON pay.method_id = pm.method_id
ORDER BY b.created_at DESC;
-- Analyze the output of EXPLAIN ANALYZE to identify any potential bottlenecks or areas for improvement.
-- Measure performance of retrieving a specific user's bookings
EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date, b.status, b.total_price
FROM Booking b
WHERE b.user_id = 'some-user-uuid'
ORDER BY b.created_at DESC;

-- Measure performance of retrieving bookings for a specific property in a date range
EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date, b.status, b.total_price
FROM Booking b
WHERE b.property_id = 'some-property-uuid'
  AND b.start_date <= '2025-09-10'
  AND b.end_date >= '2025-09-05'
ORDER BY b.start_date ASC;

-- Measure performance of retrieving high-value bookings
EXPLAIN ANALYZE
SELECT b.booking_id, b.total_price, u.first_name, u.last_name
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
WHERE b.total_price > 200
ORDER BY b.total_price DESC;

--creating indexes to optimize the query performanceCREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_created_at ON Booking(created_at);
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);
CREATE INDEX idx_payment_method_id ON Payment(method_id);
CREATE INDEX idx_user_user_id ON "User"(user_id);
CREATE INDEX idx_property_property_id ON Property(property_id);
-- Refactoring the query for better readability and maintainability
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.total_price,

    -- User details
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,

    -- Property details
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,

    -- Payment details (optional)
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pm.method_name AS payment_method

FROM Booking b

-- Only join required tables
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id

-- Use LEFT JOIN for optional payments
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
LEFT JOIN PaymentMethod pm ON pay.method_id = pm.method_id

-- Use an index-friendly ORDER BY
ORDER BY b.created_at DESC;
-- This refactored query maintains the same functionality while improving clarity.