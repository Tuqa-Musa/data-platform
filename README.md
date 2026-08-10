# T24 Data Vault 2.0

A Data Vault 2.0 implementation in dbt over Temenos T24 core banking data, running on PostgreSQL.

## Structure

- `models/l01_staging/` — staging models with hash key generation
- `models/l02_raw_vault/` — hubs, links, and satellites
  - `hubs/` — business entities (customer, account, branch) plus reference hubs
  - `links/` — relationships between hubs, including a transactional link for statement entries
  - `satellites/` — descriptive attributes, historized and non-historized

## Sources

Three T24 tables: `fbnk_customer`, `fbnk_account`, `fbnk_stmt_entry`, plus reference code lists.

## Built with

- dbt-core with the postgres adapter
- [AutomateDV](https://automate-dv.readthedocs.io/) for hub/link/satellite macros
- dbt_utils for composite key testing

## Running

```bash
dbt deps
dbt seed
dbt run
dbt test
```
