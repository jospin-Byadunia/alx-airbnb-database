# 📊 Sample Data for Booking Platform Database

This file contains **sample SQL INSERT statements** to populate the booking platform database with realistic test data.  
It demonstrates how users, properties, bookings, payments, reviews, and messages interact in a real-world scenario.

---

## 👤 Users

Four users are created:

- **Alice (Host)** → lists properties for rent.
- **Bob (Guest)** → books a property and leaves a review.
- **Charlie (Guest)** → makes a pending booking.
- **Diana (Admin)** → manages the system.

---

## 🏠 Properties

Alice, the host, lists two properties:

1. **Lakeview Apartment** → A modern 2-bedroom apartment with a lake view.
2. **City Center Studio** → A cozy studio near shops in Bukavu.

---

## 📅 Bookings

- **Bob** books the _Lakeview Apartment_ (status: **confirmed**).
- **Charlie** books the _City Center Studio_ (status: **pending**).

---

## 💳 Payments

- Payment methods available: **credit card, PayPal, Stripe**.
- Bob pays **$250.00** for his confirmed booking using **credit card**.

---

## ⭐ Reviews

- Bob leaves a **5-star review** for _Lakeview Apartment_:

  > “Amazing stay! Beautiful view and very comfortable apartment.”

---

## 💬 Messages

- Bob sends a message to Alice after booking.
- Alice replies to confirm and welcome him.

---

## ✅ Purpose

This sample dataset is designed to:

- Demonstrate database relationships (Users ↔ Properties ↔ Bookings ↔ Payments).
- Provide realistic test cases for queries (e.g., joining bookings, payments, and reviews).
- Simulate real-world platform activity for development and testing.

---

## ⚡ Usage

To load this data into your PostgreSQL database, run:

```sql
\i sample_data.sql
```
