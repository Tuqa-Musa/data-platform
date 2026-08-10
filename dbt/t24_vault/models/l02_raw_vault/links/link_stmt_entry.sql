{%- set source_model = "stg_stmt_entry" -%}
{%- set src_pk = "stmt_entry_hk" -%}
{%- set src_fk = ["account_hk", "customer_hk", "branch_hk"] -%}
{%- set src_ldts = "load_dts" -%}
{%- set src_source = "source" -%}

{{ automate_dv.t_link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts, src_source=src_source, source_model=source_model) }}