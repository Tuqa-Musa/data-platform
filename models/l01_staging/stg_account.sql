with source_data as (

    select * from {{ ref('fbnk_account') }}

),

derived_columns as (

    select
        *,
        co_code            as branch_id,
        category           as product_category,
        't24_account'      as source,
        current_timestamp  as load_dts,
        created_ts::timestamp as effective_dts
    from source_data

),

hashed_columns as (

    select
        *,

        -- Hub hash keys
        decode(md5(coalesce(upper(trim(cast(recid as varchar))), '^^')), 'hex')     as account_hk,
        decode(md5(coalesce(upper(trim(cast(customer as varchar))), '^^')), 'hex')  as customer_hk,
        decode(md5(coalesce(upper(trim(cast(branch_id as varchar))), '^^')), 'hex') as branch_hk,

        -- Link hash keys — column order as defined (not alphabetized)
        decode(md5(
            coalesce(upper(trim(cast(customer as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(recid as varchar))), '^^')
        ), 'hex') as customer_account_hk,

        decode(md5(
            coalesce(upper(trim(cast(recid as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(branch_id as varchar))), '^^')
        ), 'hex') as account_branch_hk,

        -- HASHDIFF — columns sorted alphabetically (automate_dv default)
        decode(md5(
            coalesce(upper(trim(cast(account_officer as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(account_title_1 as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(arabic_title as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(category as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(closed_online as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(closure_date as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(currency as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(inactiv_marker as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(limit_ref as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(opening_date as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(posting_restrict as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(record_status as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(short_title as varchar))), '^^')
        ), 'hex') as hashdiff,

        -- ALT_HASHDIFF — columns sorted alphabetically
        decode(md5(
            coalesce(upper(trim(cast(alt_acct_id_1 as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(alt_acct_id_2 as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(alt_acct_type_1 as varchar))), '^^') || '||' ||
            coalesce(upper(trim(cast(alt_acct_type_2 as varchar))), '^^')
        ), 'hex') as alt_hashdiff

    from derived_columns

)

select * from hashed_columns