{%- set yaml_metadata -%}
source_model:
  t24: 'fbnk_account'
derived_columns:
  branch_id: co_code
  product_category: category
  source: "!t24_account"
  load_dts: current_timestamp
  effective_dts: created_ts::timestamp
hashed_columns:
  ACCOUNT_HK: recid
  CUSTOMER_HK: customer
  BRANCH_HK: branch_id
  HASHDIFF:
    is_hashdiff: true
    columns:
      - short_title
      - account_title_1
      - arabic_title
      - category
      - currency
      - opening_date
      - closure_date
      - record_status
      - closed_online
      - inactiv_marker
      - posting_restrict
      - limit_ref
      - account_officer
  ALT_HASHDIFF:
    is_hashdiff: true
    columns:
      - alt_acct_id_1
      - alt_acct_type_1
      - alt_acct_id_2
      - alt_acct_type_2
  CUSTOMER_ACCOUNT_HK:
    - customer
    - recid
  ACCOUNT_BRANCH_HK:
    - recid
    - branch_id
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(
    include_source_columns=true,
    source_model=metadata_dict['source_model'],
    hashed_columns=metadata_dict['hashed_columns'],
    derived_columns=metadata_dict['derived_columns']
) }}