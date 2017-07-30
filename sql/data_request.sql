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
  id int(11) NOT NULL AUTO_INCREMENT,
  data_request_id int NOT NULL, 
  data_category int NOT NULL,
  detail text,
  PRIMARY KEY (id),
  KEY data_category_fk (data_category),
  CONSTRAINT data_request_fk FOREIGN KEY (data_request_id) REFERENCES data_request (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT data_category_fk FOREIGN KEY (data_category) REFERENCES data_category (id) ON DELETE CASCADE ON UPDATE CASCADE
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

