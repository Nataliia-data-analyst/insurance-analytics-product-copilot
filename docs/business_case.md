# Insurance Analytics Product Copilot

## 1. Business Problem

Insurance management has identified a deterioration in portfolio profitability.

The initial stakeholder request is:

> "Our insurance portfolio profitability has deteriorated this quarter.
> We need to understand what changed, identify the main business drivers,
> quantify their impact, and determine what management should monitor going forward."

The stakeholder does not know the root cause.

The analytics product should investigate the available data and determine
which factors are contributing to the change.

---

## 2. Product Goal

Build an AI-powered analytics copilot that translates a broad business
question into a structured analytics investigation.

The copilot should be able to:

1. Understand the business request
2. Translate it into analytical requirements
3. Identify relevant KPIs and dimensions
4. Assess whether the required data is available
5. Detect potential data-quality problems
6. Investigate the data using SQL
7. Compare periods and establish baselines
8. Explore potential root causes
9. Quantify findings where supported by data
10. Produce evidence-supported business insights
11. Define requirements for an analytics product
12. Generate acceptance criteria for the proposed solution

---

## 3. Main Business Areas

The analytical environment will contain data related to:

### Portfolio
- customers
- insurance products
- policies
- premiums
- distribution channels
- geography

### Claims
- claims
- claim types
- claim severity
- claim reserves
- claim payments
- claim lifecycle

### Operations
- claim handlers
- teams
- service requests
- processing time
- workload
- backlog

### Finance
- premiums
- claims costs
- operational costs
- budgets
- profitability

---

## 4. Example KPIs

The system should eventually support metrics such as:

- Written Premium
- Earned Premium
- Claim Frequency
- Claim Severity
- Paid Claims
- Outstanding Reserves
- Incurred Claims
- Loss Ratio
- Average Claim Processing Time
- Open Claims
- Claims Backlog
- Cost per Claim

Exact KPI definitions will be documented separately.

---

## 5. Investigation Principle

The agent should NOT be told where an anomaly exists.

For example, instead of asking:

> "Why did German Commercial Property claims increase?"

the stakeholder should be able to ask:

> "Why has portfolio profitability deteriorated this quarter?"

The copilot should determine which areas require investigation.

Typical investigation dimensions may include:

- time
- country
- region
- insurance product
- product line
- customer segment
- sales channel
- claim type
- claim severity
- claim handler
- operational team

---

## 6. Data Quality

Not every unusual metric should automatically be interpreted as a
business problem.

The copilot should distinguish between:

- real business performance changes
- operational problems
- data-quality issues
- insufficient data
- findings requiring further investigation

---

## 7. Expected Analytics Product

The investigation should ultimately support the design of an:

**Insurance Portfolio Performance & Claims Intelligence Dashboard**

The dashboard may include:

- Executive Portfolio Overview
- Premium & Profitability Analysis
- Claims Performance
- Claims Operations
- Product & Geography Analysis
- Data Quality Monitoring

---

## 8. Product Philosophy

The goal is not to build an AI chatbot that simply writes SQL.

The goal is to demonstrate the analytics product lifecycle:

Business Question
→ Requirements
→ Data Assessment
→ KPI Definition
→ Data Validation
→ Investigation
→ Insight
→ Product Specification
→ Acceptance Criteria