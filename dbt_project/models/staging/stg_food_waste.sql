-- Staging model: cleans and standardizes the raw seed data.
-- Source: Global Food Wastage Dataset (2018-2024), Kaggle - Atharva Soundankar

with source as (
    select * from {{ ref('global_food_wastage_dataset') }}
),

cleaned as (
    select
        trim(country)                          as country,
        year,
        trim(food_category)                    as food_category,
        total_waste_tons,
        economic_loss_million_usd,
        avg_waste_per_capita_kg,
        population_million,
        household_waste_pct,

        -- derived: economic loss per ton (USD), guarding against divide-by-zero
        case
            when total_waste_tons > 0
                then round(economic_loss_million_usd / total_waste_tons, 4)
            else null
        end as economic_loss_per_ton_usd

    from source
)

select * from cleaned
