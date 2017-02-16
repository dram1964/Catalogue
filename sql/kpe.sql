-- DROP TABLE IF EXISTS kpe_class;

-- CREATE TABLE kpe_class (
-- id int NOT NULL AUTO_INCREMENT,
-- name VARCHAR(50) NOT NULL,
-- PRIMARY KEY (id),
-- CONSTRAINT kpe_name_uni UNIQUE (name)
-- );

-- INSERT INTO kpe_class (name) VALUES ('N/A');

-- DROP TABLE IF EXISTS erid;

-- CREATE TABLE erid (
-- id int NOT NULL AUTO_INCREMENT,
-- name VARCHAR(50),
-- PRIMARY KEY (id),
-- CONSTRAINT erid_name_uni UNIQUE (name)
-- );

-- INSERT INTO erid (name) VALUES ('N/A');

-- DROP TABLE IF EXISTS category2;

-- CREATE TABLE category2 (
-- id int NOT NULL AUTO_INCREMENT,
-- name VARCHAR(50),
-- PRIMARY KEY (id),
-- CONSTRAINT erid_name_uni UNIQUE (name)
-- );

-- INSERT INTO category2 (name) VALUES ('N/A');

-- DROP TABLE IF EXISTS supplier;

-- CREATE TABLE supplier (
-- id int NOT NULL AUTO_INCREMENT,
-- name VARCHAR(50),
-- PRIMARY KEY (id),
-- CONSTRAINT supplier_name_uni UNIQUE (name)
-- );

-- INSERT INTO supplier (name) VALUES ('N/A');

-- DROP TABLE IF EXISTS application;

-- CREATE TABLE application (
-- id int NOT NULL AUTO_INCREMENT,
-- name varchar(50) NOT NULL,
-- description TEXT NULL,
-- PRIMARY KEY (id),
-- CONSTRAINT application_name_uni UNIQUE (name)
-- );

-- ALTER TABLE catalogue_system ADD COLUMN application_id int NULL;

-- ALTER TABLE catalogue_system ADD COLUMN erid_id int NOT NULL DEFAULT 1;

-- ALTER TABLE catalogue_system ADD CONSTRAINT FOREIGN KEY (erid_id)
-- REFERENCES erid (id) ON DELETE CASCADE ON UPDATE CASCADE;

-- ALTER TABLE catalogue_system ADD COLUMN kpe_id int NOT NULL DEFAULT 1;
-- ALTER TABLE catalogue_system ADD CONSTRAINT FOREIGN KEY (kpe_id)
-- REFERENCES kpe_class (id) ON DELETE CASCADE ON UPDATE CASCADE;

-- ALTER TABLE catalogue_system ADD COLUMN supplier_id int NOT NULL DEFAULT 1;
-- ALTER TABLE catalogue_system ADD CONSTRAINT FOREIGN KEY (supplier_id)
-- REFERENCES supplier (id) ON DELETE CASCADE ON UPDATE CASCADE;

-- ALTER TABLE catalogue_system ADD COLUMN cat2_id int NOT NULL DEFAULT 1;
-- ALTER TABLE catalogue_system ADD CONSTRAINT FOREIGN KEY (cat2_id)
-- REFERENCES category2 (id) ON DELETE CASCADE ON UPDATE CASCADE;

