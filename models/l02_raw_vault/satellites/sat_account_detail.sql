{%- set source_model = "stg_account" -%}
{%- set src_pk = "account_hk" -%}
{%- set src_hashdiff = "hashdiff" -%}
{%- set src_payload = ["short_title","account_title_1","arabic_title","category","currency","opening_date","closure_date","record_status","closed_online","inactiv_marker","posting_restrict","limit_ref","account_officer"] -%}
{%- set src_ldts = "load_dts" -%}
{%- set src_source = "source" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff, src_payload=src_payload, src_ldts=src_ldts, src_source=src_source, source_model=source_model) }}