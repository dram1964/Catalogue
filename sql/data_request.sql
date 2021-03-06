/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
--
-- Reworking for data_request
--

DROP TABLE IF EXISTS data_category;

CREATE TABLE data_category (
  id int(11) NOT NULL AUTO_INCREMENT,
  category varchar(30) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO data_category (category)
VALUES ('cardiology'), ('chemotherapy'), ('diagnosis'), ('episode'),
('other'), ('pathology'), ('pharmacy'), ('radiology'), ('theatre');

DROP TABLE IF EXISTS data_request_detail;

CREATE TABLE data_request_detail (
  data_request_id int NOT NULL, 
  data_category_id int NOT NULL,
  detail text,
  PRIMARY KEY (data_request_id, data_category_id),
  CONSTRAINT data_request_fk FOREIGN KEY (data_request_id) REFERENCES data_request (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT data_category_fk FOREIGN KEY (data_category_id) REFERENCES data_category (id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS data_request;

CREATE TABLE data_request (
id int(11) not null AUTO_INCREMENT,
user_id int(11) not null,
request_type_id int(11) not null,
status_id int(11) not null,
status_date TIMESTAMP NOT NULL DEFAULT NOW(), 
PRIMARY KEY (id),
CONSTRAINT request_user_fk FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT status_type_fk FOREIGN KEY (status_id) REFERENCES request_status (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT request_type_fk FOREIGN KEY (request_type_id) REFERENCES request_type (id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS request_detail_history;
DROP TABLE IF EXISTS request_history;

CREATE TABLE request_history (
  request_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  request_type_id int(11) DEFAULT NULL,
  status_id int(11) DEFAULT NULL,
  status_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  identifiable int(11) DEFAULT NULL,
  identifiers text,
  additional_identifiers text,
  publish int(11) DEFAULT NULL,
  publish_to text,
  storing text,
  completion text,
  additional_info text,
  objective text,
  service_area text,
  population text,
  research_area text,
  rec_approval text,
  consent text,
  PRIMARY KEY (request_id,status_date)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE request_detail_history (
  data_request_id int NOT NULL, 
  data_category_id int NOT NULL,
  status_date timestamp NOT NULL,
  detail text,
  PRIMARY KEY (data_request_id, data_category_id, status_date)
);
