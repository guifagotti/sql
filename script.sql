-- create the company table
CREATE TABLE companies (
  company_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  edited_by_user_id INT NOT NULL,
  email VARCHAR(50) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  active BOOLEAN NOT NULL DEFAULT true,
  created_date TIMESTAMP WITH TIME ZONE NOT NULL,
  edited_date TIMESTAMP WITH TIME ZONE NOT NULL
);

-- create the crop table
CREATE TABLE crops (
  crop_id SERIAL PRIMARY KEY,
  farm_id INT NOT NULL,
  edited_by_user_id INT NOT NULL,
  harvest_id INT,
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
  producer_id INT,
  receiver VARCHAR(50),
  storage_id INT,
  created_date TIMESTAMP WITH TIME ZONE NOT NULL,
  edited_date TIMESTAMP WITH TIME ZONE NOT NULL,
  total_discount VARCHAR,
  net_weight_discount_kg VARCHAR,
  net_weight_discount_sc VARCHAR,
  talhao_id INT,
  active BOOLEAN NOT NULL DEFAULT true
);

-- create the role table
CREATE TABLE roles (
  role_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  page1 BOOLEAN NOT NULL,
  page2 BOOLEAN NOT NULL
);

-- create the user table
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  company_id INT NOT NULL,
  role_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  password VARCHAR(5000) NOT NULL,
  created_date TIMESTAMP WITH TIME ZONE NOT NULL,
  edited_date TIMESTAMP WITH TIME ZONE NOT NULL,
  password_salt VARCHAR(5000) NOT NULL,
  verified BOOLEAN NOT NULL,
  mail_token VARCHAR(5000),
  mail_token_data TIMESTAMP WITH TIME ZONE,
  active BOOLEAN NOT NULL DEFAULT false,
  account_status INT NOT NULL DEFAULT 0
);

-- create the farm table
CREATE TABLE farms (
farm_id SERIAL PRIMARY KEY,
farm_name VARCHAR(50) NOT NULL,
company_id INT NOT NULL,
state VARCHAR(50),
city VARCHAR(50),
address VARCHAR(250),
zipcode VARCHAR(10),
created_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_by_user_id INT NOT NULL,
farm_type_id INT NOT NULL,
active BOOLEAN NOT NULL DEFAULT true
);

-- create the farm types table
CREATE TABLE farm_types (
farm_type_id SERIAL PRIMARY KEY,
farm_type_name VARCHAR(50) NOT NULL,
created_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_by_user_id INT NOT NULL,
active BOOLEAN NOT NULL DEFAULT true
);

-- create the crops table
CREATE TABLE crops (
crop_id SERIAL PRIMARY KEY,
crop_name VARCHAR(50) NOT NULL,
farm_id INT NOT NULL,
created_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_by_user_id INT NOT NULL,
active BOOLEAN NOT NULL DEFAULT true,
FOREIGN KEY (farm_id) REFERENCES farms(farm_id)
);

-- create the units table
CREATE TABLE units (
unit_id SERIAL PRIMARY KEY,
unit_name VARCHAR(50) NOT NULL,
created_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_by_user_id INT NOT NULL,
active BOOLEAN NOT NULL DEFAULT true
);

-- create the crops_units table
CREATE TABLE crops_units (
crop_id INT NOT NULL,
unit_id INT NOT NULL,
created_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_by_user_id INT NOT NULL,
active BOOLEAN NOT NULL DEFAULT true,
FOREIGN KEY (crop_id) REFERENCES crops(crop_id),
FOREIGN KEY (unit_id) REFERENCES units(unit_id)
);

-- create the activities table
CREATE TABLE activities (
activity_id SERIAL PRIMARY KEY,
activity_name VARCHAR(50) NOT NULL,
crop_id INT NOT NULL,
created_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_by_user_id INT NOT NULL,
active BOOLEAN NOT NULL DEFAULT true,
FOREIGN KEY (crop_id) REFERENCES crops(crop_id)
);

-- create the activity types table
CREATE TABLE activity_types (
activity_type_id SERIAL PRIMARY KEY,
activity_type_name VARCHAR(50) NOT NULL,
created_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_by_user_id INT NOT NULL,
active BOOLEAN NOT NULL DEFAULT true
);

-- create the activities_types table
CREATE TABLE activities_types (
activity_id INT NOT NULL,
activity_type_id INT NOT NULL,
created_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_by_user_id INT NOT NULL,
active BOOLEAN NOT NULL DEFAULT true,
FOREIGN KEY (activity_id) REFERENCES activities(activity_id),
FOREIGN KEY (activity_type_id) REFERENCES activity_types(activity_type_id)
);

-- create the supplies table
CREATE TABLE supplies (
supply_id SERIAL PRIMARY KEY,
supply_name VARCHAR(50) NOT NULL,
created_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_date TIMESTAMP NOT NULL DEFAULT NOW(),
edited_by_user_id INT NOT NULL,
active BOOLEAN NOT NULL DEFAULT true
);

-- create the crops_supplies table
CREATE TABLE crops_supplies (
  crops_supplies_id SERIAL PRIMARY KEY,
  crop_id INTEGER NOT NULL,
  supply_id INTEGER NOT NULL,
  quantity NUMERIC NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_crop
    FOREIGN KEY (crop_id)
    REFERENCES crops (crop_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_supply
    FOREIGN KEY (supply_id)
    REFERENCES supplies (supply_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- create the users table
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  password VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- create the sessions table
CREATE TABLE sessions (
  session_id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  token VARCHAR(100) NOT NULL,
  expiration TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_user
    FOREIGN KEY (user_id)
    REFERENCES users (user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- create the orders table
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  order_total NUMERIC NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_user
    FOREIGN KEY (user_id)
    REFERENCES users (user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- create the order_items table
CREATE TABLE order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id INTEGER NOT NULL,
  crop_id INTEGER NOT NULL,
  quantity NUMERIC NOT NULL,
  price_per_unit NUMERIC NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_order
    FOREIGN KEY (order_id)
    REFERENCES orders (order_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_crop
    FOREIGN KEY (crop_id)
    REFERENCES crops (crop_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
