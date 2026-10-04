-- 1. Latest indexed Ethereum block

SELECT
  MAX(block_number) AS latest_indexed_block
FROM
  `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.blocks`;


-- 2. Latest indexed block timestamp

SELECT
  block_number,
  block_timestamp
FROM
  `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.blocks`
WHERE
  block_number = 26039452;


-- 3. Define the 30-day analysis window

SELECT
  TIMESTAMP_SUB(
    TIMESTAMP('2026-09-23 10:01:35 UTC'),
    INTERVAL 30 DAY
  ) AS analysis_start,
  TIMESTAMP('2026-09-23 10:01:35 UTC') AS analysis_end;


-- 4. Identify the starting block

SELECT
  block_number,
  block_timestamp
FROM
  `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.blocks`
WHERE
  block_timestamp >= TIMESTAMP('2026-08-24 10:01:35 UTC')
ORDER BY
  block_number
LIMIT 1;


-- 5. Validate the analysis window

SELECT
  COUNT(*) AS blocks_in_window,
  MIN(block_number) AS first_block,
  MAX(block_number) AS last_block,
  MIN(block_timestamp) AS first_timestamp,
  MAX(block_timestamp) AS last_timestamp
FROM
  `bigquery-public-data.goog_blockchain_ethereum_mainnet_us.blocks`
WHERE
  block_timestamp >= TIMESTAMP('2026-08-24 10:01:35 UTC')
  AND block_timestamp <= TIMESTAMP('2026-09-23 10:01:35 UTC');