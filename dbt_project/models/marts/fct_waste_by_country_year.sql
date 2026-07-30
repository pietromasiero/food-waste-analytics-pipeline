-- Replaces SQL queries 1, 2, 3 and 5 from sql/02_analysis.sql:
--   - total waste and economic loss by country/year
--   - avg waste per capita and household waste %
--   - year-over-year % change in total waste

with country_year as (
    select
        country,
        year,
        sum(total_waste_tons)              as total_waste_tons,
        sum(economic_loss_million_usd)     as total_economic_loss_million_usd,
        round(avg(avg_waste_per_capita_kg), 2) as avg_waste_per_capita_kg,
        round(avg(household_waste_pct), 2)     as avg_household_waste_pct
    from {{ ref('stg_food_waste') }}
    group by country, year
),

with_yoy as (
    select
        *,
        lag(total_waste_tons) over (
            partition by country order by year
        ) as prev_year_waste_tons,

        round(
            (total_waste_tons - lag(total_waste_tons) over (
                partition by country order by year
            ))
            / nullif(lag(total_waste_tons) over (
                partition by country order by year
            ), 0) * 100,
        2) as pct_change_yoy

    from country_year
)

select * from with_yoy
order by country, year
