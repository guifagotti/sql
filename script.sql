CREATE TABLE "company" (
  "companyID" int4 PRIMARY KEY NOT NULL DEFAULT (nextval('company_id_seq'::regclass)),
  "companyName" varchar(50) NOT NULL,
  "editedByUserID" int4 NOT NULL,
  "mail" varchar(50) NOT NULL,
  "phone" varchar(50) NOT NULL,
  "active" bool NOT NULL DEFAULT 1,
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL
);

CREATE TABLE "crops" (
  "cropsID" serial4 PRIMARY KEY NOT NULL,
  "farmID" int4 NOT NULL,
  "editedByUserID" int4 NOT NULL,
  "safraID" int4,
  "date" date NOT NULL,
  "talhao" varchar(50),
  "ie" varchar(50),
  "ticket" numeric,
  "netweight" numeric,
  "impurity" varchar(50),
  "moisture" varchar(50),
  "driver" varchar(50),
  "licenseplate" varchar(50),
  "shippingcost" numeric,
  "producerID" int4,
  "receiver" varchar(50),
  "storageID" int4,
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL,
  "totalDiscount" varchar,
  "netWeightDiscountKg" varchar,
  "netWeightDiscountSc" varchar,
  "talhaoID" int4,
  "active" bool NOT NULL DEFAULT 1
);

CREATE TABLE "roles" (
  "roleID" serial4 PRIMARY KEY NOT NULL,
  "roleName" varchar(50) NOT NULL,
  "page1" bit(1) NOT NULL,
  "page2" bit(1) NOT NULL
);

CREATE TABLE "user" (
  "userID" serial4 PRIMARY KEY NOT NULL,
  "companyID" int4 NOT NULL,
  "roleID" int4 NOT NULL,
  "name" varchar(100) NOT NULL,
  "mail" varchar(100) NOT NULL,
  "phone" varchar(50) NOT NULL,
  "pass" varchar(5000) NOT NULL,
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL,
  "passwordsalt" varchar(5000) NOT NULL,
  "verified" bool NOT NULL,
  "mailToken" varchar(5000),
  "mailTokenData" timestamptz,
  "active" bool NOT NULL DEFAULT false,
  "accountStatus" int4 NOT NULL DEFAULT 0
);

CREATE TABLE "farm" (
  "farmID" serial4 PRIMARY KEY NOT NULL,
  "companyID" int4 NOT NULL,
  "editedByUserID" int4 NOT NULL,
  "farmName" varchar(50) NOT NULL,
  "inscricaoEstadual" int8,
  "area" int4,
  "address" varchar(250),
  "state" varchar(50),
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL,
  "farmType" int4 NOT NULL,
  "active" bool NOT NULL DEFAULT 1
);

CREATE TABLE "farm_data" (
  "dataID" serial4 PRIMARY KEY NOT NULL,
  "farmID" int4 NOT NULL,
  "dataType" varchar(50) NOT NULL,
  "dataName" varchar(50),
  "dataValue" varchar(250) NOT NULL,
  "dataValueComplement" varchar(250) NOT NULL,
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL,
  "editedByUserID" int4 NOT NULL,
  "active" bool NOT NULL DEFAULT 1
);

CREATE TABLE "harvest" (
  "safraID" serial4 PRIMARY KEY NOT NULL,
  "farmID" int4 NOT NULL,
  "taxType" varchar,
  "agriculturalYear" varchar(50) NOT NULL,
  "area" int4,
  "grain" varchar(50) NOT NULL,
  "editedByUserID" int4 NOT NULL,
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL,
  "active" bool NOT NULL DEFAULT 1
);

CREATE TABLE "assets" (
  "assetsID" serial4 PRIMARY KEY NOT NULL,
  "editedByUserID" int4 NOT NULL,
  "safraID" int4,
  "type" varchar(50) NOT NULL,
  "typeMachine" varchar(50),
  "capacity" varchar(50),
  "model" varchar(50),
  "manufacturer" varchar(50),
  "yearManufacture" varchar(50),
  "yearAcquisition" varchar(50),
  "currentValue" numeric,
  "obs" varchar(50),
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL,
  "depreciation" numeric NOT NULL,
  "agriculturalYear" varchar(20),
  "active" bool NOT NULL DEFAULT 1
);

CREATE TABLE "employees" (
  "employeesID" serial4 PRIMARY KEY NOT NULL,
  "farmID" int4 NOT NULL,
  "editedByUserID" int4 NOT NULL,
  "employee" varchar(50),
  "function" varchar(50),
  "grossSalary" numeric,
  "commissionSoybean" varchar(50),
  "valueSoybean" varchar(50),
  "commissioncorn" varchar(50),
  "valueCorn" varchar(50),
  "totalAnnual" numeric,
  "totalMonthly" numeric,
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL,
  "active" bool NOT NULL DEFAULT 1
);

