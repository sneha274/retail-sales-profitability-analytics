# Retail Sales & Profitability Analytics

End-to-end analysis of the Superstore retail dataset (~10,000 orders) to identify where the business is losing money and why — using Excel, SQL, Power BI, and Python together.

## Tools used
- **Excel** — initial data exploration via PivotTables
- **SQL (SQLite)** — data cleaning and core business-question queries
- **Power BI** — interactive dashboard (profit by sub-category, discount vs. profit, KPIs)
- **Python (pandas, scipy)** — statistical correlation testing and RFM customer segmentation

## Key findings

1. **Discounting above 20% is a hard cutoff, not a gradual decline.** Orders with ≤20% discount are almost always profitable (only 14% lose money). Cross 21%+ and 90–100% of orders lose money.
2. **Furniture's weak profit is driven by two sub-categories, not the whole category.** Tables (-$17.7K) and Bookcases (-$3.5K) both carry high average discounts (26% and 21%); Chairs and Furnishings are healthy.
3. **Office Supplies "Supplies" losses are a pricing problem, not a discounting problem.** A handful of specific products (mainly electric letter openers) are unprofitable at low discount rates — the root cause is cost/pricing, not discount policy.
4. **The discount effect is a threshold, confirmed statistically.** Raw correlation is weak (-0.22) because the relationship isn't linear — it's a step function at the 20% mark.
5. **Revenue is concentrated in a small customer segment.** RFM segmentation shows the top 24% of customers ("Champions") generate 40% of total revenue.

## Recommendations
- Require approval for discounts above 20%, rather than a blanket discount reduction.
- Apply a tighter discount ceiling specifically to Tables and Bookcases.
- Review sourcing/pricing on specific loss-making Office Supplies SKUs.
- Prioritize retention spend on the "Champions" customer segment.

## Project structure
```
data/           raw and cleaned datasets
sql/            data cleaning view + analysis queries
python/         statistical testing + RFM segmentation script
insights.md     full write-up of all 5 findings
retail_dashboard.pbix   Power BI dashboard
```

## Dashboard preview
*(add a screenshot of your Power BI dashboard here — see instructions below)*

## Dataset
[Superstore Dataset (Kaggle)](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)
