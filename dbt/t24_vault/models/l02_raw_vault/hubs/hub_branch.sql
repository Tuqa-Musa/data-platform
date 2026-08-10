{%- set source_model = ["stg_customer", "stg_account", "stg_stmt_entry"] -%}
{%- set src_pk = "branch_hk" -%}
{%- set src_nk = "branch_id" -%}
{%- set src_ldts = "load_dts" -%}
{%- set src_source = "source" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts, src_source=src_source, source_model=source_model) }}