CREATE TABLE "inputs_Expenses" (
  "id" serial4 PRIMARY KEY NOT NULL,
  "farmID" int4 NOT NULL,
  "date" date NOT NULL,
  "safraID" int4,
  "agriculturalYear" varchar(20),
  "producerID" int4,
  "orderNumber" numeric,
  "invoiceNumber" varchar(50),
  "supplier" varchar(50),
  "category" varchar(50) NOT NULL,
  "description" varchar(50),
  "quantity" int4,
  "unity" varchar(50),
  "value" numeric NOT NULL,
  "dueDate" date,
  "paymentDate" date,
  "paid" bool,
  "editedByUserID" int4 NOT NULL,
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL,
  "active" bool NOT NULL DEFAULT 1
);

CREATE TABLE "operational_Expenses" (
  "id" serial4 PRIMARY KEY NOT NULL,
  "farmID" int4 NOT NULL,
  "date" date NOT NULL,
  "producerID" int4,
  "orderNumber" numeric,
  "invoiceNumber" varchar(50),
  "supplier" varchar(50),
  "category" varchar(50) NOT NULL,
  "description" varchar(50),
  "quantity" int4,
  "unity" varchar(50),
  "value" numeric NOT NULL,
  "dueDate" date,
  "paymentDate" date,
  "paid" bool,
  "unitCost" varchar(20),
  "editedByUserID" int4 NOT NULL,
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL,
  "agriculturalYear" varchar(20),
  "active" bool NOT NULL DEFAULT 1
);

CREATE TABLE "expenses_loans" (
  "inputID" serial4 PRIMARY KEY NOT NULL,
  "farmID" int4 NOT NULL,
  "editedByUserID" int4 NOT NULL,
  "date" date NOT NULL,
  "agriculturalYear" varchar(20),
  "producerID" int4 NOT NULL,
  "category" varchar(50) NOT NULL,
  "description" varchar(50),
  "contractNumber" varchar(50),
  "creditor" varchar(50),
  "mainValue" numeric NOT NULL,
  "fees" numeric NOT NULL,
  "interestperiod" varchar(20) NOT NULL,
  "amortizationAmount" numeric NOT NULL,
  "dueDate" date NOT NULL,
  "paymentAmount" numeric,
  "paymentDate" date,
  "paymentStatus" bool,
  "realInterest" numeric,
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL,
  "type" int4 NOT NULL,
  "active" bool NOT NULL DEFAULT 1
);

CREATE TABLE "input_orders" (
  "inputID" serial4 PRIMARY KEY NOT NULL,
  "farmID" int4 NOT NULL,
  "editedByUserID" int4 NOT NULL,
  "safraID" int4,
  "date" date NOT NULL,
  "agriculturalYear" varchar(20),
  "producerID" int4,
  "storageID" int4,
  "orderNumber" varchar(50) NOT NULL,
  "provider" varchar(50),
  "category" varchar(50) NOT NULL,
  "inputDescription" varchar(50),
  "quantity" int4 NOT NULL,
  "unit" varchar(50) NOT NULL,
  "price" numeric NOT NULL,
  "paymentDate" date,
  "amountReceived" numeric,
  "deliveryDate" date,
  "unitCost" numeric,
  "balanceReceivable" numeric,
  "receiptStatus" bool,
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL,
  "grain" varchar(50),
  "type" int4 NOT NULL,
  "active" bool NOT NULL DEFAULT 1
);

CREATE TABLE "leases" (
  "leasesID" serial4 PRIMARY KEY NOT NULL,
  "farmID" int4 NOT NULL,
  "editedByUserID" int4 NOT NULL,
  "safraID" int4,
  "agriculturalYear" varchar(20),
  "producerID" int4,
  "lessor" varchar NOT NULL,
  "area" int4 NOT NULL,
  "cornLease" numeric,
  "soyLease" numeric,
  "contractExpirationDate" date NOT NULL,
  "totalSoy" varchar,
  "totalCorn" varchar,
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL,
  "type" int4 NOT NULL,
  "active" bool NOT NULL DEFAULT 1
);

CREATE TABLE "revenues_grain" (
  "revenuesID" serial4 PRIMARY KEY NOT NULL,
  "farmID" int4 NOT NULL,
  "type" int4 NOT NULL,
  "date" date NOT NULL,
  "finality" varchar(50),
  "talhao" varchar(50),
  "ie" varchar(50),
  "ticket" numeric,
  "netweight" numeric,
  "impurity" varchar(50),
  "moisture" varchar(50),
  "driver" varchar(50),
  "licenseplate" varchar(50),
  "shippingcost" numeric,
  "producerID" int4,
  "receiver" varchar(50),
  "storageID" int4,
  "quantity" int4,
  "price" numeric,
  "deliveryDate" date,
  "receivingDate" date,
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL,
  "priceScLiq" varchar,
  "revenueLiq" varchar,
  "talhaoID" int4,
  "active" bool NOT NULL DEFAULT 1
);

