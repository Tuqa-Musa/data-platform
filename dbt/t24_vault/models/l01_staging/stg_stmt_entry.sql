{%- set yaml_metadata -%}
source_model: 'fbnk_stmt_entry'
derived_columns:
  branch_id: company_code
  source: "!t24_stmt_entry"
  load_dts: CURRENT_TIMESTAMP
hashed_columns:
  STMT_ENTRY_HK: recid
  ACCOUNT_HK: account_number
  CUSTOMER_HK: customer_id
  BRANCH_HK: branch_id
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(
    include_source_columns=true,
    source_model=metadata_dict['source_model'],
    hashed_columns=metadata_dict['hashed_columns'],
    derived_columns=metadata_dict['derived_columns']
) }}