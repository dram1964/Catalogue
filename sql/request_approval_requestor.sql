DROP TABLE IF EXISTS request_approval_requestor;

CREATE TABLE request_approval_requestor (
request_id int not null,
validated boolean not null default 0,
verification_method int,
notes text,
PRIMARY KEY (request_id),
CONSTRAINT fk_approval_requestor_request FOREIGN KEY (request_id) REFERENCES data_request (id) 
ON DELETE CASCADE ON UPDATE CASCADE
);



