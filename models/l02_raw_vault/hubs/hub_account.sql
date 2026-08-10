{%- set source_model = "stg_account" -%}
{%- set src_pk = "account_hk" -%}
{%- set src_nk = "recid" -%}
{%- set src_ldts = "load_dts" -%}
{%- set src_source = "source" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts, src_source=src_source, source_model=source_model) }}