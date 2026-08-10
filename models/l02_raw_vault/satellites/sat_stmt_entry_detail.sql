{{ config(materialized='incremental', unique_key='stmt_entry_hk') }}

select
    stmt_entry_hk,
    load_dts,
    recid as stmt_entry_id,
    transaction_code,
    product_category,
    currency,
    amount_lcy,
    amount_fcy,
    exchange_rate,
    booking_date,
    value_date,
    processing_date,
    exposure_date,
    system_date_time,
    our_reference,
    their_reference,
    trans_reference,
    reversal_marker,
    narrative,
    cheque_number,
    chq_type,
    counterparty,
    account_officer,
    position_type,
    system_id,
    source as record_source
from {{ ref('stg_stmt_entry') }}

{% if is_incremental() %}
where stmt_entry_hk not in (select stmt_entry_hk from {{ this }})
{% endif %}