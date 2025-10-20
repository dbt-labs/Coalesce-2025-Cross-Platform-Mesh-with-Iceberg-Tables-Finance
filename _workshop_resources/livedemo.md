# Live Demo
Learn more: [dbt project dependencies](https://docs.getdbt.com/docs/mesh/govern/project-dependencies), [Iceberg catalogs](https://docs.getdbt.com/docs/mesh/iceberg/about-catalogs), [Snowflake catalog integrations](https://docs.getdbt.com/docs/mesh/iceberg/snowflake-iceberg-support).


## Cross-Project Dependencies
Add the `projects:` configuration to `dependencies.yml` file. 

```yml
projects:
  - name: xplat_foundation
```
## Cross-Project References
Setting up cross-project dependencies allows us to use cross-project references like the example below. 

```sql
select * from {{ ref('project_or_package', 'model_name') }}
```

## catalogs.yml
This step facilites write integrations for external catalogs by providing a `catalogs:` configuration specifying a catalog integration for your producer model.

1. Create a `catalogs.yml` file at the top level of your dbt project. 

2. Copy the `catalogs:` configuration below into the file.

```yml
catalogs:
  - name: iceberg_rest_catalog
    active_write_integration: databricks_rest_catalog
    write_integrations: 
      - name: databricks_rest_catalog
        external_volume: iceberg_databricks_us_west_2
        table_format: iceberg
        catalog_type: iceberg_rest
        adapter_properties:
          catalog_linked_database: coalesce_cross_platform_mesh_iceberg
```

## Model Configuration
Update the `models:` configuration in `dbt_project.yml` to include the `catalog_name`.

```yml
models:
  finance:
    # Applies to all files under models/marts/
    marts:
      +materialized: table
      +access: public
      +catalog_name: iceberg_rest_catalog

```

## Quoting Configuration
Add a `quoting:` configuration block to `dbt_project.yml`. 

```yml
quoting:
  database: false
  schema: true
  identifier: true
```
