CREATE TABLE submission (
id int(11) not null AUTO_INCREMENT,
request_id INT(11) NOT NULL, 
project_type varchar(30) not null,
project_name varchar(30) not null,
project_location text,
extract_run_date DATE,
extract_output_file varchar(250),
extract_output_file_location varchar(250),
extract_delivery_method text,
PRIMARY KEY (id, request_id),
CONSTRAINT submission_request_id_fk FOREIGN KEY (request_id) REFERENCES data_request (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE package (
id int(11) not null AUTO_INCREMENT,
submission_id int(11) not null,
package_name varchar(250) not null,
PRIMARY KEY (id, submission_id),
CONSTRAINT submission_package_id_fk FOREIGN KEY (submission_id) REFERENCES submission (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE extract (
id int(11) not null AUTO_INCREMENT,
package_id int(11) not null,
source_name varchar(50) not null,
source_type varchar(50) not null,
extract_name varchar(50) not null,
extract_query text, 
output_type text,
filename varchar(250),
PRIMARY KEY (id, package_id),
CONSTRAINT package_extract_id_fk FOREIGN KEY (package_id) REFERENCES package (id) ON DELETE CASCADE ON UPDATE CASCADE
);
