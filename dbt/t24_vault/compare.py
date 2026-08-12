import duckdb, os

con = duckdb.connect()
con.execute("INSTALL ducklake; LOAD ducklake; INSTALL postgres; LOAD postgres; INSTALL httpfs; LOAD httpfs;")
con.execute(f"SET s3_endpoint='minio:9000'; SET s3_access_key_id='{os.environ['MINIO_ROOT_USER']}'; SET s3_secret_access_key='{os.environ['MINIO_ROOT_PASSWORD']}'; SET s3_use_ssl=false; SET s3_url_style='path';")
con.execute(f"ATTACH 'ducklake:postgres:dbname=ducklake_catalog host={os.environ['VAULT_DB_HOST']} port={os.environ['VAULT_DB_PORT']} user={os.environ['VAULT_DB_USER']} password={os.environ['VAULT_DB_PASSWORD']}' AS lake (DATA_PATH 's3://lake/')")

con.execute("CALL lake.set_option('data_inlining_row_limit', 0)")
print("option set")