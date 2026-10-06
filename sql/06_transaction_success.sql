-- Ethereum 30-Day Network Activity Analysis
-- Task 6: Transaction Success
--
-- Question:
-- What proportion of Ethereum transactions succeeded versus failed
-- during the 30-day analysis window?
--
-- Data source:
-- bigquery-public-data.goog_blockchain_ethereum_mainnet_us.receipts
--
-- status:
-- 1 = successful transaction execution
-- 0 = failed transaction execution

SELECT
  DATE(block_timestamp) AS date,
  COUNT(*) AS total_transactions,
  COUNTIF(status = 1) AS successful_transactions,
  COUNTIF(status = 0) AS failed_transactions,
  SAFE_DIVIDE(COUNTIF(status = 1), COUNT(*)) * 100 AS success_rate_pct,
  SAFE_DIVIDE(COUNTIF(status = 0), COUNT(*)) * 100 AS failure_rate_pct
FROM
  `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.receipts`
WHERE
  block_timestamp >= TIMESTAMP('2026-08-24 10:01:35 UTC')
  AND block_timestamp <= TIMESTAMP('2026-09-23 10:01:35 UTC')
GROUP BY date
ORDER BY date;
