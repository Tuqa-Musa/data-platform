{%- set yaml_metadata -%}
source_model:
  t24: 'fbnk_customer'
derived_columns:
  customer_id: "split_part(recid, ';', 1)"
  branch_id: company_book
  source: "!t24_customer"
  load_dts: "current_timestamp + (cast(curr_no as integer) * interval '1 second')" 
hashed_columns:
  CUSTOMER_HK: customer_id
  BRANCH_HK: branch_id
  HASHDIFF:
    is_hashdiff: true
    columns:
      - short_name
      - arabic_name
      - birth_incorp_date
      - id_type
      - id_number
      - nationality
      - sector
      - opening_date
      - account_officer
  INDIVIDUAL_HASHDIFF:
    is_hashdiff: true
    columns:
      - genders
      - nat_security_number
      - profession
  CORPORATE_HASHDIFF:
    is_hashdiff: true
    columns:
      - commercial_registration_no
      - licence_expiry_date
  STATUS_HASHDIFF:
    is_hashdiff: true
    columns:
      - customer_status
      - risk_rate
      - drmnt_code
      - drmnt_date
      - posting_restrict_1
      - posting_restrict_2
      - peps
  STAFF_HASHDIFF:
    is_hashdiff: true
    columns:
      - emploee_no
  CONTACT_HASHDIFF:
    is_hashdiff: true
    columns:
      - telephone_1
      - telephone_2
      - sms_1
      - email_address
      - email_1
  CUSTOMER_BRANCH_HK:
    - customer_id
    - branch_id
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(
    include_source_columns=true,
    source_model=metadata_dict['source_model'],
    hashed_columns=metadata_dict['hashed_columns'],
    derived_columns=metadata_dict['derived_columns']
) }}