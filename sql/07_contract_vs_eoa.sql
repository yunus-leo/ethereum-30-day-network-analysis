-- Ethereum 30-Day Network Activity Analysis
-- Task 7 — Contract vs EOA Activity

-- Question
-- What type of transaction activity dominated Ethereum during the period?

-- Data source:
-- bigquery-public-data.goog_blockchain_ethereum_mainnet_us.transactions
-- bigquery-public-data.goog_blockchain_ethereum_mainnet_us.logs
-- bigquery-public-data.goog_blockchain_ethereum_mainnet_us.traces

-- Analysis window:
-- Start: 2026-08-24 10:01:35 UTC
-- End:   2026-09-23 10:01:35 UTC
--
-- Methodology:
-- Contract-interaction transactions = transactions with at least one
-- non-removed log.
-- Contract-creation transactions = transactions with at least one
-- CREATE trace.
--
-- These measures can overlap and must not be added together.
-- Transactions without observed logs are NOT classified as EOA-to-EOA.

WITH transactions AS (
  SELECT
    DATE(block_timestamp) AS date,
    COUNT(*) AS total_transactions
  FROM
    `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.transactions`
  WHERE
    block_timestamp >= TIMESTAMP('2026-08-24 10:01:35 UTC')
    AND block_timestamp <= TIMESTAMP('2026-09-23 10:01:35 UTC')
  GROUP BY date
),

contract_interactions AS (
  SELECT
    DATE(block_timestamp) AS date,
    COUNT(DISTINCT transaction_hash) AS contract_interaction_transactions
  FROM
    `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.logs`
  WHERE
    block_timestamp >= TIMESTAMP('2026-08-24 10:01:35 UTC')
    AND block_timestamp <= TIMESTAMP('2026-09-23 10:01:35 UTC')
    AND removed = FALSE
  GROUP BY date
),

contract_creations AS (
  SELECT
    DATE(block_timestamp) AS date,
    COUNT(DISTINCT transaction_hash) AS contract_creation_transactions
  FROM
    `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.traces`
  WHERE
    block_timestamp >= TIMESTAMP('2026-08-24 10:01:35 UTC')
    AND block_timestamp <= TIMESTAMP('2026-09-23 10:01:35 UTC')
    AND trace_type = 'create'
  GROUP BY date
)

SELECT
  t.date,
  t.total_transactions,
  COALESCE(ci.contract_interaction_transactions, 0)
    AS contract_interaction_transactions,
  COALESCE(cc.contract_creation_transactions, 0)
    AS contract_creation_transactions,
  t.total_transactions
    - COALESCE(ci.contract_interaction_transactions, 0)
    AS transactions_without_observed_logs
FROM transactions AS t
LEFT JOIN contract_interactions AS ci
  ON t.date = ci.date
LEFT JOIN contract_creations AS cc
  ON t.date = cc.date
ORDER BY t.date;
