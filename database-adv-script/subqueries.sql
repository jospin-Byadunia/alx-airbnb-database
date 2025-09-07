SELECT * FROM Property WHERE property_id IN (SELECT property_id  FROM Review WHERE rating > 4);

SELECT u.user_id, u.first_name, u.last_name, u.email
FROM User u
WHERE (
    SELECT COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.user_id
) > 3;