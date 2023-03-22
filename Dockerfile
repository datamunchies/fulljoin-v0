# this is a test Dockerfile -- DO NOT USE YET
FROM python:3.11.1-slim-bullseye as base

# will install only dbt-core and dbt-bigquery adapter
ARG dbt_core_ref=dbt-core
ARG dbt_bigquery_ref=dbt-bigquery
ARG dbt_clickhouse_ref=dbt-clickhouse

# System setup
RUN apt-get update -y && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends -y -q \
    zsh \
    git \
    ssh-client \
    build-essential \
    ca-certificates \
    libpq-dev && \
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8
ENV DBT_DIR /dbt

# Update python
RUN python -m pip install --upgrade pip setuptools wheel --no-cache-dir

# Set docker basics
WORKDIR $DBT_DIR
VOLUME /dbt

# install dbt-core
FROM base as dbt-core
RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/${dbt_core_ref}#egg=dbt-core&subdirectory=core"

# install dbt-bigquery
FROM base as dbt-bigquery
RUN python -m pip install --no-cache-dir "git+https://github.com/dbt-labs/${dbt_bigquery_ref}#egg=dbt-bigquery"

# install dbt-clickhouse
FROM base as dbt-clickhouse
RUN python -m pip install --no-cache-dir "git+https://github.com/ClickHouse/${dbt_clickhouse_ref}#egg=dbt-clickhouse"

COPY ./dbt_project.yml /dbt/dbt_project.yml
COPY ./models /dbt/models
COPY ./macros /dbt/macros
COPY ./tests /dbt/tests
COPY ./logs /dbt/logs

# ENTRYPOINT ["dbt"]
ENTRYPOINT ["/bin/zsh"]