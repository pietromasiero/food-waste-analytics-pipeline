🌱 Food Waste Analytics Pipeline
================================

An end-to-end analytics project analyzing global food waste patterns using public data, built to demonstrate real-world Analytics Engineering skills: SQL modeling, Python/data visualization, and (upcoming) dbt transformations and BigQuery/Snowflake warehousing.

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
├── .gitignore
├── LICENSE
└── README.md
```

---

## 🔍 Analysis Overview

Both the SQL queries and the notebook cover the same seven analyses:

1. **Top 20 countries by total waste** (latest year)
2. **Waste per capita ranking** (latest year)
3. **Global trend over time** (2018–2024)
4. **Waste by food category** (share of total, economic loss, per-capita average)
5. **Year-over-year change by country** (window function `LAG()` in SQL / `.shift()` in pandas)
6. **Brazil deep dive** (waste and economic loss by year and category)
7. **Economic impact analysis** (loss per ton by country)

The notebook (`notebooks/01_exploratory_analysis.ipynb`) renders directly on GitHub with all charts included — no need to download or run anything to view the results.

---

## 🛠️ Tech Stack

- **SQL** — data modeling and analysis (`sql/`)
- **Python** — pandas, matplotlib, seaborn (`notebooks/`)
- **dbt** — *in progress*: migrating SQL transformations into `staging` → `marts` models with tests
- **BigQuery / Snowflake** — *planned*: cloud data warehouse layer

---

## ▶️ How to Run Locally

```bash
git clone https://github.com/pietromasiero/food-waste-analytics-pipeline.git
cd food-waste-analytics-pipeline

pip install pandas matplotlib seaborn jupyter

jupyter notebook notebooks/01_exploratory_analysis.ipynb
```

---

## 🧭 Roadmap

- [x] SQL exploration and analysis queries
- [x] Python notebook with visualizations
- [ ] Migrate SQL logic into dbt models (`staging` → `marts`)
- [ ] Add dbt tests (not null, accepted values, relationships)
- [ ] Load data into BigQuery/Snowflake
- [ ] Optional: interactive dashboard (Streamlit or Plotly Dash)

---

## 👤 Author

**Pietro Masiero**
Senior Management Information Analyst @ Sodexo | Data Analytics & BI
[LinkedIn](https://www.linkedin.com/in/pietromasiero) · [GitHub](https://github.com/pietromasiero)
