DROP TABLE IF EXISTS data_request_type;

CREATE TABLE data_request_type (
  id int(11) NOT NULL AUTO_INCREMENT,
  request_type varchar(30) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO data_request_type (request_type)
VALUES ('cardiology'), ('chemotherapy'), ('diagnosis'), ('episode'),
('other'), ('pathology'), ('pharmacy'), ('radiology'), ('theatre');

DROP TABLE IF EXISTS data_request_detail;

CREATE TABLE data_request_detail (
  id int(11) NOT NULL AUTO_INCREMENT,
  data_request_id int NOT NULL, 
  data_request_type int NOT NULL,
  request_detail text,
  PRIMARY KEY (id),
  CONSTRAINT FOREIGN KEY (data_request_id) REFERENCES data_request (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FOREIGN KEY (data_request_type) REFERENCES data_request_type (id) ON DELETE CASCADE ON UPDATE CASCADE
);
