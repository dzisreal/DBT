# dbt_sample

Muc tieu: project dbt sample day du thanh phan (models, seeds, tests, macros, snapshots, analyses) su dung nguon data mien phi (du lieu sample tu seed, lay cam hung tu bo du lieu "jaffle shop" cua dbt).

## Cau truc
- models/staging: chuan hoa du lieu seed
- models/marts: bang su dung cho bao cao
- seeds: du lieu dau vao mien phi (CSV)
- macros: ham tien ich
- tests: data tests
- snapshots: luu lich su thay doi
- analyses: ghi chu/phan tich

## Cach chay (Postgres)
Can cai dat **dbt-postgres** (Python package). Demo su dung Postgres local (localhost:5432) voi 2 schema `dev` va `prod`.

Vi du:

```
export DBT_PROFILES_DIR=/home/dbt/dbt_sample
cd /home/dbt/dbt_sample

# dung .env (da duoc run_dev_prod.sh nap)
# POSTGRES_PASSWORD=postgres

# dev
dbt seed --target dev
dbt run --target dev
dbt test --target dev
dbt snapshot --target dev

# neu test pass thi chay prod
dbt seed --target prod
dbt run --target prod
dbt test --target prod
dbt snapshot --target prod
```

## Chay ClickHouse (Docker)
Khoi dong ClickHouse container va mount thu muc `users.d` de custom user/password:

```
docker run -d \
  --name clickhouse \
  -p 8123:8123 \
  -p 9000:9000 \
  -v $(pwd)/users.d:/etc/clickhouse-server/users.d \
  clickhouse/clickhouse-server:latest
```

## Data
Du lieu la sample, free to use, gom khach hang, don hang, thanh toan. Duoc tao tu seed CSV trong thu muc seeds/.

## Cau hinh Postgres (localhost)
Profile da duoc chuyen sang Postgres. Mat khau duoc lay tu bien moi truong `POSTGRES_PASSWORD` (co the dat trong file `.env`).

Thiet lap bien moi truong:
```
export POSTGRES_PASSWORD='postgres'
```

Hoac tao file `.env`:
```
POSTGRES_PASSWORD=postgres
```

Chay lenh dbt (dev/prod):
```
dbt seed --target dev
dbt run --target dev
dbt test --target dev

dbt seed --target prod
dbt run --target prod
dbt test --target prod
```

## Xu ly khi test fail (dev)
- Uu tien sua logic/data that su sai (model/seed)
- Neu test qua chat, dieu chinh test (them `where:` hoac logic phu hop business)
- Co the tam thoi set `severity: warn` cho test chua on dinh (nen co ke hoach nang lai)
- Dung `--store-failures` de xem ban ghi loi:
```
dbt test --target dev --store-failures
```
- Chay chon loc theo model truoc khi chay full:
```
dbt test --target dev --select model_name
```
