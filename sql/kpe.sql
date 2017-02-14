DROP TABLE IF EXISTS kpe_class;

CREATE TABLE kpe_class (
id int NOT NULL AUTO_INCREMENT,
description VARCHAR(50) NOT NULL,
PRIMARY KEY (id)
);

DROP TABLE IF EXISTS system_kpe;

CREATE TABLE system_kpe (
system_id int NOT NULL,
kpe_id int NOT NULL,
PRIMARY KEY (system_id, kpe_id),
CONSTRAINT kpe_system_type FOREIGN KEY (system_id) REFERENCES catalogue_system (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT system_kpe FOREIGN KEY (kpe_id) REFERENCES kpe_class (id) ON DELETE CASCADE ON UPDATE CASCADE
);

