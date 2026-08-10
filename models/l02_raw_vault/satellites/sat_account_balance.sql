{{ config(materialized='incremental', unique_key=['account_hk','load_dts','curr_no']) }}

select
    account_hk,
    load_dts,
    curr_no,
    online_actual_bal,
    online_cleared_bal,
    open_actual_bal,
    working_balance,
    prev_bal,
    effective_dts,
    source as record_source
from {{ ref('stg_account') }}

{% if is_incremental() %}
where load_dts > (select coalesce(max(load_dts), cast('1900-01-01 00:00:00' as timestamp)) from {{ this }})
{% endif %}