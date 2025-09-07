SELECT *, COUNT(Booking.booking_id) AS total_bookings 
FROM User LEFT JOIN Booking ON User.user_id=Booking.user_id 
GROUP BY User.user_id ORDER BY total_bookings DESC;


SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_row_number
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY total_bookings DESC;
