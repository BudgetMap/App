CREATE TABLE asset (
  id SERIAL PRIMARY KEY,
  name TEXT,
  original_amount INTEGER,
  consumed_amount INTEGER
);

CREATE TABLE supplier (
  id SERIAL PRIMARY KEY,
  name TEXT,
  info TEXT
);

CREATE TABLE deal (
  id SERIAL PRIMARY KEY,
  supplier_id INTEGER references supplier(id),
  asset_id INTEGER references asset(id),
  deal_date date,
  conversion_value_usd float,
  main_products json,
  side_products json null
);

CREATE TABLE status (
  id SERIAL PRIMARY KEY,
  deal_id INTEGER references deal(id),
  paid_amount INTEGER null,
  delivered_products json null,
  notes text null,
);