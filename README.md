🌱 Food Waste Analytics Pipeline
================================

An end-to-end analytics project analyzing global food waste patterns using public data, built to demonstrate real-world Analytics Engineering skills: SQL modeling, Python data visualization, and dbt transformations with automated testing and documentation.

This project applies the same analytical logic used professionally in the **Waste Watch Brazil** program at Sodexo — compliance tracking, per-capita waste, and reduction-vs-baseline KPIs — to open data, since operational data from Sodexo clients cannot be shared publicly.

---

## 📊 Data Source

**Global Food Wastage Dataset (2018–2024)**
Source: [Kaggle — Atharva Soundankar](https://www.kaggle.com/datasets/atharvasoundankar/global-food-wastage-dataset-2018-2024)

The dataset covers 20 countries, 8 food categories, and 7 years (2018–2024), with the following fields:

| Column | Description |
|---|---|
| `Country` | Country name |
| `Year` | Reporting year (2018–2024) |
| `Food Category` | Category of food (e.g. Fruits & Vegetables, Dairy, Meat & Seafood) |
| `Total Waste (Tons)` | Total food waste in tons |
| `Economic Loss (Million $)` | Estimated economic loss in USD millions |
| `Avg Waste per Capita (Kg)` | Average waste per capita in kg |
| `Population (Million)` | Population in millions |
| `Household Waste (%)` | Share of waste attributable to households |

---

## 🗂️ Project Structure

```
food-waste-analytics-pipeline/
├── sql/
│   ├── 01_exploration.sql        # Initial data exploration queries
│   └── 02_analysis.sql           # Core analysis: rankings, trends, YoY, economic impact
├── data/
│   └── global_food_wastage_dataset.csv
├── notebooks/
│   └── 01_exploratory_analysis.ipynb   # Python (pandas + matplotlib/seaborn) version of the SQL analysis, with charts
├── dbt_project/
│   ├── dbt_project.yml
│   ├── profiles.yml.EXAMPLE      # Template for local ~/.dbt/profiles.yml (never commit real credentials)
│   ├── seeds/
│   │   └── global_food_wastage_dataset.csv   # Clean, snake_case column names for warehouse loading
│   └── models/
│       ├── staging/
│       │   ├── stg_food_waste.sql       # Cleaning, type casting, derived metrics
│       │   └── schema.yml               # Source/model documentation and tests
│       └── marts/
│           ├── fct_waste_by_country_year.sql   # Country/year rollup + year-over-year % change
│           ├── fct_waste_by_category.sql       # Category rollup + share of global total
│           ├── fct_economic_impact.sql         # Economic loss per ton by country
│           └── schema.yml
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🔍 Analysis Overview

The SQL scripts, the Python notebook, and the dbt models all cover the same core analyses:

1. **Top countries by total waste**
2. **Waste per capita ranking**
3. **Global trend over time** (2018–2024)
4. **Waste by food category** (share of total, economic loss, per-capita average)
5. **Year-over-year change by country** (`LAG()` window function in SQL, `.shift()` in pandas, `lag() over()` in dbt)
6. **Country deep dive** (e.g. Brazil — filter any mart by `country`)
7. **Economic impact analysis** (loss per ton by country)

The notebook renders directly on GitHub with all charts included. The dbt project includes a full **lineage graph** (seed → staging → marts) generated via `dbt docs`.

---

## 🛠️ Tech Stack

- **SQL** — data modeling and analysis (`sql/`)
- **Python** — pandas, matplotlib, seaborn (`notebooks/`)
- **dbt** — staging → marts transformation layer, with automated data quality tests (`not_null`, `unique`, `accepted_values`)
- **DuckDB** — local analytical warehouse used as the dbt target (zero-setup, ideal for a portfolio project; swappable for BigQuery/Snowflake in a production context)

---

## ▶️ How to Run Locally

**Notebook:**
```bash
git clone https://github.com/pietromasiero/food-waste-analytics-pipeline.git
cd food-waste-analytics-pipeline

pip install pandas matplotlib seaborn jupyter
jupyter notebook notebooks/01_exploratory_analysis.ipynb
```

**dbt pipeline:**
```bash
pip install dbt-core dbt-duckdb

mkdir -p ~/.dbt
cp dbt_project/profiles.yml.EXAMPLE ~/.dbt/profiles.yml

cd dbt_project
dbt debug   # verify setup
dbt seed    # load the CSV into DuckDB
dbt run     # build staging + marts models
dbt test    # run data quality tests

dbt docs generate && dbt docs serve   # view the lineage graph
```

---

## 🧭 Roadmap

- [x] SQL exploration and analysis queries
- [x] Python notebook with visualizations
- [x] dbt project: staging → marts models, tested and documented (DuckDB)
- [ ] Optional: load models into BigQuery/Snowflake for a cloud-warehouse variant
- [ ] Optional: interactive dashboard (Streamlit or Plotly Dash)

---

## 👤 Author

**Pietro Masiero**
Senior Management Information Analyst @ Sodexo | Data Analytics & BI
[LinkedIn](https://www.linkedin.com/in/pietromasiero) · [GitHub](https://github.com/pietromasiero)
