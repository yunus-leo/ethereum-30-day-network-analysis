-- Ethereum 30-Day Network Activity Analysis
-- Task 5: Gas Market Activity
--
-- Gas price is converted from Wei to Gwei.

-- Data source:
-- BigQuery Ethereum Mainnet Blockchain Analytics dataset
--
-- Analysis window:
-- Start: 2026-08-24 10:01:35 UTC
-- End:   2026-09-23 10:01:35 UTC

WITH gas_prices AS (
  SELECT
    DATE(block_timestamp) AS date,
    AVG(gas_price) / 1e9 AS avg_gas_price_gwei,
    APPROX_QUANTILES(gas_price, 100)[OFFSET(50)] / 1e9
      AS median_gas_price_gwei
  FROM
    `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.transactions`
  WHERE
    block_timestamp >= TIMESTAMP('2026-08-24 10:01:35 UTC')
    AND block_timestamp <= TIMESTAMP('2026-09-23 10:01:35 UTC')
  GROUP BY date
),
block_gas AS (
  SELECT
    DATE(block_timestamp) AS date,
    SUM(gas_used) AS total_gas_used,
    AVG(gas_used) AS avg_gas_used_per_block,
    AVG(gas_limit) AS avg_gas_limit,
    AVG(SAFE_DIVIDE(gas_used, gas_limit) * 100)
      AS avg_gas_utilization_pct
  FROM
    `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.blocks`
  WHERE
    block_timestamp >= TIMESTAMP('2026-08-24 10:01:35 UTC')
    AND block_timestamp <= TIMESTAMP('2026-09-23 10:01:35 UTC')
  GROUP BY date
)
SELECT
  gp.date,
  gp.avg_gas_price_gwei,
  gp.median_gas_price_gwei,
  bg.total_gas_used,
  bg.avg_gas_used_per_block,
  bg.avg_gas_limit,
  bg.avg_gas_utilization_pct
FROM gas_prices AS gp
INNER JOIN block_gas AS bg
  ON gp.date = bg.date
ORDER BY gp.date;
