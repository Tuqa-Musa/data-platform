{%- set source_model = "stg_customer" -%}
{%- set src_pk = "customer_hk" -%}
{%- set src_hashdiff = "corporate_hashdiff" -%}
{%- set src_payload = ["commercial_registration_no","licence_expiry_date"] -%}
{%- set src_ldts = "load_dts" -%}
{%- set src_source = "source" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff, src_payload=src_payload, src_ldts=src_ldts, src_source=src_source, source_model=source_model) }}