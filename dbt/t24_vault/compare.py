import duckdb, os

con = duckdb.connect()
con.execute("INSTALL ducklake; LOAD ducklake; INSTALL postgres; LOAD postgres; INSTALL httpfs; LOAD httpfs;")
con.execute(f"SET s3_endpoint='minio:9000'; SET s3_access_key_id='{os.environ['MINIO_ROOT_USER']}'; SET s3_secret_access_key='{os.environ['MINIO_ROOT_PASSWORD']}'; SET s3_use_ssl=false; SET s3_url_style='path';")
con.execute(f"ATTACH 'ducklake:postgres:dbname=ducklake_catalog host={os.environ['VAULT_DB_HOST']} port={os.environ['VAULT_DB_PORT']} user={os.environ['VAULT_DB_USER']} password={os.environ['VAULT_DB_PASSWORD']}' AS lake (DATA_PATH 's3://lake/')")
print(con.execute("SELECT count(*) FROM lake.main.hub_customer").fetchall())
print(con.execute("SELECT count(*) FROM lake.main.link_customer_account").fetchall())
tables = ["hub_account","hub_customer","hub_branch",
          "link_customer_account","link_account_branch","link_customer_branch","link_stmt_entry",
          "sat_customer","sat_customer_individual","sat_customer_staff",
          "sat_customer_contact","sat_customer_corporate","sat_customer_status",
          "ref_hub_account_officer","ref_hub_product_category","ref_hub_transaction_code"]

for t in tables:
    print(t, con.execute(f"SELECT count(*) FROM lake.main.{t}").fetchall()[0][0])