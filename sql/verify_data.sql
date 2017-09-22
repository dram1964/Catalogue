DROP TABLE IF EXISTS verify_data;
DROP TABLE IF EXISTS verify_data_history;

CREATE TABLE verify_data(
request_id int(11) not null,
verifier int(11) not null,
verification_time timestamp not null default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
cardiology_comment text null,
diagnosis_comment text null,
episode_comment text null,
other_comment text null,
pathology_comment text null,
pharmacy_comment text null,
radiology_comment text null,
theatre_comment text null,
PRIMARY KEY (request_id),
CONSTRAINT ifk_verify_request_data FOREIGN KEY (request_id) REFERENCES data_request (id),
CONSTRAINT ifk_request_data_verifier FOREIGN KEY (verifier) REFERENCES users (id)
);

CREATE TABLE verify_data_history(
request_id int(11) not null,
verifier int(11) not null,
verification_time timestamp not null default CURRENT_TIMESTAMP,
cardiology_comment text null,
diagnosis_comment text null,
episode_comment text null,
other_comment text null,
pathology_comment text null,
pharmacy_comment text null,
radiology_comment text null,
theatre_comment text null,
PRIMARY KEY (request_id, verification_time)
);