CREATE TABLE "revenues_asset" (
  "revenuesID" serial4 PRIMARY KEY NOT NULL,
  "farmID" int4 NOT NULL,
  "producerID" int4 NOT NULL,
  "safraID" varchar(20) NOT NULL,
  "category" varchar(50) NOT NULL,
  "description" varchar(50),
  "buyerPayer" varchar(50),
  "dateAgreed" date,
  "receiptAmount" numeric NOT NULL,
  "date" date NOT NULL,
  "receivingDate" date,
  "obs" varchar(50),
  "receiptStatus" bool NOT NULL,
  "active" bool NOT NULL DEFAULT 1,
  "editedByUserID" int4 NOT NULL,
  "createdDate" timestamptz NOT NULL,
  "editedDate" timestamptz NOT NULL
);

CREATE INDEX "FK_159_2" ON "crops" USING BTREE ("editedByUserID");

CREATE INDEX "FK_74_2" ON "crops" USING BTREE ("farmID");

CREATE INDEX "FK_77_2" ON "crops" USING BTREE ("safraID");

CREATE INDEX "FK_25" ON "user" USING BTREE ("companyID");

CREATE INDEX "FK_61" ON "user" USING BTREE ("roleID");

CREATE INDEX "FK_151" ON "farm" USING BTREE ("editedByUserID");

CREATE INDEX "FK_70" ON "farm" USING BTREE ("companyID");

CREATE INDEX "FK_176" ON "assets" USING BTREE ("editedByUserID");

CREATE INDEX "FK_82" ON "assets" USING BTREE ("safraID");

CREATE INDEX "FK_146" ON "employees" USING BTREE ("editedByUserID");

CREATE INDEX "FK_41" ON "employees" USING BTREE ("farmID");

CREATE INDEX "FK_157" ON "inputs_Expenses" USING BTREE ("editedByUserID");

CREATE INDEX "FK_94" ON "inputs_Expenses" USING BTREE ("farmID");

CREATE INDEX "FK_97" ON "inputs_Expenses" USING BTREE ("safraID");

CREATE INDEX "FK_157" ON "operational_Expenses" USING BTREE ("editedByUserID");

CREATE INDEX "FK_94" ON "operational_Expenses" USING BTREE ("farmID");

CREATE INDEX "FK_624" ON "expenses_loans" USING BTREE ("farmID");

CREATE INDEX "FK_739" ON "expenses_loans" USING BTREE ("editedByUserID");

CREATE INDEX "FK_577" ON "input_orders" USING BTREE ("safraID");

CREATE INDEX "FK_674" ON "input_orders" USING BTREE ("farmID");

CREATE INDEX "FK_759" ON "input_orders" USING BTREE ("editedByUserID");

CREATE INDEX "FK_259" ON "leases" USING BTREE ("editedByUserID");

CREATE INDEX "FK_274" ON "leases" USING BTREE ("farmID");

CREATE INDEX "FK_277" ON "leases" USING BTREE ("safraID");

CREATE INDEX "FK_159" ON "revenues_asset" USING BTREE ("editedByUserID");

CREATE INDEX "FK_74" ON "revenues_asset" USING BTREE ("farmID");

ALTER TABLE "user" ADD CONSTRAINT "FK_23" FOREIGN KEY ("companyID") REFERENCES "company" ("companyID");

ALTER TABLE "user" ADD CONSTRAINT "FK_59" FOREIGN KEY ("roleID") REFERENCES "roles" ("roleID");

ALTER TABLE "farm" ADD CONSTRAINT "FK_68" FOREIGN KEY ("companyID") REFERENCES "company" ("companyID");

ALTER TABLE "farm" ADD CONSTRAINT "FK_149" FOREIGN KEY ("editedByUserID") REFERENCES "user" ("userID");

ALTER TABLE "farm_data" ADD CONSTRAINT "FK_163" FOREIGN KEY ("farmID") REFERENCES "farm" ("farmID");

ALTER TABLE "farm_data" ADD CONSTRAINT "FK_188" FOREIGN KEY ("editedByUserID") REFERENCES "user" ("userID");

ALTER TABLE "harvest" ADD CONSTRAINT "FK_83" FOREIGN KEY ("farmID") REFERENCES "farm" ("farmID");

ALTER TABLE "harvest" ADD CONSTRAINT "FK_146" FOREIGN KEY ("editedByUserID") REFERENCES "user" ("userID");

ALTER TABLE "assets" ADD CONSTRAINT "FK_85" FOREIGN KEY ("editedByUserID") REFERENCES "user" ("userID");

