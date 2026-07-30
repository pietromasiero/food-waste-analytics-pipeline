-- Replaces SQL query 4 from sql/02_analysis.sql:
--   total waste, economic loss and share of total by food category

with by_category as (
    select
        food_category,
        sum(total_waste_tons)              as total_waste_tons,
        sum(economic_loss_million_usd)     as total_economic_loss_million_usd,
        round(avg(avg_waste_per_capita_kg), 2) as avg_waste_per_capita_kg
    from {{ ref('stg_food_waste') }}
    group by food_category
),

with_share as (
    select
        *,
        round(
            total_waste_tons * 100.0 / sum(total_waste_tons) over (),
        2) as pct_of_total_waste
    from by_category
)

select * from with_share
order by total_waste_tons desc
