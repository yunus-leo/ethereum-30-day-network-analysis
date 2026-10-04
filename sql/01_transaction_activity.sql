-- Ethereum 30-Day Network Activity Analysis
-- Task 1: Daily transaction activity
--
-- Purpose:
-- Aggregate Ethereum Mainnet transactions into daily counts for the
-- established 30-day analysis window.
--
-- Data source:
-- BigQuery Ethereum Mainnet Blockchain Analytics dataset
--
-- Analysis window:
-- Start: 2026-08-24 10:01:35 UTC
-- End:   2026-09-23 10:01:35 UTC
--
-- Note:
-- The first and last calendar dates are partial days because the analysis
-- window starts and ends at 10:01:35 UTC. Python analysis therefore flags
-- those two boundary dates and uses the 29 complete days for comparable
-- daily statistics.

SELECT
  DATE(block_timestamp) AS date,
  COUNT(*) AS transaction_count
FROM
  `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.transactions`
WHERE
  block_timestamp >= TIMESTAMP('2026-08-24 10:01:35 UTC')
  AND block_timestamp <= TIMESTAMP('2026-09-23 10:01:35 UTC')
GROUP BY
  date
ORDER BY
  date;
