DROP TABLE IF EXISTS approval_requestor_history;
DROP TABLE IF EXISTS approval_requestor;

CREATE TABLE approval_requestor (
request_id int not null,
validated boolean not null default 0,
verification_method int,
notes text,
approver int not null,
PRIMARY KEY (request_id),
CONSTRAINT fk_approval_requestor_request FOREIGN KEY (request_id) REFERENCES data_request (id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_approval_requesor_approver FOREIGN KEY (approver) REFERENCES users (id)
);


CREATE TABLE approval_requestor_history (
request_id int not null,
approval_date timestamp not null default CURRENT_TIMESTAMP,
validated boolean not null default 0,
verification_method int,
notes text,
approver int not null,
PRIMARY KEY (request_id, approval_date),
CONSTRAINT fk_approval_requestor_history FOREIGN KEY (request_id) REFERENCES approval_requestor (request_id) 
ON DELETE CASCADE ON UPDATE CASCADE
);

