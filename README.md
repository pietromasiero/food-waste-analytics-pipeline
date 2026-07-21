# 🌱 Food Waste Analytics Pipeline

An end-to-end analytics project analyzing global food waste patterns using public data from the FAO (Food and Agriculture Organization). Built to demonstrate real-world Analytics Engineering skills: SQL modeling, dbt transformations, and BigQuery data warehousing.

> **Context:** Inspired by professional experience managing food waste reduction programs (Waste Watch) at Sodexo — a Fortune 500 global food services company operating across 5+ countries.

---

## 📊 Project Overview

Food waste is responsible for ~8-10% of global greenhouse gas emissions. This project analyzes food loss and waste data across countries, sectors, and supply chain stages to uncover patterns and opportunities for reduction.

**Key questions this project answers:**
- Which countries and regions have the highest food waste per capita?
- Which supply chain stages (production, retail, consumer) generate the most waste?
- How has food waste trended over time across different food categories?
- What is the estimated economic and environmental impact by region?

---

## 🏗️ Architecture

FAO Public Data (CSV)
↓
Raw Layer (SQL)
↓
Staging Layer (dbt)
↓
Marts Layer (dbt)
↓
BigQuery Data Warehouse
↓
Dashboard (Looker Studio / Power BI)


---

## 📁 Project Structure

food-waste-analytics-pipeline/
├── data/
│ └── sources.md # Links to public datasets used
├── sql/
│ ├── 01_exploration.sql # Initial data exploration queries
│ ├── 02_staging.sql # Data cleaning and standardization
│ ├── 03_metrics.sql # Core KPI calculations
│ └── 04_analysis.sql # Analytical queries and insights
├── dbt_project/ # Coming soon
│ ├── models/
│ │ ├── staging/
│ │ ├── intermediate/
│ │ └── marts/
│ └── tests/
└── README.md


---

## 🗃️ Data Sources

| Source | Description | Link |
|--------|-------------|------|
| FAO FAOSTAT | Food waste by country and commodity | [fao.org/faostat](https://www.fao.org/faostat) |
| WRAP | Food waste in food service sector | [wrap.org.uk](https://www.wrap.org.uk) |
| Our World in Data | Food waste visualizations and context | [ourworldindata.org](https://ourworldindata.org/food-waste) |

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| SQL | Data exploration and transformation |
| dbt | Data modeling and testing (in progress) |
| Google BigQuery | Cloud data warehouse |
| Python (pandas) | Data ingestion and EDA |
| Looker Studio / Power BI | Dashboard and visualization |
| Git / GitHub | Version control |

---

## 📈 Key Metrics (WIP)

- **Food Waste per Capita** by country (kg/year)
- **Waste by Supply Chain Stage** (production → retail → consumer)
- **Sector Comparison** (food service vs household vs retail)
- **Year-over-Year Trend** by region
- **Economic Loss Estimate** (USD value of wasted food)

---

## 🚧 Status

| Phase | Status |
|-------|--------|
| Data sourcing | ✅ Complete |
| SQL exploration | 🔄 In Progress |
| dbt modeling | 📅 Planned |
| BigQuery setup | 📅 Planned |
| Dashboard | 📅 Planned |

---

## 👤 Author

**Pietro Masiero**
Senior Data Analyst @ Sodexo (Fortune 500)
[LinkedIn](https://linkedin.com/in/pietromasiero) · [GitHub](https://github.com/pietromasiero)

---

*This project uses exclusively public data. No proprietary or confidential data from any employer is included.*




