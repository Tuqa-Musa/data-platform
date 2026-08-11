{#- DuckDB adapter shims for AutomateDV 0.11.5.
    AutomateDV ships postgres/snowflake/bigquery/databricks/sqlserver
    implementations but no default, so on DuckDB dbt's dispatch finds
    nothing and errors. These supply the DuckDB equivalents. -#}

{%- macro duckdb__cast_date(column_str, as_string=false, alias=none) -%}
    {%- if as_string -%}
        TO_DATE('{{ column_str }}', 'YYYY-MM-DD')
    {%- else -%}
        TO_DATE({{ column_str }}::VARCHAR, 'YYYY-MM-DD')
    {%- endif -%}
    {%- if alias %} AS {{ alias }}{%- endif %}
{%- endmacro -%}

{%- macro duckdb__cast_datetime(column_str, as_string=false, alias=none, date_type=none) -%}
    strftime(CAST({{ column_str }} AS TIMESTAMP), '%Y-%m-%d %H:%M:%S.%g')::TIMESTAMP
    {%- if alias %} AS {{ alias }}{%- endif %}
{%- endmacro -%}

{%- macro duckdb__get_escape_characters() %}
    {%- do return (('"', '"')) -%}
{%- endmacro %}

{#- Hash algorithm. Snowflake's default uses MD5_BINARY, which DuckDB lacks.
    Postgres uses DECODE(MD5(x), 'hex') -> BYTEA; DuckDB's equivalent is
    UNHEX(MD5(x)) -> BLOB, producing the same 16 bytes. -#}

{% macro duckdb__hash_alg_md5() -%}
    {% do return("UNHEX(MD5([HASH_STRING_PLACEHOLDER]))") %}
{% endmacro %}

{% macro duckdb__hash_alg_sha1() -%}
    {% do return("UNHEX(SHA1([HASH_STRING_PLACEHOLDER]))") %}
{% endmacro %}

{% macro duckdb__hash_alg_sha256() -%}
    {% do return("UNHEX(SHA256([HASH_STRING_PLACEHOLDER]))") %}
{% endmacro %}

{#- Binary type. Snowflake default is BINARY(16), Postgres is BYTEA.
    DuckDB's binary type is BLOB and takes no length parameter. -#}

{%- macro duckdb__type_binary(for_dbt_compare=false) -%}
    BLOB
{%- endmacro -%}