{%- set yaml_metadata -%}
source_model: 'ref_transaction_code'
derived_columns:
  source: "!ref_transaction_code"
  load_dts: CURRENT_TIMESTAMP
hashed_columns:
  HASHDIFF:
    is_hashdiff: true
    columns:
      - description
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(
    include_source_columns=true,
    source_model=metadata_dict['source_model'],
    hashed_columns=metadata_dict['hashed_columns'],
    derived_columns=metadata_dict['derived_columns']
) }}
