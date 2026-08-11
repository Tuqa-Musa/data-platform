import duckdb
import os

con = duckdb.connect()
con.execute("INSTALL postgres; LOAD postgres;")
con.execute(
    "ATTACH 'dbname={} host={} port={} user={} password={}' AS src (TYPE postgres, READ_ONLY)".format(
        os.environ["VAULT_DB_NAME"],
        os.environ["VAULT_DB_HOST"],
        os.environ["VAULT_DB_PORT"],
        os.environ["VAULT_DB_USER"],
        os.environ["VAULT_DB_PASSWORD"],
    )
)
print(con.execute("SELECT count(*) FROM src.public.fbnk_account").fetchall())
print(con.execute("SHOW ALL TABLES").fetchdf())