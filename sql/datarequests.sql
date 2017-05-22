DROP TABLE IF EXISTS data_request;
DROP TABLE IF EXISTS request_status;
DROP TABLE IF EXISTS request_type;

CREATE TABLE request_status (
id int(11) not null,
description VARCHAR(30),
PRIMARY KEY (id)
);

CREATE TABLE request_type (
id int(11) not null,
name VARCHAR(50),
description text,
PRIMARY KEY (id)
);

CREATE TABLE data_request (
id int(11) not null AUTO_INCREMENT,
user_id int(11) not null,
cardiology_details text,
chemotherapy_details text,
diagnosis_details text,
episode_details text,
other_details text,
pathology_details text,
pharmacy_details text,
radiology_details text,
theatre_details text,
request_type_id int(11) not null,
status_id int(11) not null,
status_date TIMESTAMP NOT NULL DEFAULT NOW(), 
PRIMARY KEY (id),
CONSTRAINT request_user_fk FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT status_type_fk FOREIGN KEY (status_id) REFERENCES request_status (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT request_type_fk FOREIGN KEY (request_type_id) REFERENCES request_type (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO request_type
values (1, 'UCL Research Ethics Committee Approved', 'For studies with UCL REC approval. Requires upload of REC approval letter, and R&D approval letter'),
(2, 'UCLH Clinical Service Support', 'For requesting data to directly support the delivery or evaluation of Clinical Services at UCLH. Requires evidence of support for this request from the Clinical Service board'),
(3, 'Anonymised Clinical Data', 'For requesting datasets linked at the patient-level, but with no person identifiers. Useful for testing purpose'),
(4, 'Aggregated Data', 'For requesting aggregated data. Useful for service performance evaluations');

INSERT INTO request_status
values (1, 'Saved for Later'), (2, 'Saved and Continue'), (3, 'Submitted for Review');
