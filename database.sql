-- create the company table
CREATE TABLE IF NOT EXISTS company (
  company_id SERIAL PRIMARY KEY,
  company_name VARCHAR(50) NOT NULL,
  edited_by_user_id INTEGER NOT NULL,
  email VARCHAR(50) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  created_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  edited_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- create the roles table
CREATE TABLE IF NOT EXISTS roles (
  role_id SERIAL PRIMARY KEY,
  role_name VARCHAR(50) NOT NULL,
  page1 BOOLEAN NOT NULL,
  page2 BOOLEAN NOT NULL
);

-- create the user table
CREATE TABLE IF NOT EXISTS users (
  user_id SERIAL PRIMARY KEY,
  company_id INTEGER NOT NULL,
  role_id INTEGER NOT NULL,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  password VARCHAR(5000) NOT NULL,
  created_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  edited_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  password_salt VARCHAR(5000) NOT NULL,
  verified BOOLEAN NOT NULL,
  email_token VARCHAR(5000),
  email_token_data TIMESTAMP WITH TIME ZONE,
  active BOOLEAN NOT NULL DEFAULT false,
  account_status INTEGER NOT NULL DEFAULT 0
);

-- create the farm table
CREATE TABLE IF NOT EXISTS farms (
  farm_id SERIAL PRIMARY KEY,
  company_id INTEGER NOT NULL,
  edited_by_user_id INTEGER NOT NULL,
  farm_name VARCHAR(50) NOT NULL,
  inscricao_estadual BIGINT,
  area INTEGER,
  address VARCHAR(250),
  state VARCHAR(50),
  created_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  edited_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  farm_type INTEGER NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

-- create the crops table
CREATE TABLE IF NOT EXISTS crops (
  crop_id SERIAL PRIMARY KEY,
  farm_id INTEGER NOT NULL,
  edited_by_user_id INTEGER NOT NULL,
  safra_id INTEGER,
  date DATE NOT NULL,
  talhao VARCHAR(50),
  ie VARCHAR(50),
  ticket NUMERIC,
  net_weight NUMERIC,
  impurity VARCHAR(50),
  moisture VARCHAR(50),
  driver VARCHAR(50),
  license_plate VARCHAR(50),
  shipping_cost NUMERIC,
  producer_id INTEGER,
  receiver VARCHAR(50),
  storage_id INTEGER,
  created_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  edited_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  total_discount VARCHAR(50),
  net_weight_discount_kg VARCHAR(50),
  net_weight_discount_sc VARCHAR(50),
  talhao_id INTEGER,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

-- create the crops_supplies table
CREATE TABLE IF NOT EXISTS crops_supplies (
  crops_supplies_id SERIAL PRIMARY KEY,
  crop_id INTEGER NOT NULL,
  edited_by_user_id INTEGER NOT NULL,
  supply_date DATE NOT NULL,
  supply_type INTEGER NOT NULL,
  product_name VARCHAR(50),
  product_quantity NUMERIC,
  product_price NUMERIC,
  created_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  edited_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  active BOOLEAN NOT NULL DEFAULT TRUE
);

-- create the harvest table
CREATE TABLE IF NOT EXISTS harvest (
  safra_id serial PRIMARY KEY NOT NULL,
  farm_id int NOT NULL,
  agricultural_year varchar(50) NOT NULL,
  grain varchar(50) NOT NULL,
  tax_type varchar,
  area_harvested int,
  created_by_user_id int NOT NULL,
  created_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  edited_by_user_id int NOT NULL,
  edited_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  active boolean NOT NULL DEFAULT TRUE,
  FOREIGN KEY (farm_id) REFERENCES farms (farm_id),
  FOREIGN KEY (created_by_user_id) REFERENCES users (user_id),
  FOREIGN KEY (edited_by_user_id) REFERENCES users (user_id)
);

-- create the assets table
CREATE TABLE IF NOT EXISTS assets (
  asset_id serial PRIMARY KEY NOT NULL,
  edited_by_user_id int NOT NULL,
  safra_id int,
  asset_type varchar(50) NOT NULL,
  asset_type_machine varchar(50),
  capacity varchar(50),
  model varchar(50),
  manufacturer varchar(50),
  year_manufacture varchar(50),
  year_acquisition varchar(50),
  current_value numeric,
  obs varchar(50),
  depreciation numeric NOT NULL,
  agricultural_year varchar(20),
  active boolean NOT NULL DEFAULT TRUE,
  created_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  edited_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (safra_id) REFERENCES harvest (safra_id),
  FOREIGN KEY (edited_by_user_id) REFERENCES users (user_id)
);

-- create the employees table
CREATE TABLE IF NOT EXISTS employees (
  employee_id serial PRIMARY KEY NOT NULL,
  farm_id int NOT NULL,
  employee_name varchar(50),
  function varchar(50),
  gross_salary numeric,
  commission_soybean varchar(50),
  value_soybean varchar(50),
  commission_corn varchar(50),
  value_corn varchar(50),
  total_annual numeric,
  total_monthly numeric,
  edited_by_user_id int NOT NULL,
  created_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  edited_date timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  active boolean NOT NULL DEFAULT TRUE,
  FOREIGN KEY (farm_id) REFERENCES farms (farm_id),
  FOREIGN KEY (edited_by_user_id) REFERENCES users (user_id)
);

-- create the crops_supplies table
CREATE TABLE crops_supplies (
    farm_id INTEGER NOT NULL,
    supply_date TIMESTAMP NOT NULL,
    supply_description VARCHAR(255) NOT NULL,
    supplier_id INTEGER NOT NULL,
    supply_quantity DECIMAL(15, 2) NOT NULL,
    supply_price DECIMAL(15, 2) NOT NULL,
    total_price DECIMAL(15, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW() NOT NULL,
    CONSTRAINT pk_crops_supplies PRIMARY KEY (farm_id, supply_date),
    CONSTRAINT fk_crops_supplies_farms FOREIGN KEY (farm_id) REFERENCES farms(id) ON DELETE CASCADE,
    CONSTRAINT fk_crops_supplies_suppliers FOREIGN KEY (supplier_id) REFERENCES suppliers(id),
    INDEX idx_crops_supplies_farm_id (farm_id),
    INDEX idx_crops_supplies_supplier_id (supplier_id)
);

COMMENT ON TABLE crops_supplies IS 'Table to store information about crops supplies.';
COMMENT ON COLUMN crops_supplies.farm_id IS 'The ID of the farm where the supply was received.';
COMMENT ON COLUMN crops_supplies.supply_date IS 'The date when the supply was received.';
COMMENT ON COLUMN crops_supplies.supply_description IS 'A description of the supply.';
COMMENT ON COLUMN crops_supplies.supplier_id IS 'The ID of the supplier who provided the supply.';
COMMENT ON COLUMN crops_supplies.supply_quantity IS 'The quantity of the supply received.';
COMMENT ON COLUMN crops_supplies.supply_price IS 'The price per unit of the supply.';
COMMENT ON COLUMN crops_supplies.total_price IS 'The total price of the supply.';
COMMENT ON COLUMN crops_supplies.created_at IS 'The date and time when the supply record was created.';
COMMENT ON COLUMN crops_supplies.updated_at IS 'The date and time when the supply record was last updated.';


