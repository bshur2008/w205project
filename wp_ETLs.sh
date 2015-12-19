#!/usr/bin/env bash
PROJECT_HOME=/project

# DDL statements
hive -f $PROJECT_HOME/DDLs/wp_ddl.sql

# ETL flow
hive -f $PROJECT_HOME/ETLs/wp_load_from_raw.sql

