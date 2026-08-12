import os
from sqlalchemy import event
from sqlalchemy.engine import Engine

SECRET_KEY = os.environ.get("SUPERSET_SECRET_KEY")

CACHE_CONFIG = {
    "CACHE_TYPE": "RedisCache",
    "CACHE_DEFAULT_TIMEOUT": 300,
    "CACHE_KEY_PREFIX": "superset_",
    "CACHE_REDIS_HOST": "redis",
    "CACHE_REDIS_PORT": 6379,
    "CACHE_REDIS_DB": 1,
}

DATA_CACHE_CONFIG = CACHE_CONFIG

FEATURE_FLAGS = {
    "DASHBOARD_CROSS_FILTERS": True,
}


@event.listens_for(Engine, "connect")
def _attach_ducklake(dbapi_conn, connection_record):
    if not hasattr(dbapi_conn, "execute"):
        return
    try:
        dbapi_conn.execute(
            "INSTALL ducklake; LOAD ducklake; "
            "INSTALL postgres; LOAD postgres; "
            "INSTALL httpfs; LOAD httpfs;"
        )
        dbapi_conn.execute(
            f"SET s3_endpoint='minio:9000'; "
            f"SET s3_access_key_id='{os.environ['MINIO_ROOT_USER']}'; "
            f"SET s3_secret_access_key='{os.environ['MINIO_ROOT_PASSWORD']}'; "
            f"SET s3_use_ssl=false; SET s3_url_style='path';"
        )
        dbapi_conn.execute(
            f"ATTACH IF NOT EXISTS 'ducklake:postgres:"
            f"dbname=ducklake_catalog "
            f"host={os.environ['VAULT_DB_HOST']} "
            f"port={os.environ['VAULT_DB_PORT']} "
            f"user={os.environ['VAULT_DB_USER']} "
            f"password={os.environ['VAULT_DB_PASSWORD']}' "
            f"AS lake (DATA_PATH 's3://lake/')"
        )
    except Exception:
        pass