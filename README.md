# Ethereum 30-Day Network Activity Analysis

A blockchain data analytics project examining **Ethereum Mainnet transaction activity, address participation, network utilization, gas market behavior, transaction execution, and network anomalies** using real on-chain data.

## Project Overview

This project analyzes Ethereum Mainnet activity over a **30-day observation window (August 24 – September 23, 2026, UTC)**.

The primary objective is to investigate network usage patterns, identify unusual activity, evaluate transaction execution outcomes, and explore relationships between key blockchain metrics.

The analysis uses **Google BigQuery and GoogleSQL** for blockchain data extraction and aggregation, followed by **Python and Pandas** for data processing, exploratory data analysis, statistical evaluation, and visualization.

**Analysis Period:** August 24 – September 23, 2026 (30-day observation window).

For consistent daily comparisons, the analysis uses **29 complete UTC days (August 25 – September 22, 2026)**, excluding the partial first and last days. The full observation window is retained when reporting overall transaction totals.

\---

## Key Findings

|Metric|Result|
|-|-:|
|Transactions across 29 complete days|55,151,035|
|Average daily transactions|1,901,760|
|Average daily active addresses|635,690|
|Average transactions per active address|3.014|
|Average block gas utilization|50.61%|
|Transaction execution success rate|98.49%|

### Notable Insights

* **Transaction Activity:** Daily transaction volume fluctuated but remained broadly consistent throughout the observation period.
* **Address Participation:** Transaction counts and active-address counts moved closely together.
* **Network Utilization:** Gas consumption remained relatively stable despite variations in transaction activity.
* **Gas Market:** Daily mean gas prices varied substantially more than gas consumption.
* **Network Anomalies:** September 13, 2026, recorded unusually low activity across multiple network metrics.
* **Transaction Execution:** Most transactions executed successfully, with a transaction-weighted success rate of 98.49%.

\---

## Analytical Objectives

The project investigates nine analytical areas:

1. **Ethereum Transaction Activity** — Examine daily transaction counts, averages, extremes, and trends.
2. **Active Addresses** — Analyze daily address participation and activity patterns.
3. **Transaction Intensity** — Calculate and evaluate transactions per active address.
4. **Network Utilization** — Assess transactions per block, gas consumption, and block gas utilization.
5. **Gas Market Activity** — Investigate gas prices, computational usage, and periods of relatively elevated gas prices.
6. **Transaction Success** — Measure successful and failed transaction execution.
7. **Contract vs. EOA Activity** — Examine observable smart-contract activity and classification limitations.
8. **Network Activity Anomalies** — Identify statistically unusual network activity using z-scores and descriptive measures.
9. **Relationships Between Metrics** — Explore correlations and relationships among Ethereum network indicators.

\---

## Analytical Workflow

**Ethereum Mainnet → Google BigQuery → GoogleSQL → CSV Exports → Python/Pandas → Statistical Analysis → Data Visualization → Insights**

### 1\. Data Extraction

GoogleSQL queries extract and aggregate Ethereum Mainnet blockchain records using Google BigQuery.

### 2\. Data Processing and Analysis

Python and Pandas are used for:

* Data validation and cleaning
* Descriptive statistical analysis
* Daily percentage change calculations
* Rolling averages
* Transaction intensity calculations
* Statistical anomaly detection
* Correlation analysis

### 3\. Data Visualization

Matplotlib and Plotly are used to visualize:

* Daily transaction activity and network trends
* Active address participation
* Network utilization and gas market behavior
* Transaction execution outcomes
* Network activity anomalies
* Relationships between blockchain metrics

\---

## Data Source

**Google Cloud BigQuery — Ethereum Mainnet Blockchain Analytics**

**Dataset:**

`bigquery-public-data.goog\_blockchain\_ethereum\_mainnet\_us`

The analysis uses blockchain records from the following tables:

* Transactions
* Blocks
* Receipts
* Logs
* Traces

SQL queries aggregate the underlying blockchain records into daily datasets for subsequent analysis in Python.

\---

## Tools and Technologies

|Tool|Purpose|
|-|-|
|Google BigQuery|Blockchain data querying|
|GoogleSQL|Data extraction and aggregation|
|Python|Analytical programming|
|Pandas|Data manipulation and statistical analysis|
|Matplotlib|Statistical visualization|
|Plotly|Interactive data visualization|
|Jupyter Notebook / JupyterLab|Analysis development and documentation|
|Git and GitHub|Version control and project management|

\---

## Methodology and Limitations

The analysis follows a structured methodology to maintain consistency, reproducibility, and accurate interpretation.

**Observation Window**

The study covers an exact 30-day timestamp window. Daily comparisons use 29 complete UTC days to avoid distortions caused by partial-day observations.

**Active Address Measurement**

Active addresses represent distinct blockchain addresses appearing as transaction senders or recipients within a day. They should not be interpreted as unique individual users.

**Statistical Interpretation**

Correlations and anomaly indicators describe observed relationships and deviations within the dataset. They do not independently establish causation.

**Network Scope**

The analysis focuses exclusively on Ethereum Mainnet and does not include activity occurring on Layer 2 networks.

**Data Granularity**

Daily aggregation may conceal intraday fluctuations and transaction-level patterns.

\---

## Project Report

The complete analytical report documents the research methodology, statistical findings, visualizations, interpretations, and limitations.

The report includes detailed discussions of Ethereum transaction activity, address participation, network utilization, gas markets, execution outcomes, network anomalies, and metric relationships.

**Location:** `reports/`

\---

## Future Improvements

* **Extended Time-Series Analysis:** Analyze longer observation periods to evaluate sustained trends and recurring activity patterns.
* **Granular Anomaly Investigation:** Examine unusual network activity at hourly resolution to better understand short-term fluctuations.
* **Interactive Analytics Dashboard:** Develop an interactive dashboard for exploring Ethereum network metrics and trends.

