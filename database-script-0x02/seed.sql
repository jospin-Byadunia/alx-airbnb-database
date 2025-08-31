-- =====================
-- USERS
-- =====================
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (gen_random_uuid(), 'Alice', 'Smith', 'alice@example.com', 'hashed_pw1', '+243970000001', 'host'),
    (gen_random_uuid(), 'Bob', 'Johnson', 'bob@example.com', 'hashed_pw2', '+243970000002', 'guest'),
    (gen_random_uuid(), 'Charlie', 'Brown', 'charlie@example.com', 'hashed_pw3', '+243970000003', 'guest'),
    (gen_random_uuid(), 'Diana', 'Kane', 'diana@example.com', 'hashed_pw4', '+243970000004', 'admin');

-- =====================
-- PROPERTIES
-- Alice is a host
-- =====================
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night)
VALUES
    (gen_random_uuid(), (SELECT user_id FROM "User" WHERE email = 'alice@example.com'),
     'Lakeview Apartment', 'Modern 2-bedroom apartment with lake view.', 'Bukavu, DRC', 50.00),
    (gen_random_uuid(), (SELECT user_id FROM "User" WHERE email = 'alice@example.com'),
     'City Center Studio', 'Cozy studio in the city center, close to shops.', 'Bukavu, DRC', 35.00);

-- =====================
-- BOOKINGS
-- Bob books the Lakeview Apartment
-- Charlie books the Studio
-- =====================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, status)
VALUES
    (gen_random_uuid(),
     (SELECT property_id FROM Property WHERE name = 'Lakeview Apartment'),
     (SELECT user_id FROM "User" WHERE email = 'bob@example.com'),
     '2025-09-05', '2025-09-10', 'confirmed'),

    (gen_random_uuid(),
     (SELECT property_id FROM Property WHERE name = 'City Center Studio'),
     (SELECT user_id FROM "User" WHERE email = 'charlie@example.com'),
     '2025-09-12', '2025-09-14', 'pending');

-- =====================
-- PAYMENT METHODS
-- =====================
INSERT INTO PaymentMethod (method_name)
VALUES ('credit_card'), ('paypal'), ('stripe');

-- =====================
-- PAYMENTS
-- Bob paid for his booking
-- =====================
INSERT INTO Payment (payment_id, booking_id, amount, method_id)
VALUES
    (gen_random_uuid(),
     (SELECT booking_id FROM Booking b
        JOIN Property p ON b.property_id = p.property_id
       WHERE p.name = 'Lakeview Apartment' AND b.status = 'confirmed'),
     250.00,
     (SELECT method_id FROM PaymentMethod WHERE method_name = 'credit_card'));

-- =====================
-- REVIEWS
-- Bob leaves a review for Lakeview Apartment
-- =====================
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
    (gen_random_uuid(),
     (SELECT property_id FROM Property WHERE name = 'Lakeview Apartment'),
     (SELECT user_id FROM "User" WHERE email = 'bob@example.com'),
     5,
     'Amazing stay! Beautiful view and very comfortable apartment.');

-- =====================
-- MESSAGES
-- Bob sends a message to Alice (host)
-- Alice replies
-- =====================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
    (gen_random_uuid(),
     (SELECT user_id FROM "User" WHERE email = 'bob@example.com'),
     (SELECT user_id FROM "User" WHERE email = 'alice@example.com'),
     'Hi Alice, I just booked your apartment. Looking forward to my stay!'),

    (gen_random_uuid(),
     (SELECT user_id FROM "User" WHERE email = 'alice@example.com'),
     (SELECT user_id FROM "User" WHERE email = 'bob@example.com'),
     'Hi Bob, thank you for booking! I’ll be waiting to welcome you on the 5th.');
