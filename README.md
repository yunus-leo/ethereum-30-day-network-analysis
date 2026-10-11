# Ethereum 30-Day Network Activity Analysis

A blockchain data analytics project examining **Ethereum Mainnet transaction activity, address participation, network utilization, gas market behavior, transaction execution, and network anomalies** using real on-chain data.

**Analysis Period:** August 24, 2026, 10:01:35 UTC – September 23, 2026, 10:01:35 UTC  
**Comparable daily sample:** August 25 – September 22, 2026 (29 complete UTC days) - For consistent daily comparisons, the analysis uses **29 complete UTC days, excluding the partial first and last days.

**Stack:** Google BigQuery · GoogleSQL · Python · Pandas · Matplotlib · Plotly · Jupyter

> \*\*Research question:\*\* What happened on Ethereum during the observation window, and what can network-level data tell us about activity?

The analysis uses **Google BigQuery and GoogleSQL** for blockchain data extraction and aggregation, followed by **Python and Pandas** for data processing, exploratory data analysis, statistical evaluation, and visualization.

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

## Analytical questions and findings

### 1\. How did Ethereum transaction activity change?

**Answer:** Ethereum processed **55.15 million transactions** during the 29 complete days, averaging **1.90 million/day**. The busiest day was **September 11** (**2,097,342**); the quietest was **September 13** (**1,476,230**). Counts finished **4.98%** above the first complete day, but varied enough that this endpoint change should not be interpreted as a sustained upward trend.

[Ethereum daily transaction activity](visualizations/png/01\_transaction\_activity\_chart\_01.png)

[Notebook](notebooks/01_transaction_activity.ipynb) · [Interactive HTML file](visualizations/html/01_transaction_activity_chart_01.html)

### 2\. How many addresses were active each day?

**Answer:** Ethereum averaged **635,690 active addresses/day**. The highest count was **829,303** on **September 10**, and the lowest was **454,329** on **September 13**. Active-address counts changed more sharply than transaction counts (coefficients of variation of **12.86%** versus **7.87%**).

An *active address* here is a distinct non-null sender or recipient on a given day—not necessarily an individual person.

![Ethereum daily active addresses](visualizations/png/02\_active\_addresses\_chart\_01.png)

[Notebook](notebooks/02_active_addresses.ipynb) · [Interactive HTML file](visualizations/html/02_active_addresses_chart_01.html)

### 3\. How many transactions occurred per active address?

**Answer:** The mean **daily transaction-count / active-address-count ratio** was **3.014**, with a high of **3.537** on **August 30** and a low of **2.528** on **September 10**. The ratio declined **3.40%** between the first and last complete days.

This is a *network-level ratio*, not the average number of transactions sent by each address: recipients and contracts are included in the denominator.

[Notebook](notebooks/03_transaction_intensity.ipynb) · [Chart PNG](visualizations/png/03_transaction_intensity_chart_01.png)

### 4\. How heavily was Ethereum blockspace utilized?

**Answer:** Blocks averaged **50.61% gas utilization**, with a narrow daily range of **50.46%–50.82%**. Meanwhile, daily transactions per block ranged from **205.57** to **292.96**. Transaction counts moved considerably more than consumed gas, indicating that throughput and computational usage capture different aspects of activity.

Utilization is the **daily mean of block-level gas-used / gas-limit percentages**; it does not directly measure congestion or waiting times.

[Notebook](notebooks/04_network_utilization.ipynb) · [Chart PNG](visualizations/png/04_network_utilization_chart_01.png)

### 5\. How did gas market activity change?

**Answer:** The mean of daily mean gas prices was **0.815 Gwei**, ranging from **0.465 Gwei** on **August 29** to **1.148 Gwei** on **September 21**. Daily mean gas price had a **17.18%** coefficient of variation, versus **0.24%** for daily gas consumption. High-price days under a within-sample 90th-percentile threshold included **September 11, 15, and 21**.

Gas price is distinct from gas consumed; these field-based gas-price summaries do not calculate total paid fees or USD costs.

[Ethereum gas market activity](visualizations/png/05\_gas\_activity\_chart\_01.png)

[Notebook](notebooks/05_gas_activity.ipynb) · [Interactive HTML file](visualizations/html/05_gas_activity_chart_01.html)

### 6\. What proportion of transactions succeeded?

**Answer:** Of **55,151,035** transactions on complete days, **54,319,998 succeeded** and **831,037 failed** at the receipt level: **98.49% success** and **1.51% failure**. The daily failure rate ranged from **0.94%** on **September 11** to **2.69%** on **September 20**.

Receipt failures describe execution outcomes of included transactions—not network downtime or transactions that never reached a block.

