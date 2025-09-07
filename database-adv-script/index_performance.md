# High-usage columns

The most used columns in

1. User:
   user_id (PK, UUID, Indexed)
   email (UNIQUE, NOT NULL)
   role (ENUM)

2. Bookings:
   booking_id (PK, UUID, Indexed)
   property_id (FK to Property.property_id)
   user_id (FK to User.user_id)
   start_date (DATE)
   end_date (DATE)
   status (ENUM)
   created_at (TIMESTAMP)

3. Property

   property_id (PK, UUID, Indexed)
   host_id (FK to User.user_id)
   location (VARCHAR)
   price_per_night (DECIMAL)
   created_at (TIMESTAMP)
