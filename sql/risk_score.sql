DROP TABLE IF EXISTS risk_score;

CREATE TABLE risk_score (
request_id int(11) not null,
risk_category varchar(250) not null, 
rating int(11) not null, 
likelihood int(11) not null,
risk_score int(11) not null,
PRIMAY KEY (request_id, risk_category),
CONSTRAINT FOREIGN KEY (request_id) references data_request (id) 
); 
