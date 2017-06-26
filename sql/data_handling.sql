CREATE TABLE data_handling (
id int(11) not null AUTO_INCREMENT,
request_id int not null,
identifiable int,
identifiers TEXT,
additional_identifiers TEXT,
publish int,
publish_to TEXT,
storing TEXT,
completion TEXT,
additional_info TEXT,
PRIMARY KEY (id),
CONSTRAINT request_id_fk FOREIGN KEY (request_id) REFERENCES data_request (id) ON DELETE CASCADE ON UPDATE CASCADE
); 
