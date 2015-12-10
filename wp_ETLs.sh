#!/usr/bin/env bash

# DDL statements
hive -f /project/DDLs/wp_etl.sql

# ETL flow
hive -f /project/ETLs/wp_load_from_raw.sql

