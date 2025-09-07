# Query Optimization Report

## 1. Original Query

The original query retrieves all bookings along with user details, property details, and payment details:

```sql
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pm.method_name AS payment_method
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
LEFT JOIN PaymentMethod pm ON pay.method_id = pm.method_id
ORDER BY b.created_at DESC;
```

### Observed Issues

- **Sequential Scans** on `Booking`, `Payment`, and `Property` tables for large datasets.
- **Nested Loop Joins** could become expensive with increasing table size.
- `ORDER BY b.created_at DESC` may trigger a **full table sort** if `created_at` is not indexed.
- Multiple `LEFT JOIN`s with potentially many payment records per booking can **duplicate rows** unnecessarily.

---

## 2. Optimization Strategies

1. **Add Indexes** to high-usage columns:

```sql
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_created_at ON Booking(created_at);
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);
CREATE INDEX idx_payment_method_id ON Payment(method_id);
```

2. **Reduce unnecessary joins**:

   - Only join tables whose data is required.
   - Payments are `LEFT JOIN` because some bookings may have no payments.

3. **Aggregate payments** before joining (if multiple payments per booking) using a CTE:

```sql
WITH payment_summary AS (
    SELECT booking_id, SUM(amount) AS total_payment, MAX(payment_date) AS last_payment_date
    FROM Payment
    GROUP BY booking_id
)
```

4. **Order by indexed columns** to avoid full-table sorts:

```sql
ORDER BY b.created_at DESC;
```

---
