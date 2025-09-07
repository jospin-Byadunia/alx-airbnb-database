SELECT * FROM Booking INNER JOIN User ON Booking.user_id=User.user_id 

SELECT * FROM Booking LEFT JOIN User ON Booking.user_id=User.user_id

SELECT * FROM Booking FULL OUTER JOIN User ON Booking.user_id=User.user_id