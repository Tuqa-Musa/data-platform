from datetime import datetime
from pathlib import Path

from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig, RenderConfig
from cosmos.constants import TestBehavior, LoadMode

DBT_PROJECT_PATH = Path("/opt/airflow/dbt/t24_vault")

profile_config = ProfileConfig(
    profile_name="t24_vault",
    target_name="lake",
    profiles_yml_filepath=DBT_PROJECT_PATH / "profiles.yml",
)

t24_vault_dag = DbtDag(
    dag_id="t24_vault",
    project_config=ProjectConfig(
        dbt_project_path=DBT_PROJECT_PATH,
        manifest_path=DBT_PROJECT_PATH / "target" / "manifest.json",
    ),
    profile_config=profile_config,
    execution_config=ExecutionConfig(
        dbt_executable_path="/home/airflow/.local/bin/dbt",
    ),
    render_config=RenderConfig(
        load_method=LoadMode.DBT_MANIFEST,
        test_behavior=TestBehavior.AFTER_ALL,
    ),
    schedule=None,
    start_date=datetime(2026, 1, 1),
    catchup=False,
    tags=["dbt", "data-vault"],
)