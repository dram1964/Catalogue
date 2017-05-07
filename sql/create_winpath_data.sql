DROP TABLE IF EXISTS wp_fact;
DROP TABLE IF EXISTS wp_order;
DROP TABLE IF EXISTS wp_test;
DROP TABLE IF EXISTS wp_laboratory;

CREATE TABLE wp_laboratory (
code varchar(2) NOT NULL,
discipline varchar(30), 
cluster varchar(30), 
specialty varchar(30),
PRIMARY KEY (code)
) ENGINE=InnoDB;

CREATE TABLE wp_order (
code varchar(4) NOT NULL,
type char(1),
description varchar(30),
laboratory_code varchar(2) NOT NULL DEFAULT 'U',
PRIMARY KEY (code),
CONSTRAINT laboratory_order_fk FOREIGN KEY (laboratory_code) REFERENCES wp_laboratory (code) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE wp_test (
code varchar(4) NOT NULL,
name varchar(30),
laboratory_code varchar(2) NOT NULL DEFAULT 'U',
units varchar(30),
function varchar(30),
flags varchar(30),
report_section varchar(2),
line_number int,
PRIMARY KEY (code, laboratory_code),
CONSTRAINT laboratory_test_fk FOREIGN KEY (laboratory_code) REFERENCES wp_laboratory (code) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE wp_fact (
order_code varchar(4) NOT NULL,
test_code varchar(4) NOT NULL,
laboratory_code varchar(2) NOT NULL DEFAULT 'U',
cluster_name varchar(30),
year_of_birth int,
year_of_result int,
gender char(1),
requests int,
PRIMARY KEY (order_code, test_code, laboratory_code, cluster_name, year_of_birth, year_of_result, gender),
CONSTRAINT order_code_fk FOREIGN KEY (order_code) REFERENCES wp_order (code) on DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT test_code_fk FOREIGN KEY (test_code) REFERENCES wp_test (code) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT laboratory_code_fk FOREIGN KEY (laboratory_code) REFERENCES wp_laboratory (code) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;
