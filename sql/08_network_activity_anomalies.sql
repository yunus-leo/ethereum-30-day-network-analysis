-- Ethereum 30-Day Network Activity Analysis
-- Task 8 - Network Activity Anomalies

-- Question
-- Which days experienced unusual Ethereum network activity?

-- No new BigQuery extraction is required for this task.

-- The spike analysis is performed in Python/Pandas using the
-- analytical datasets already produced by Tasks 1–5.
--
-- Existing analytical datasets:
--   data/processed/daily_transactions.csv
--   data/processed/daily_active_addresses.csv
--   data/processed/daily_network_utilization.csv
--   data/processed/daily_gas_activity.csv
--
-- BigQuery is used earlier in the workflow to prepare the analytical
-- datasets. Python/Pandas performs the statistical anomaly detection.

-- Reference only:
-- Task 1: daily transaction activity
-- Task 2: daily active addresses
-- Task 4: network utilization / gas usage / transactions per block
-- Task 5: gas price / gas usage / gas utilization
