DROP TABLE IF EXISTS risk_category;

CREATE TABLE risk_category(
id int(11) NOT NULL AUTO_INCREMENT,
name varchar(250) NOT NULL,
PRIMARY KEY (id)
);

INSERT INTO risk_category values 
( 1, 'Potential benefits do not outweigh the potential risk of harm from processing PCD'),
( 2, 'Use of data incompatible with original purpose for which the data was collected'),
( 3, 'Excessive use of PCD items'),
( 4, 'Possible scope or function creep'),
( 5, 'Storage or use of inaccurate or outdated data'),
( 6, 'Use of data beyond subjects reasonable expectations'),
( 7, 'Objectionable use of data'),
( 8, 'Data will be used to make unjustifiable inferences or decisions'),
( 9, 'Inappropriate legal basis cited'),
(10, 'Collection or disclosure can not be justified'),
(11, 'Data can be lost or stolen'),
(12, 'Data can be accessed by unauthorised parties'),
(13, 'Data transferred, shared or published to unauthorised parties'),
(14, 'De-identification routines do not prevent re-identification'),
(15, 'Data can be linked to external data leading to unwarranted intrusion/impact'),
(16, 'Tangible harm may be caused to individuals'), 
(17, 'Intangible harm may be caused to individuals');

