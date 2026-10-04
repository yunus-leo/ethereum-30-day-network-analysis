-- Ethereum 30-Day Network Activity Analysis
-- Task 4: Network Utilization
--
-- Analytical question:
-- How heavily was Ethereum's blockspace being utilized
-- during the 30-day analysis period?
--
-- Metrics:
-- 1. Transactions per block
-- 2. Gas used
-- 3. Gas utilization
-- 4. Block gas limit
--
-- The blocks table already provides transaction_count,
-- gas_used, and gas_limit, so no transaction-table join
-- is required for these metrics.

SELECT
  DATE(block_timestamp) AS date,
  AVG(transaction_count) AS avg_transactions_per_block,
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
GROUP BY
  date
ORDER BY
  date;