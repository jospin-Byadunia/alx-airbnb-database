# Partitioning Performance Report

## 1. Objective

The goal of partitioning the `Booking` table by `start_date` was to improve query performance for operations that filter by date ranges. This report summarizes the improvements observed after implementing range partitioning.

---

## 2. Testing Queries

1. **Fetch bookings for a specific date range**

```sql
SELECT b.booking_id, b.start_date, b.end_date, b.total_price
FROM Booking b
WHERE b.start_date >= '2025-09-01' AND b.start_date < '2025-10-01';
```

2. **Fetch all bookings in a specific year**

```sql
SELECT * FROM Booking
WHERE start_date >= '2025-01-01' AND start_date < '2026-01-01';
```

3. **Fetch bookings for a specific property in a date range**

```sql
SELECT * FROM Booking
WHERE property_id = 'some-property-uuid'
  AND start_date >= '2025-01-01'
  AND start_date < '2026-01-01';
```

---

## 3. Observed Improvements

| Metric         | Before Partitioning          | After Partitioning                           |
| -------------- | ---------------------------- | -------------------------------------------- |
| Rows Scanned   | Entire Booking table         | Only relevant partition(s)                   |
| Execution Time | High on large datasets       | Significantly reduced for date-range queries |
| Scan Type      | Seq Scan or Nested Loop      | Partition Range Scan with Index Scan         |
| Sorting        | Full table sort for ORDER BY | Index-assisted sort on partitioned subset    |

**Key Observations:**

- Queries with `start_date` filters only scanned relevant partitions, reducing I/O and execution time.
- Indexes on partitions improved joins and lookups for `user_id` and `property_id`.
- Large-scale maintenance tasks (like archiving old bookings) are easier by dropping old partitions.
- Queries without `start_date` filters still scan all partitions, so filtering by partition key is crucial for best performance.

---

## 4. Recommendations

1. Continue using `start_date` filters for queries to benefit from partition pruning.
2. Create indexes on frequently joined columns (`user_id`, `property_id`) in each partition.
3. Periodically create new partitions for upcoming years and drop or archive old partitions.
4. Monitor query performance with `EXPLAIN ANALYZE` to ensure partitioning continues to provide benefits.

---

**Conclusion:**

Partitioning the `Booking` table by `start_date` significantly improved query performance for date-range queries, reduced scanned rows, and optimized sorting operations, making the system more efficient for large datasets.
