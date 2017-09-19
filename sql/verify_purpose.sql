DROP TABLE IF EXISTS verify_purpose;
DROP TABLE IF EXISTS verify_purpose_history;

CREATE TABLE verify_purpose(
request_id int(11) not null,
verifier int(11) not null,
verification_time timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
area text null,
objective text null,
benefits text null,
PRIMARY KEY (request_id),
CONSTRAINT ifk_verify_request_purpose FOREIGN KEY (request_id) REFERENCES data_request (id),
CONSTRAINT ifk_request_purpose_verifier FOREIGN KEY (verifier) REFERENCES users (id)
);

CREATE TABLE verify_purpose_history(
request_id int(11) not null,
verifier int(11) not null,
verification_time timestamp not null default CURRENT_TIMESTAMP,
area text null,
objective text null,
benefits text null,
PRIMARY KEY (request_id, verification_time)
);


