# Retail Sales & Profitability — Insights (Draft)

## Insight 1: Discounting is destroying profit above 20%
- At 0% discount, 100% of orders are profitable.
- At 21%+ discount, 90-100% of orders lose money.
- Recommendation: cap discounts at 20% across the board, or require manager approval above that threshold.

## Insight 2: Furniture's weak profit is driven by Tables and Bookcases, not the whole category
- Furniture overall profit: $18,451 (far below Office Supplies $122K and Technology $145K)
- Tables: -$17,725 profit at 26.1% avg discount (biggest loss in the dataset)
- Bookcases: -$3,472 profit at 21.1% avg discount
- Chairs and Furnishings are healthy (17% and 14% avg discount, both profitable)
- Recommendation: reduce discount ceiling specifically for Tables and Bookcases.

## Insight 3: Office Supplies "Supplies" losses are NOT a discounting problem
- Supplies sub-category loses -$1,189 overall, but at only a 7.6% avg discount (low).
- Root cause: a small number of specific products — mainly electric letter openers —
  are structurally unprofitable (cost > price) regardless of discount.
  "Martin Yale Chadless Opener Electric Letter Opener" alone lost $1,299.
- Recommendation: review pricing/sourcing cost on these specific SKUs rather than touching discount policy.

## Insight 4: The discount effect is a threshold, not a gradual decline (Python statistical analysis)
- Raw correlation between discount and profit across all 9,994 orders: -0.219 (weak, but statistically significant, p < 0.001)
- However, order-level breakdown reveals a THRESHOLD, not a straight-line relationship:
  - 0% discount: 0% of orders unprofitable
  - 1-20% discount: 13.75% of orders unprofitable
  - 21%+ discount: 90-100% of orders unprofitable
- Recommendation: implement an approval requirement specifically at the 20% discount mark,
  rather than a general "reduce all discounts" policy — discounts below 20% barely matter.

## Insight 5: Customer value is concentrated (RFM segmentation)
- Segmented all customers by Recency, Frequency, and Monetary value (RFM analysis)
- "Champions" segment: 24.3% of customers generate 40.1% of total revenue
- "At Risk" segment: 24.7% of customers generate only 8.2% of revenue
- Recommendation: prioritize retention spend (loyalty programs, personalized outreach)
  on the Champions segment; do not over-invest in retaining low-value At Risk customers.

## Next to confirm
- Region and Segment profitability patterns (not yet investigated)
