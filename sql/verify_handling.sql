DROP TABLE IF EXISTS verify_handling; 
DROP TABLE IF EXISTS verify_handling_history; 

CREATE TABLE verify_handling(
request_id int(11) not null,
verifier int(11) not null,
verification_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
rec_comment text null,
population_comment text null,
id_comment text null,
storing_comment text null,
completion_comment text null,
publish_comment text null,
additional_comment text null,
PRIMARY KEY (request_id),
CONSTRAINT ifk_verify_request_handling FOREIGN KEY (request_id) REFERENCES data_request (id),
CONSTRAINT ifk_request_handling_verifier FOREIGN KEY (verifier) REFERENCES users (id)
);

CREATE TABLE verify_handling_history(
request_id int(11) not null,
verifier int(11) not null,
verification_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
rec_comment text null,
population_comment text null,
id_comment text null,
storing_comment text null,
completion_comment text null,
publish_comment text null,
additional_comment text null,
PRIMARY KEY (request_id, verification_time)
);
