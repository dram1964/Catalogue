DROP TABLE IF EXISTS registration_request;

CREATE TABLE registration_request(
email_address varchar(50) not null,
first_name varchar(30) not null,
last_name varchar(30) not null,
password varchar(255) not null,
job_title varchar(100) not null,
department varchar(100) not null,
organisation varchar(100) not null,
address1 varchar(100) not null,
address2 varchar(100),
address3 varchar(100),
postcode varchar(10),
city varchar(100) not null,
telephone varchar(20) not null,
mobile varchar(20),
agree1 varchar(3),
agree2 varchar(3),
agree3 varchar(3),
request_date datetime not null default CURRENT_TIMESTAMP,
approval_date datetime,
approved_by varchar(50),
user_id int,
PRIMARY KEY (email_address),
CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);
