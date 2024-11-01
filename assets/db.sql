CREATE TABLE
  budget (
    id SERIAL PRIMARY KEY,
    budget_name TEXT,
    original_amount INTEGER,
    consumed_amount INTEGER,
    budget_number INTEGER
  );

CREATE TABLE
  company (
    id SERIAL PRIMARY KEY,
    company_name TEXT,
    info TEXT
  );

CREATE TABLE
  committee (
    id SERIAL PRIMARY KEY,
    committee_number INTEGER,
    budget_id INTEGER REFERENCES budget (id) on delete cascade,
    committee_date DATE,
    usd_exchange_rate FLOAT,
    committee_image_url TEXT,
    committee_image_path TEXT
  );

CREATE TABLE
  deal (
    id SERIAL PRIMARY KEY,
    committee_id INTEGER REFERENCES committee (id) on delete cascade,
    company_id INTEGER REFERENCES company (id) on delete cascade,
    main_products JSONB,
    side_products JSONB,
    paid_amount INTEGER,
    notes TEXT
  );

CREATE TABLE
  image (
    id SERIAL PRIMARY KEY,
    NAME TEXT,
    url TEXT,
    path TEXT
  );
