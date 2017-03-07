DROP TABLE IF EXISTS dataset_facts;

CREATE TABLE dataset_facts (
dataset_id int not null, 
fact_type varchar(50) not null,
fact JSON,
PRIMARY KEY(dataset_id, fact_type),
CONSTRAINT FOREIGN KEY (dataset_id) REFERENCES datasets (id) ON DELETE CASCADE ON UPDATE CASCADE);


INSERT INTO dataset_facts VALUES (
4, 'population',
JSON_OBJECT("ranges" , 
  JSON_ARRAY( 
   JSON_ARRAY("0 to 10", 10000), 
   JSON_ARRAY("10 TO 20", 20000), 
   JSON_ARRAY("20 to 30", 30000), 
   JSON_ARRAY("30 to 40", 40000),
   JSON_ARRAY("40 to 50", 50000),
   JSON_ARRAY("50 to 60", 60000),
   JSON_ARRAY("60 to 70", 70000),
   JSON_ARRAY("70 or more", 80000)
  ) 
));
