--create indexes on Identify high-usage columns in your User, Booking, and Property tables (e.g., columns used in WHERE, JOIN, ORDER BY clauses).
-- Index for quick lookup by email (used in login/authentication)
CREATE UNIQUE INDEX idx_user_email ON User(email);

-- Index for role-based queries
CREATE INDEX idx_user_role ON User(role);

-- Index for host_id (frequent JOINs / filtering)
CREATE INDEX idx_property_host_id ON Property(host_id);

-- Index for location (search by city/area)
CREATE INDEX idx_property_location ON Property(location);

-- Index for price filtering / sorting
CREATE INDEX idx_property_price ON Property(price_per_night);

-- Optional composite index (location + price) for combined searches
CREATE INDEX idx_property_location_price ON Property(location, price_per_night);

-- Index for created_at (latest properties)
CREATE INDEX idx_property_created_at ON Property(created_at);

-- Index for user_id (user booking history lookups)
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index for property_id (property availability, joins)
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index for status (filtering by booking state)
CREATE INDEX idx_booking_status ON Booking(status);

-- Composite index for availability checks (property + dates)
CREATE INDEX idx_booking_property_dates ON Booking(property_id, start_date, end_date);

-- Index for created_at (recent bookings)
CREATE INDEX idx_booking_created_at ON Booking(created_at);



EXPLAIN ANALYZE
SELECT * FROM User WHERE email = 'alice@example.com';
EXPLAIN ANALYZE
SELECT * FROM Property WHERE location = 'New York' AND price_per_night < 150.00 ORDER BY price_per_night;
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE user_id = 'some-user-uuid' ORDER BY created_at DESC;
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE property_id = 'some-property-uuid' AND start_date >= '2023-10-01' AND end_date <= '2023-10-15';
-- Use EXPLAIN ANALYZE to verify that the queries utilize the indexes effectively.
-- Adjust indexes based on query performance and usage patterns over time.