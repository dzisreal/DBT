#!/usr/bin/env bash
set -euo pipefail

export DBT_PROFILES_DIR=/home/dbt/dbt_sample
cd /home/dbt/dbt_sample

#set password cua connections output trong .env
if [ -f .env ]; then
  set -a
  . ./.env
  set +a
fi

echo "Run dev..."
dbt seed --target dev
dbt run --target dev
dbt test --target dev --store-failures
dbt snapshot --target dev

read -r -t 10 -p "Dev tests passed. Run prod? (y/yes) " confirm || confirm=""
confirm="$(printf "%s" "$confirm" | tr '[:upper:]' '[:lower:]')"
if [ "$confirm" = "y" ] || [ "$confirm" = "yes" ]; then
  echo "Run prod..."
  dbt seed --target prod
  dbt run --target prod
  dbt test --target prod --store-failures
  dbt snapshot --target prod
else
  echo "Skipped prod."
fi
