DROP TABLE IF EXISTS data_request;

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
PRIMARY KEY (id),
CONSTRAINT request_user_fk FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);
