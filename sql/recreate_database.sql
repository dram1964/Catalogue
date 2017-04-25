DROP TABLE IF EXISTS c_app_db;
DROP TABLE IF EXISTS c_application;
DROP TABLE IF EXISTS c_column;
DROP TABLE IF EXISTS c_table;
DROP TABLE IF EXISTS c_schema;
DROP TABLE IF EXISTS c_database;

CREATE TABLE c_application (
app_id int(11) NOT NULL AUTO_INCREMENT,
name varchar(100) NOT NULL,
description text,
PRIMARY KEY(app_id),
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
CONSTRAINT db_fk FOREIGN KEY (db_id) REFERENCES c_database (db_id) 
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT app_fk FOREIGN KEY (app_id) REFERENCES c_application (app_id) 
ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE c_schema (
sch_id int(11) NOT NULL AUTO_INCREMENT,
name varchar(50) NOT NULL,
description text,
db_id int(11) NOT NULL,
PRIMARY KEY(sch_id),
CONSTRAINT schema_db_fk FOREIGN KEY (db_id) REFERENCES c_database (db_id)
ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE c_table (
tbl_id int(11) NOT NULL AUTO_INCREMENT,
name varchar(1000) not null,
description text,
sch_id int(11) NOT NULL,
PRIMARY KEY(tbl_id),
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
PRIMARY KEY(col_id),
CONSTRAINT column_table_fk FOREIGN KEY (tbl_id) REFERENCES c_table (tbl_id)
ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;
