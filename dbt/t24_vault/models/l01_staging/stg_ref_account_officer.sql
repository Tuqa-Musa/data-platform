{%- set yaml_metadata -%}
source_model:
  t24: 'ref_account_officer'
derived_columns:
  source: "!ref_account_officer"
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
