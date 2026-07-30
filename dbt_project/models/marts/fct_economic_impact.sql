-- Replaces SQL query 7 from sql/02_analysis.sql:
--   total waste, total economic loss and loss-per-ton by country

with by_country as (
    select
        country,
        sum(total_waste_tons)          as total_waste_tons,
        sum(economic_loss_million_usd) as total_economic_loss_million_usd
    from {{ ref('stg_food_waste') }}
    group by country
)

select
    country,
    total_waste_tons,
    total_economic_loss_million_usd,
    round(
        total_economic_loss_million_usd / nullif(total_waste_tons, 0),
    4) as economic_loss_per_ton_usd
from by_country
order by total_economic_loss_million_usd desc
