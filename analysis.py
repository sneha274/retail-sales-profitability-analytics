"""
Retail Sales & Profitability Analytics - Python Deep-Dive
Adds statistical rigor (correlation testing) and customer segmentation (RFM)
that complement the Excel/SQL/Power BI work.
"""
import sqlite3
import pandas as pd
from scipy import stats

conn = sqlite3.connect('superstore.db')
df = pd.read_sql('SELECT * FROM orders_clean', conn)
conn.close()

# --- 1. Discount vs Profit correlation ---
corr, p_value = stats.pearsonr(df['discount'], df['profit'])
print(f'Correlation: {corr:.3f} (p={p_value:.2e})')
# Weak linear correlation overall, but a strong THRESHOLD effect above 20% discount
# (see discount_bucket breakdown - orders >20% discount are 90-100% unprofitable)

# --- 2. RFM Customer Segmentation ---
df['order_date'] = pd.to_datetime(df['order_date'])
snapshot_date = df['order_date'].max() + pd.Timedelta(days=1)

rfm = df.groupby('customer_id').agg(
    customer_name=('customer_name', 'first'),
    recency=('order_date', lambda x: (snapshot_date - x.max()).days),
    frequency=('order_id', 'nunique'),
    monetary=('sales', 'sum')
).reset_index()

rfm['r_score'] = pd.qcut(rfm['recency'], 4, labels=[4, 3, 2, 1]).astype(int)
rfm['f_score'] = pd.qcut(rfm['frequency'].rank(method='first'), 4, labels=[1, 2, 3, 4]).astype(int)
rfm['m_score'] = pd.qcut(rfm['monetary'], 4, labels=[1, 2, 3, 4]).astype(int)
rfm['rfm_total'] = rfm['r_score'] + rfm['f_score'] + rfm['m_score']

def segment(score):
    if score >= 10: return 'Champions'
    elif score >= 8: return 'Loyal'
    elif score >= 6: return 'Potential'
    else: return 'At Risk'

rfm['segment'] = rfm['rfm_total'].apply(segment)

print(rfm.groupby('segment').agg(
    num_customers=('customer_id', 'count'),
    total_revenue=('monetary', 'sum')
))
