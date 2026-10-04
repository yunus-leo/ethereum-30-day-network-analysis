-- Ethereum 30-Day Network Activity Analysis
-- Task 2: Daily active addresses
--
-- Analytical question:
-- How many unique Ethereum addresses were active on each day during
-- the 30-day analysis period?
--
-- Definition used in this project:
-- An active address is a unique non-null Ethereum address that appears
-- as either the sender (from_address) or recipient (to_address) of a
-- transaction during a given day.
--
-- Important limitation:
-- Active addresses are addresses involved in on-chain transactions.
-- They should NOT be interpreted as unique users or unique people.
--
-- Data source:
-- BigQuery Ethereum Mainnet Blockchain Analytics dataset
--
-- Analysis window:
-- Start: 2026-08-24 10:01:35 UTC
-- End:   2026-09-23 10:01:35 UTC
--
-- The first and last calendar dates are partial days. The SQL returns
-- the complete timestamp window; Python will flag the two boundary
-- dates before comparable daily statistics are calculated.
--
-- Query design:
-- UNNEST([from_address, to_address]) lets us treat both sides of each
-- transaction as address observations without scanning the transaction
-- table in two separate queries.

SELECT
  DATE(block_timestamp) AS date,
  COUNT(DISTINCT address) AS active_addresses
FROM
  `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.transactions`,
  UNNEST([from_address, to_address]) AS address
WHERE
  block_timestamp >= TIMESTAMP('2026-08-24 10:01:35 UTC')
  AND block_timestamp <= TIMESTAMP('2026-09-23 10:01:35 UTC')
  AND address IS NOT NULL
GROUP BY
  date
ORDER BY
  date;
