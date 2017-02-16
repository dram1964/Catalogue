DROP TABLE IF EXISTS system_kpe;
DROP TABLE IF EXISTS kpe_class;

CREATE TABLE kpe_class (
id int NOT NULL AUTO_INCREMENT,
description VARCHAR(50) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE system_kpe (
system_id int NOT NULL,
kpe_id int NOT NULL,
PRIMARY KEY (system_id, kpe_id),
CONSTRAINT kpe_system FOREIGN KEY (system_id) REFERENCES catalogue_system (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT system_kpe FOREIGN KEY (kpe_id) REFERENCES kpe_class (id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS system_erid;
DROP TABLE IF EXISTS erid;

CREATE TABLE erid (
id int NOT NULL AUTO_INCREMENT,
description VARCHAR(50),
PRIMARY KEY (id)
);

CREATE TABLE system_erid (
system_id int NOT NULL,
er_id int NOT NULL,
PRIMARY KEY (system_id, er_id),
CONSTRAINT erid_system FOREIGN KEY (system_id) REFERENCES catalogue_system (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT system_erid FOREIGN KEY (er_id) REFERENCES erid (id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS system_category2;
DROP TABLE IF EXISTS category2;

CREATE TABLE category2 (
id int NOT NULL AUTO_INCREMENT,
description VARCHAR(50),
PRIMARY KEY (id)
);

CREATE TABLE system_category2 (
system_id int NOT NULL,
cat2_id int NOT NULL,
PRIMARY KEY (system_id, cat2_id),
CONSTRAINT cat2_system FOREIGN KEY (system_id) REFERENCES catalogue_system (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT system_cat2 FOREIGN KEY (cat2_id) REFERENCES category2 (id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS system_supplier;
DROP TABLE IF EXISTS supplier;

CREATE TABLE supplier (
id int NOT NULL AUTO_INCREMENT,
description VARCHAR(50),
PRIMARY KEY (id)
);

CREATE TABLE system_supplier (
system_id int NOT NULL,
supplier_id int NOT NULL,
PRIMARY KEY (system_id, supplier_id),
CONSTRAINT supplier_system FOREIGN KEY (system_id) REFERENCES catalogue_system (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT system_supplier FOREIGN KEY (supplier_id) REFERENCES supplier (id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS system_application;
DROP TABLE IF EXISTS application;

CREATE TABLE application (
id int NOT NULL AUTO_INCREMENT,
name varchar(50) NOT NULL,
description TEXT NULL,
PRIMARY KEY (id)
);

CREATE TABLE system_application (
system_id int NOT NULL,
application_id int NOT NULL,
PRIMARY KEY (system_id, application_id),
CONSTRAINT application_system FOREIGN KEY (system_id) REFERENCES catalogue_system (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT system_application FOREIGN KEY (application_id) REFERENCES application (id) ON DELETE CASCADE ON UPDATE CASCADE
);
