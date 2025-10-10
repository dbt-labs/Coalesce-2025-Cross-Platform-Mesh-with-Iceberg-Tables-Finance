{% macro generate_schema_name(custom_schema_name, node) %}

    {% set default_schema = target.schema | replace('_', '') ~ 'snow' %}

    {# seeds go in a global raw schema (underscores removed) #}
    {% if node.resource_type == 'seed' %}
        {{ custom_schema_name | trim | replace('_', '') }}

    {# non-specified schemas go to the default target schema #}
    {% elif custom_schema_name is none %}
        {{ default_schema }}

    {# specified custom schema names go to the schema name prepended with the default schema name in prod #}
    {% elif target.name == 'prod' %}
        {{ (default_schema ~ custom_schema_name | trim) | replace('_', '') }}

    {# specified custom schemas go to the default target schema for non-prod targets #}
    {% else %}
        {{ default_schema }}
    {% endif %}

{% endmacro %}