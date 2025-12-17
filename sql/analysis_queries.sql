# Основные каналы
SELECT DISTINCT channel
FROM `mytestproject1-477512.firstproject.marketingdata_clean`

# Основные метрики по каналам
SELECT
channel,
COUNT(*) AS total_clicks,
SUM(converted) AS conversions,
ROUND(SUM(cost),2) AS total_cost,
ROUND(SUM(revenue),2) AS total_revenue,
ROUND(SUM(converted)*100.0 / COUNT(*), 2) AS conversion_rate,
CASE
  WHEN SUM(converted) > 0 THEN ROUND(SUM(cost) / SUM(converted), 2)
  ELSE NULL
  END AS cac,
CASE
  WHEN SUM(cost) > 0 THEN ROUND((SUM(revenue) - SUM(cost)) / SUM(cost) * 100, 1)
  ELSE NULL
  END AS roi
 FROM `mytestproject1-477512.firstproject.marketingdata_clean`
 GROUP BY channel
 ORDER BY total_revenue DESC;

# Тренд по месяцам
SELECT
FORMAT_DATE('%Y-%m', date) AS month,
SUM(converted) AS conversions,
ROUND(SUM(revenue), 2) AS revenue,
ROUND(SUM(cost), 2) AS cost
 FROM `mytestproject1-477512.firstproject.marketingdata_clean`
 GROUP BY month
 ORDER BY month;

# Топ-5 дней по выручке
SELECT
date,
channel,
ROUND(SUM(revenue), 2) AS daily_revenue,
SUM(converted) AS conversions
FROM `mytestproject1-477512.firstproject.marketingdata_clean`
GROUP BY date, channel
ORDER BY daily_revenue DESC
LIMIT 5;
