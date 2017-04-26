DROP TABLE IF EXISTS c_app_db;
DROP TABLE IF EXISTS c_application;
DROP TABLE IF EXISTS erid;
DROP TABLE IF EXISTS kpe;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS cat2;
DROP TABLE IF EXISTS c_column;
DROP TABLE IF EXISTS c_table;
DROP TABLE IF EXISTS c_schema;
DROP TABLE IF EXISTS c_db_server;
DROP TABLE IF EXISTS c_database;
DROP TABLE IF EXISTS c_server;

CREATE TABLE cat2 (
cat2_id int(11) NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
PRIMARY KEY (cat2_id)
) ENGINE=InnoDB;

CREATE TABLE supplier (
supplier_id int(11) NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
PRIMARY KEY (supplier_id)
) ENGINE=InnoDB;

CREATE TABLE kpe (
kpe_id int(11) NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
PRIMARY KEY (kpe_id)
) ENGINE=InnoDB;

CREATE TABLE erid (
erid_id int(11) NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
PRIMARY KEY (erid_id)
) ENGINE=InnoDB;

CREATE TABLE c_application (
app_id int(11) NOT NULL AUTO_INCREMENT,
name varchar(100) NOT NULL,
description text,
erid_id int(11),
kpe_id int(11),
supplier_id int(11),
cat2_id int(11),
PRIMARY KEY(app_id),
CONSTRAINT cat2_fk FOREIGN KEY (cat2_id) REFERENCES cat2 (cat2_id) 
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT supplier_fk FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id) 
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT kpe_fk FOREIGN KEY (kpe_id) REFERENCES kpe (kpe_id) 
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT erid_fk FOREIGN KEY (erid_id) REFERENCES erid (erid_id) 
ON DELETE CASCADE ON UPDATE CASCADE,
UNIQUE KEY application_name_uni (name)
) ENGINE=InnoDB;


CREATE TABLE c_database (
db_id int(11) NOT NULL AUTO_INCREMENT,
name varchar(100) NOT NULL,
description text,
PRIMARY KEY(db_id)
) ENGINE=InnoDB;


CREATE TABLE c_app_db (
db_id int(11) NOT NULL,
app_id int(11) NOT NULL,
PRIMARY KEY(db_id, app_id),
CONSTRAINT app_db_database_fk FOREIGN KEY (db_id) REFERENCES c_database (db_id) 
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT app_db_application_fk FOREIGN KEY (app_id) REFERENCES c_application (app_id) 
ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE c_schema (
sch_id int(11) NOT NULL AUTO_INCREMENT,
name varchar(50) NOT NULL,
description text,
db_id int(11) NOT NULL,
PRIMARY KEY(sch_id, db_id),
CONSTRAINT schema_db_fk FOREIGN KEY (db_id) REFERENCES c_database (db_id)
ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE c_table (
tbl_id int(11) NOT NULL AUTO_INCREMENT,
name varchar(1000) not null,
description text,
sch_id int(11) NOT NULL,
PRIMARY KEY(tbl_id, sch_id),
CONSTRAINT table_schema_fk FOREIGN KEY (sch_id) REFERENCES c_schema (sch_id)
ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE c_column (
col_id int(11) NOT NULL AUTO_INCREMENT,
name varchar(1000) not null,
col_type varchar(50) DEFAULT NULL,
col_size varchar(50) DEFAULT NULL,
col_enum varchar(50) DEFAULT NULL,
col_pattern varchar(50) DEFAULT NULL,
completion_rate varchar(50) DEFAULT NULL,
first_record_date timestamp NULL DEFAULT NULL,
last_record_date timestamp NULL DEFAULT NULL,
tbl_id int(11) NOT NULL,
PRIMARY KEY(col_id, tbl_id),
CONSTRAINT column_table_fk FOREIGN KEY (tbl_id) REFERENCES c_table (tbl_id)
ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE c_server (
srv_id int(11) NOT NULL AUTO_INCREMENT,
name varchar(100) NOT NULL,
description text,
PRIMARY KEY(srv_id)
) ENGINE=InnoDB;

CREATE TABLE c_db_server (
db_id int(11) NOT NULL,
srv_id int(11) NOT NULL,
PRIMARY KEY(db_id, srv_id),
CONSTRAINT db_srv_database_fk FOREIGN KEY (db_id) REFERENCES c_database (db_id) 
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT db_srv_server_fk FOREIGN KEY (srv_id) REFERENCES c_server (srv_id) 
ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

