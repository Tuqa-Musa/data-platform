{%- set source_model = "stg_ref_product_category" -%}
{%- set src_pk = "product_category" -%}
{%- set src_hashdiff = "hashdiff" -%}
{%- set src_payload = ["description"] -%}
{%- set src_ldts = "load_dts" -%}
{%- set src_source = "source" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff, src_payload=src_payload, src_ldts=src_ldts, src_source=src_source, source_model=source_model) }}