ALTER TABLE "assets" ADD CONSTRAINT "FK_65" FOREIGN KEY ("safraID") REFERENCES "harvest" ("safraID");

ALTER TABLE "employees" ADD CONSTRAINT "FK_56" FOREIGN KEY ("farmID") REFERENCES "farm" ("farmID");

ALTER TABLE "employees" ADD CONSTRAINT "FK_86" FOREIGN KEY ("editedByUserID") REFERENCES "user" ("userID");

ALTER TABLE "operational_Expenses" ADD CONSTRAINT "FK_92" FOREIGN KEY ("farmID") REFERENCES "farm" ("farmID");

ALTER TABLE "operational_Expenses" ADD CONSTRAINT "FK_155" FOREIGN KEY ("editedByUserID") REFERENCES "user" ("userID");

ALTER TABLE "operational_Expenses" ADD CONSTRAINT "FK_377" FOREIGN KEY ("producerID") REFERENCES "farm_data" ("dataID");

ALTER TABLE "inputs_Expenses" ADD CONSTRAINT "FK_92" FOREIGN KEY ("farmID") REFERENCES "farm" ("farmID");

ALTER TABLE "inputs_Expenses" ADD CONSTRAINT "FK_155" FOREIGN KEY ("editedByUserID") REFERENCES "user" ("userID");

ALTER TABLE "inputs_Expenses" ADD CONSTRAINT "FK_95" FOREIGN KEY ("safraID") REFERENCES "harvest" ("safraID");

ALTER TABLE "inputs_Expenses" ADD CONSTRAINT "FK_377" FOREIGN KEY ("producerID") REFERENCES "farm_data" ("dataID");

ALTER TABLE "expenses_loans" ADD CONSTRAINT "FK_812" FOREIGN KEY ("farmID") REFERENCES "farm" ("farmID");

ALTER TABLE "expenses_loans" ADD CONSTRAINT "FK_765" FOREIGN KEY ("editedByUserID") REFERENCES "user" ("userID");

ALTER TABLE "expenses_loans" ADD CONSTRAINT "FK_837" FOREIGN KEY ("producerID") REFERENCES "farm_data" ("dataID");

ALTER TABLE "input_orders" ADD CONSTRAINT "FK_872" FOREIGN KEY ("farmID") REFERENCES "farm" ("farmID");

ALTER TABLE "input_orders" ADD CONSTRAINT "FK_775" FOREIGN KEY ("editedByUserID") REFERENCES "user" ("userID");

ALTER TABLE "input_orders" ADD CONSTRAINT "FK_975" FOREIGN KEY ("safraID") REFERENCES "harvest" ("safraID");

ALTER TABLE "input_orders" ADD CONSTRAINT "FK_877" FOREIGN KEY ("producerID") REFERENCES "farm_data" ("dataID");

ALTER TABLE "input_orders" ADD CONSTRAINT "FK_978" FOREIGN KEY ("storageID") REFERENCES "farm_data" ("dataID");

ALTER TABLE "leases" ADD CONSTRAINT "FK_212" FOREIGN KEY ("farmID") REFERENCES "farm" ("farmID");

ALTER TABLE "leases" ADD CONSTRAINT "FK_225" FOREIGN KEY ("editedByUserID") REFERENCES "user" ("userID");

ALTER TABLE "leases" ADD CONSTRAINT "FK_215" FOREIGN KEY ("safraID") REFERENCES "harvest" ("safraID");

ALTER TABLE "leases" ADD CONSTRAINT "FK_217" FOREIGN KEY ("producerID") REFERENCES "farm_data" ("dataID");

ALTER TABLE "revenues_grain" ADD CONSTRAINT "FK_272" FOREIGN KEY ("farmID") REFERENCES "farm" ("farmID");

ALTER TABLE "revenues_grain" ADD CONSTRAINT "FK_477" FOREIGN KEY ("producerID") REFERENCES "farm_data" ("dataID");

ALTER TABLE "revenues_grain" ADD CONSTRAINT "FK_778" FOREIGN KEY ("storageID") REFERENCES "farm_data" ("dataID");

ALTER TABLE "revenues_grain" ADD CONSTRAINT "FK_8978" FOREIGN KEY ("talhaoID") REFERENCES "farm_data" ("dataID");

ALTER TABLE "revenues_asset" ADD CONSTRAINT "FK_1722" FOREIGN KEY ("farmID") REFERENCES "farm" ("farmID");

ALTER TABLE "revenues_asset" ADD CONSTRAINT "FK_175" FOREIGN KEY ("editedByUserID") REFERENCES "user" ("userID");

ALTER TABLE "revenues_asset" ADD CONSTRAINT "FK_77" FOREIGN KEY ("producerID") REFERENCES "farm_data" ("dataID");
