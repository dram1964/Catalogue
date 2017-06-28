CREATE TABLE request_history (
request_id int(11) NOT NULL,
user_id int(11) NOT NULL,
cardiology_details text,
chemotherapy_details text,
diagnosis_details text,
episode_details text,
other_details text,
pathology_details text,
pharmacy_details text,
radiology_details text,
theatre_details text,
request_type_id int(11),
status_id int(11),
status_date timestamp NOT NULL,
identifiable int(11),
identifiers text,
additional_identifiers text,
publish int(11),
storing text,
completion text,
additional_info text,
objective text,
service_area text,
population text,
research_area text,
rec_approval text,
consent text,
PRIMARY KEY (request_id, status_date)
);
