{%- set source_model = "stg_account" -%}
{%- set src_pk = "account_hk" -%}
{%- set src_hashdiff = "alt_hashdiff" -%}
{%- set src_payload = ["alt_acct_id_1","alt_acct_type_1","alt_acct_id_2","alt_acct_type_2"] -%}
{%- set src_ldts = "load_dts" -%}
{%- set src_source = "source" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff, src_payload=src_payload, src_ldts=src_ldts, src_source=src_source, source_model=source_model) }}