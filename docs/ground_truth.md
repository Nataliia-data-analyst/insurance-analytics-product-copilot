# Synthetic Data Ground Truth

This document describes intentionally embedded patterns and anomalies in the
synthetic insurance dataset.

It is used to validate whether the analytics copilot can independently discover
important business and data-quality signals.

The agent should NOT receive this document as analytical context.

## Dataset Period

January 2025 – December 2026

## Scenario 1 — Portfolio Profitability Deterioration

During Q4 2026, portfolio profitability deteriorates.

Primary driver:

Commercial Property claims in Germany experience a significant increase in
claim costs.

Expected pattern:

- Claim frequency increases moderately
- Claim severity increases significantly
- High-severity claims become more common
- Incurred claim costs increase faster than earned premium
- Loss ratio deteriorates

The strongest effect should be visible in:

Product line: Commercial Property
Country: Germany
Period: Q4 2026

The anomaly should not dominate the entire portfolio so strongly that it is
obvious without segmentation.


## Scenario 2 — Reserve Strengthening

During Q4 2026, reserves for older Commercial Property claims are revised upward.

Expected pattern:

- New claim volume does not explain the full increase in incurred claims
- Paid claims increase only moderately
- Outstanding reserves increase significantly
- Several older claims receive large upward reserve revisions

The agent should distinguish reserve development from new claim activity.


## Scenario 3 — Claims Operations Bottleneck

During Q3–Q4 2026, Motor claims processing deteriorates in Poland.

Primary operational driver:

One claims team experiences significantly increased workload.

Expected pattern:

- Average processing time increases
- Open claims backlog increases
- Service request resolution time increases
- The problem is concentrated in one operational team
- Other Polish Motor teams remain relatively stable

The agent should drill down from portfolio → product → country → team.


## Scenario 4 — Duplicate Claim Payments

A small number of claim payment records are duplicated during Q4 2026.

Expected pattern:

- Paid claim costs appear unusually high for a subset of claims
- Duplicate records have similar claim, amount, payment date and payment type
- The anomaly should be detectable through data-quality analysis

The agent should classify this as a potential data-quality issue rather than
automatically treating it as real claims deterioration.


## Scenario 5 — Operating Cost Pressure

Operational costs increase during Q4 2026.

Expected pattern:

- Actual costs exceed budget in selected claims-related cost centers
- External/vendor costs are the main contributor
- Premium growth does not compensate fully for claims and operating cost growth

This should appear as a secondary profitability driver rather than the primary
driver.


## Benchmark Principle

The benchmark question will not reveal these scenarios.

Example:

"Our insurance portfolio profitability deteriorated in Q4 2026 compared with
Q3 2026. Investigate what changed, identify the main drivers, quantify their
impact where supported by the data, and identify any operational or data-quality
issues that require attention."

A successful investigation should distinguish:

1. Primary business drivers
2. Secondary business drivers
3. Operational anomalies
4. Data-quality issues
5. Findings that cannot be concluded from available data
