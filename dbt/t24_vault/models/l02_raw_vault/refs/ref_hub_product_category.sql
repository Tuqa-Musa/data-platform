{%- set source_model = ["stg_ref_product_category", "stg_account", "stg_stmt_entry"] -%}
{%- set src_pk = "product_category" -%}
{%- set src_nk = "product_category" -%}
{%- set src_ldts = "load_dts" -%}
{%- set src_source = "source" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts, src_source=src_source, source_model=source_model) }}