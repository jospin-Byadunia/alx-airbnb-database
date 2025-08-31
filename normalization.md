# Database Normalization Report (Up to 3NF)

## Step 1: First Normal Form (1NF)

- **Requirement:** Eliminate repeating groups and ensure all attributes are atomic.
- **Analysis:**
  - All entities (`User`, `Property`, `Booking`, `Payment`, `Review`, `Message`) contain atomic values.
  - No repeating attributes (e.g., multiple phone numbers stored in one field).

✅ The database is in **1NF**.

---

## Step 2: Second Normal Form (2NF)

- **Requirement:** Eliminate partial dependencies (attributes depending only on part of a composite key).
- **Analysis:**
  - All primary keys are **single-column UUIDs**, so partial dependency is not possible.

✅ The database is in **2NF**.

---

## Step 3: Third Normal Form (3NF)

- **Requirement:** Eliminate transitive dependencies (non-key attributes depending on other non-key attributes).
- **Analysis:**
  - **Property**:
    - `location` is stored as a single string. This may limit queries.
    - **Fix (optional):** Split into `country`, `city`, `address` if structured queries are needed.
  - **Booking**:
    - `total_price` can be derived (`price_per_night * nights`). Storing it violates 3NF.
    - **Fix:** Remove it (or keep as denormalized column for performance).
  - **Payment**:
    - `payment_method` stored as ENUM.
    - **Fix:** Move to **PaymentMethod** lookup table for flexibility.
  - **Review**:
    - Each `(user_id, property_id)` pair should be unique to prevent multiple reviews.
    - **Fix:** Add a unique constraint.

✅ With these fixes, the schema achieves **3NF**.

---

## Final Normalized Schema (3NF)

### **User**

- user_id (PK)
- first_name
- last_name
- email (UNIQUE)
- password_hash
- phone_number
- role_id
- created_at

### **Role**

- role_id (PK)

### **Property**

- property_id (PK)
- host_id (FK → User.user_id)
- name
- description
- location (or country, city, address if decomposed)
- price_per_night
- created_at
- updated_at

### **Booking**

- booking_id (PK)
- property_id (FK → Property.property_id)
- user_id (FK → User.user_id)
- start_date
- end_date
- status (ENUM: pending, confirmed, canceled)
- created_at

### **Payment**

- payment_id (PK)
- booking_id (FK → Booking.booking_id)
- amount
- payment_date
- method_id (FK → PaymentMethod.method_id)

### **PaymentMethod**

- method_id (PK)
- method_name (credit_card, paypal, stripe)

### **Review**

- review_id (PK)
- property_id (FK → Property.property_id)
- user_id (FK → User.user_id)
- rating (1–5)
- comment
- created_at
- **UNIQUE(user_id, property_id)**

### **Message**

- message_id (PK)
- sender_id (FK → User.user_id)
- recipient_id (FK → User.user_id)
- message_body
- sent_at

---

---

## Summary

- The original schema was close to 3NF.
- **Redundancies / violations fixed:**
  1. Removed transitive dependencies by introducing **PaymentMethod** tables.
  2. Addressed potential redundancy by removing `total_price` from `Booking`.
  3. Added uniqueness constraint to `Review`.
  4. (Optional) Decomposed `location` into structured fields.

✅ Final schema is in **3NF**.
