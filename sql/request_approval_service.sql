DROP TABLE IF EXISTS approval_service_history;
DROP TABLE IF EXISTS approval_service;

CREATE TABLE approval_service (
request_id int not null,
service_auth boolean not null default 0,
approver int not null,
PRIMARY KEY (request_id),
CONSTRAINT fk_approval_service_request FOREIGN KEY (request_id) REFERENCES data_request (id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_approval_service_approver FOREIGN KEY (approver) REFERENCES users (id)
);


CREATE TABLE approval_service_history (
request_id int not null,
service_auth boolean not null default 0,
approval_date timestamp not null default CURRENT_TIMESTAMP,
approver int not null,
PRIMARY KEY (request_id, approval_date),
CONSTRAINT fk_approval_service_history FOREIGN KEY (request_id) REFERENCES approval_service (request_id) 
ON DELETE CASCADE ON UPDATE CASCADE
);

