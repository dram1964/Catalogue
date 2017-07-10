DROP TABLE IF EXISTS approval_research_history;
DROP TABLE IF EXISTS approval_research;

CREATE TABLE approval_research (
request_id int not null,
rec_approval_ref varchar(30),
rec_approval_file varchar(30),
consent_method int,
approver int not null,
PRIMARY KEY (request_id),
CONSTRAINT fk_approval_research_request FOREIGN KEY (request_id) REFERENCES data_request (id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_approval_research_approver FOREIGN KEY (approver) REFERENCES users (id)
);


CREATE TABLE approval_research_history (
request_id int not null,
rec_approval_ref varchar(30),
rec_approval_file varchar(30),
consent_method int,
approval_date timestamp not null default CURRENT_TIMESTAMP,
approver int not null,
PRIMARY KEY (request_id, approval_date),
CONSTRAINT fk_approval_research_history FOREIGN KEY (request_id) REFERENCES approval_research (request_id) 
ON DELETE CASCADE ON UPDATE CASCADE
);

