-- ============================================================
-- Food Waste Analytics Pipeline
-- 02_analysis.sql
-- Analysis using Global Food Wastage Dataset (2018-2024)
-- Source: Kaggle - Atharva Soundankar
-- Author: Pietro Masiero
-- ============================================================

-- ------------------------------------------------------------
-- 1. TOP 20 COUNTRIES BY TOTAL WASTE (latest year)
-- ------------------------------------------------------------
SELECT
    Country,
    Year,
    SUM("Total Waste (Tons)") AS total_waste_tons,
    SUM("Economic Loss (Million $)") AS total_economic_loss_million_usd
FROM global_food_wastage_dataset
WHERE Year = (SELECT MAX(Year) FROM global_food_wastage_dataset)
GROUP BY Country, Year
ORDER BY total_waste_tons DESC
LIMIT 20;


-- ------------------------------------------------------------
-- 2. WASTE PER CAPITA RANKING (latest year)
-- ------------------------------------------------------------
SELECT
    Country,
    Year,
    ROUND(AVG("Avg Waste per Capita (Kg)"), 2) AS avg_waste_per_capita_kg,
    ROUND(AVG("Household Waste (%)"), 2) AS avg_household_waste_pct
FROM global_food_wastage_dataset
WHERE Year = (SELECT MAX(Year) FROM global_food_wastage_dataset)
GROUP BY Country, Year
ORDER BY avg_waste_per_capita_kg DESC
LIMIT 20;


-- ------------------------------------------------------------
-- 3. GLOBAL TREND OVER TIME (2018-2024)
-- ------------------------------------------------------------
SELECT
    Year,
    SUM("Total Waste (Tons)") AS global_waste_tons,
    SUM("Economic Loss (Million $)") AS global_economic_loss_million_usd,
    COUNT(DISTINCT Country) AS countries_reporting,
    ROUND(AVG("Avg Waste per Capita (Kg)"), 2) AS avg_waste_per_capita_kg
FROM global_food_wastage_dataset
GROUP BY Year
ORDER BY Year ASC;


-- ------------------------------------------------------------
-- 4. WASTE BY FOOD CATEGORY (all years)
-- ------------------------------------------------------------
SELECT
    "Food Category",
    SUM("Total Waste (Tons)") AS total_waste_tons,
    SUM("Economic Loss (Million $)") AS total_economic_loss_million_usd,
    ROUND(AVG("Avg Waste per Capita (Kg)"), 2) AS avg_waste_per_capita_kg,
    ROUND(
        SUM("Total Waste (Tons)") * 100.0 /
        SUM(SUM("Total Waste (Tons)")) OVER (),
    2) AS pct_of_total_waste
FROM global_food_wastage_dataset
GROUP BY "Food Category"
ORDER BY total_waste_tons DESC;


-- ------------------------------------------------------------
-- 5. YEAR-OVER-YEAR CHANGE BY COUNTRY
-- ------------------------------------------------------------
WITH yearly_by_country AS (
    SELECT
        Country,
        Year,
        SUM("Total Waste (Tons)") AS total_waste_tons
    FROM global_food_wastage_dataset
    GROUP BY Country, Year
),
yoy AS (
    SELECT
        Country,
        Year,
        total_waste_tons,
        LAG(total_waste_tons) OVER (
            PARTITION BY Country ORDER BY Year
        ) AS prev_year_waste,
        ROUND(
            (total_waste_tons - LAG(total_waste_tons) OVER (
                PARTITION BY Country ORDER BY Year
            )) / NULLIF(LAG(total_waste_tons) OVER (
                PARTITION BY Country ORDER BY Year
            ), 0) * 100,
        2) AS pct_change_yoy
    FROM yearly_by_country
)
SELECT *
FROM yoy
WHERE pct_change_yoy IS NOT NULL
ORDER BY Country, Year;


-- ------------------------------------------------------------
-- 6. BRAZIL DEEP DIVE
-- ------------------------------------------------------------
SELECT
    Country,
    Year,
    "Food Category",
    "Total Waste (Tons)" AS waste_tons,
    "Economic Loss (Million $)" AS economic_loss_million_usd,
    "Avg Waste per Capita (Kg)" AS waste_per_capita_kg,
    "Household Waste (%)" AS household_waste_pct
FROM global_food_wastage_dataset
WHERE Country = 'Brazil'
ORDER BY Year DESC, waste_tons DESC;


-- ------------------------------------------------------------
-- 7. ECONOMIC IMPACT ANALYSIS
-- ------------------------------------------------------------
SELECT
    Country,
    SUM("Total Waste (Tons)") AS total_waste_tons,
    SUM("Economic Loss (Million $)") AS total_economic_loss_million_usd,
    ROUND(
        SUM("Economic Loss (Million $)") /
        NULLIF(SUM("Total Waste (Tons)"), 0),
    4) AS economic_loss_per_ton_usd
FROM global_food_wastage_dataset
GROUP BY Country
ORDER BY total_economic_loss_million_usd DESC
LIMIT 20;
