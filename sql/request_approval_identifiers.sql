DROP TABLE IF EXISTS approval_identifiers_history;
DROP TABLE IF EXISTS approval_identifiers;

CREATE TABLE approval_identifiers (
request_id int not null,
ptName boolean,
ptNumber boolean,
dob boolean,
nhsNumber boolean,
addr boolean,
other text,
approver int not null,
PRIMARY KEY (request_id),
CONSTRAINT fk_approval_identifiers_request FOREIGN KEY (request_id) REFERENCES data_request (id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_approval_identifiers_approver FOREIGN KEY (approver) REFERENCES users (id)
);


CREATE TABLE approval_identifiers_history (
request_id int not null,
ptName boolean,
ptNumber boolean,
dob boolean,
nhsNumber boolean,
addr boolean,
other text,
approval_date timestamp not null default CURRENT_TIMESTAMP,
approver int not null,
PRIMARY KEY (request_id, approval_date),
CONSTRAINT fk_approval_identifiers_history FOREIGN KEY (request_id) REFERENCES approval_identifiers (request_id) 
ON DELETE CASCADE ON UPDATE CASCADE
);