[Notebook](notebooks/06_transaction_success.ipynb) · [Chart PNG](visualizations/png/06_transaction_success_chart_01.png)

### 7\. What contract-related activity was observable?

**Answer:** **35,024,739 transactions (63.51%)** had at least one non-removed log, while **299,259 (0.54%)** were associated with a CREATE trace. These measures can overlap. Transactions without observed logs **cannot** automatically be classified as EOA-to-EOA transfers, and CREATE traces do not establish successful contract deployments.

The available evidence supports substantial observable contract-event activity, **not a complete contract-versus-EOA breakdown**.

[Notebook](notebooks/07_contract_vs_eoa.ipynb) · [Chart PNG](visualizations/png/07_contract_vs_eoa_chart_01.png)

### 8\. Which days showed unusual network activity?

**Answer:** A **five-metric z-score screen** (flagging |z| ≥ 2 against the 29-day sample) marked at least one unusually high or low observation on **eight days**. **September 13** had the broadest set of low flags: transaction count, active addresses, and transactions per block. **September 21** combined unusually low gas consumption with unusually high mean gas price.

Flags are **descriptive signals for further investigation**. Several metrics share underlying data, so multiple flags are not independent proof of a single event.

[Ethereum network activity anomaly screen](visualizations/png/08\_network\_activity\_anomalies\_chart\_01.png)

[Notebook](notebooks/08_network_activity_anomalies.ipynb) · [Interactive HTML file](visualizations/html/08_network_activity_anomalies_chart_01.html)

### 9\. How were key network metrics related?

**Answer:** Transactions and active addresses had a **strong positive Pearson correlation (r = +0.874)**, whereas daily mean gas price and transaction count had **little linear association (r = +0.065)**. Active addresses and the transaction-intensity ratio were negatively associated (**r = −0.839**), though this is partly mechanical because active addresses appear in the ratio's denominator.

These are correlations across **29 daily observations**, not evidence of causation or of the same relationships at hourly granularity.

[Ethereum metric relationships](visualizations/png/09\_metric\_relationships\_chart\_01.png)

[Notebook](notebooks/09_metric_relationships.ipynb) · [Interactive HTML file](visualizations/html/09_metric_relationships_chart_01.html)

\---

## Analytical Workflow

**Ethereum Mainnet → Google BigQuery → GoogleSQL → CSV Exports → Python/Pandas → Statistical Analysis → Data Visualization → Insights**

### Data Processing and Analysis

Python and Pandas were used for:

* Data validation
* Descriptive statistical analysis
* Daily percentage change calculations
* Rolling averages
* Transaction intensity calculations
* Statistical anomaly detection
* Correlation analysis

**Source dataset:** `bigquery-public-data.goog\_blockchain\_ethereum\_mainnet\_us`. The project uses transaction, block, receipt, log, and trace records. SQL performs large-scale aggregation; Pandas analyzes daily exports. Tasks 3, 8, and 9 reuse existing outputs instead of rescanning raw chain tables.

### Reproducing the analysis

1. Review the fixed timestamp window and block metadata in [`sql/00\_data\_validation.sql`](sql/00_data_validation.sql).
2. Use the queries in [`sql/`](sql/) to reproduce the six daily CSV exports, or work with the existing files in [`data/processed/`](data/processed/).
3. Run notebooks [`01`–`09`](notebooks/) in order from the `notebooks/` directory with the required Python packages installed. Daily comparisons exclude the partial dates **August 24** and **September 23**.
4. Review the figures and results alongside the detailed report.

Re-querying BigQuery can incur processing costs; check the estimated bytes scanned before execution.

## Limitations and interpretation

* **Time and scope:** One short Ethereum Mainnet window; no Layer 2 activity or long-term adoption inference.
* **Addresses:** Sender/recipient addresses include contracts and do not represent unique people.
* **Daily aggregation:** Can conceal intraday and transaction-level patterns.
* **Gas:** Reported gas-price summaries do not isolate fee components or compute transaction fees in fiat terms.
* **Contract activity:** Logs and CREATE traces are observable proxies, not exhaustive transaction-type labels.
* **Statistics:** Correlations and z-score flags are descriptive; shared variables and the short sample limit interpretation.

## Full report and project files

The full analytical report provides additional charts, methods, metric definitions, and caveats. Browse the [`reports/`](reports/) directory for the PDF, data lineage, and definitions.

**Interactive visualizations:** Plotly HTML exports live in [`visualizations/html/`](visualizations/html/). 

## Follow-up investigations

* Study the **September 13** activity trough at hourly granularity.
* Extend the observation period to test the stability of trends and anomaly flags.
* Build an interactive dashboard to compare network metrics over time.

