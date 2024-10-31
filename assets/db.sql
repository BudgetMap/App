CREATE TABLE budget (
  id SERIAL PRIMARY KEY,
  budget_name TEXT,
  original_amount INTEGER,
  consumed_amount INTEGER,
  budget_number INTEGER
);

CREATE TABLE company (
  id SERIAL PRIMARY KEY,
  company_name TEXT,
  info TEXT
);

CREATE TABLE committee (
  id SERIAL PRIMARY KEY,
  committee_number INTEGER,
  budget_id INTEGER references budget(id),
  committee_date date,
  usd_exchange_rate float,
  committee_image_url TEXT,
  committee_image_path TEXT
);

CREATE TABLE image (
  id SERIAL PRIMARY KEY,
  name TEXT,
  url TEXT,
  path TEXT
);
