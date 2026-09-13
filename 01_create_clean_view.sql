-- 01_create_clean_view.sql
-- Purpose: Build a cleaned, analysis-ready view on top of orders_raw
-- We don't modify orders_raw — this view is what we query from now on.

DROP VIEW IF EXISTS orders_clean;

CREATE VIEW orders_clean AS
SELECT
    "Row ID"            AS row_id,
    "Order ID"           AS order_id,
    -- Convert 'M/D/YYYY' text into a proper SQLite date (YYYY-MM-DD)
    date(
        substr("Order Date", instr("Order Date", '/') + instr(substr("Order Date", instr("Order Date", '/') + 1), '/') + 1) || '-' ||
        substr('00' || substr("Order Date", 1, instr("Order Date", '/') - 1), -2) || '-' ||
        substr('00' || substr(substr("Order Date", instr("Order Date", '/') + 1), 1, instr(substr("Order Date", instr("Order Date", '/') + 1), '/') - 1), -2)
    ) AS order_date,
    "Ship Mode"          AS ship_mode,
    "Customer ID"        AS customer_id,
    "Customer Name"      AS customer_name,
    "Segment"            AS segment,
    "City"               AS city,
    "State"              AS state,
    "Region"             AS region,
    "Category"           AS category,
    "Sub-Category"       AS sub_category,
    "Product Name"       AS product_name,
    "Sales"              AS sales,
    "Quantity"           AS quantity,
    "Discount"           AS discount,
    "Profit"             AS profit,
    ROUND("Profit" * 1.0 / NULLIF("Sales", 0), 4) AS profit_margin
FROM orders_raw;
