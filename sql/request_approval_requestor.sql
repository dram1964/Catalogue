DROP TABLE IF EXISTS request_approval_requestor;
DROP TABLE IF EXISTS approval_requestor;

CREATE TABLE approval_requestor (
request_id int not null,
validated boolean not null default 0,
verification_method int,
notes text,
PRIMARY KEY (request_id),
CONSTRAINT fk_approval_requestor_request FOREIGN KEY (request_id) REFERENCES data_request (id) 
ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS approval_requestor_history;

CREATE TABLE approval_requestor_history (
request_id int not null,
approval_date timestamp not null default CURRENT_TIMESTAMP,
validated boolean not null default 0,
verification_method int,
notes text,
PRIMARY KEY (request_id, approval_date),
CONSTRAINT fk_approval_requestor_history FOREIGN KEY (request_id) REFERENCES approval_requestor (request_id) 
ON DELETE CASCADE ON UPDATE CASCADE
);

