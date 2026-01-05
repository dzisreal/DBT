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

## Chay script run_dev_prod.sh
Script nay tu dong:
- Dat `DBT_PROFILES_DIR` ve thu muc hien tai.
- Nap bien moi truong tu `.env` (vd: `CLICKHOUSE_PASSWORD`).
- Chay dbt theo thu tu: `seed`, `run`, `test --store-failures`, `snapshot` cho `dev`.
- Hoi xac nhan de chay tiep `prod` neu test `dev` pass.

Chay:
```
./run_dev_prod.sh
```

## Data
Du lieu la sample, free to use, gom khach hang, don hang, thanh toan. Duoc tao tu seed CSV trong thu muc seeds/.

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
