-- ============================================================
-- Food Waste Analytics Pipeline
-- 01_exploration.sql
-- Initial exploration of FAO food waste data
-- Author: Pietro Masiero
-- ============================================================

-- ------------------------------------------------------------
-- 1. OVERVIEW: Total food waste by country (latest year)
-- ------------------------------------------------------------
SELECT
    area AS country,
    item AS food_category,
    year,
    value AS food_waste_tonnes,
    unit
FROM fao_food_waste
WHERE year = (SELECT MAX(year) FROM fao_food_waste)
ORDER BY food_waste_tonnes DESC
LIMIT 20;


-- ------------------------------------------------------------
-- 2. FOOD WASTE PER CAPITA by country
-- ------------------------------------------------------------
SELECT
    f.area AS country,
    f.year,
    f.value AS total_waste_tonnes,
    p.population,
    ROUND(f.value / p.population * 1000, 2) AS waste_kg_per_capita
FROM fao_food_waste f
LEFT JOIN fao_population p
    ON f.area = p.area AND f.year = p.year
WHERE f.year = (SELECT MAX(year) FROM fao_food_waste)
    AND p.population > 0
ORDER BY waste_kg_per_capita DESC
LIMIT 20;


-- ------------------------------------------------------------
-- 3. TREND ANALYSIS: Global food waste over time
-- ------------------------------------------------------------
SELECT
    year,
    SUM(value) AS total_global_waste_tonnes,
    COUNT(DISTINCT area) AS countries_reporting
FROM fao_food_waste
GROUP BY year
ORDER BY year ASC;


-- ------------------------------------------------------------
-- 4. WASTE BY FOOD CATEGORY
-- ------------------------------------------------------------
SELECT
    item AS food_category,
    SUM(value) AS total_waste_tonnes,
    ROUND(SUM(value) * 100.0 / SUM(SUM(value)) OVER (), 2) AS pct_of_total
FROM fao_food_waste
WHERE year = (SELECT MAX(year) FROM fao_food_waste)
GROUP BY item
ORDER BY total_waste_tonnes DESC;


-- ------------------------------------------------------------
-- 5. TOP 10 COUNTRIES WITH HIGHEST WASTE REDUCTION (YoY)
-- ------------------------------------------------------------
WITH yearly_waste AS (
    SELECT
        area AS country,
        year,
        SUM(value) AS total_waste
    FROM fao_food_waste
    GROUP BY area, year
),
yoy_change AS (
    SELECT
        country,
        year,
        total_waste,
        LAG(total_waste) OVER (PARTITION BY country ORDER BY year) AS prev_year_waste,
        ROUND(
            (total_waste - LAG(total_waste) OVER (PARTITION BY country ORDER BY year))
            / LAG(total_waste) OVER (PARTITION BY country ORDER BY year) * 100,
        2) AS pct_change
    FROM yearly_waste
)
SELECT
    country,
    year,
    total_waste,
    prev_year_waste,
    pct_change
FROM yoy_change
WHERE pct_change IS NOT NULL
    AND year = (SELECT MAX(year) FROM yoy_change)
ORDER BY pct_change ASC
LIMIT 10;


-- ------------------------------------------------------------
-- 6. BRAZIL DEEP DIVE
-- ------------------------------------------------------------
SELECT
    area AS country,
    item AS food_category,
    year,
    value AS waste_tonnes
FROM fao_food_waste
WHERE area = 'Brazil'
ORDER BY year DESC, waste_tonnes DESC;
