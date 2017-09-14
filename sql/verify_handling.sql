DROP TABLE IF EXISTS verify_handling; 

CREATE TABLE verify_handling(
request_id int(11) not null,
verifier int(11) not null,
verification_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (request_id),
CONSTRAINT ifk_verified_request FOREIGN KEY (request_id) REFERENCES data_request (id),
CONSTRAINT ifk_verifier FOREIGN KEY (verifier) REFERENCES users (id)
);

DROP TABLE IF EXISTS verify_handling_history; 

CREATE TABLE verify_handling_history(
request_id int(11) not null,
verifier int(11) not null,
verification_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (request_id, verification_time)
);
