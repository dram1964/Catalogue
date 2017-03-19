DROP TABLE IF EXISTS dataset_facts;

CREATE TABLE dataset_facts (
dataset_id int not null, 
fact_type varchar(50) not null,
fact JSON,
PRIMARY KEY(dataset_id, fact_type),
CONSTRAINT FOREIGN KEY (dataset_id) REFERENCES datasets (id) ON DELETE CASCADE ON UPDATE CASCADE);


INSERT INTO dataset_facts VALUES (
1, 'population',
JSON_OBJECT("ranges" , 
  JSON_ARRAY( 
   JSON_ARRAY("0 to 10", 100000), 
   JSON_ARRAY("10 to 20", 235000), 
   JSON_ARRAY("20 to 30", 501000), 
   JSON_ARRAY("30 to 40", 600000),
   JSON_ARRAY("40 to 50", 838810),
   JSON_ARRAY("50 to 60", 738000),
   JSON_ARRAY("60 to 70", 450000),
   JSON_ARRAY("70 or more", 80000)
  ) 
));

INSERT INTO dataset_facts VALUES (
1, 'sample_types',
JSON_OBJECT("types", 
  JSON_ARRAY(
    JSON_ARRAY("Blood" , 1201978),
    JSON_ARRAY("Sputum" , 203334),
    JSON_ARRAY("Urine" , 630981),
    JSON_ARRAY("Stool" , 551939)
  )
));

INSERT INTO dataset_facts VALUES (
1, 'sample_specialties',
JSON_OBJECT("specialties", 
  JSON_ARRAY(
	JSON_ARRAY("Haematology" , 15339338),
	JSON_ARRAY("Clinical Biochemistry" , 12345881),
	JSON_ARRAY("Microbiology" , 5333818),
	JSON_ARRAY("Virology" , 4123876),
	JSON_ARRAY("Immunology" , 838356),
	JSON_ARRAY("Parasitology" , 68383)
  )
));

INSERT INTO dataset_facts VALUES (
2, 'population',
JSON_OBJECT("ranges" , 
  JSON_ARRAY( 
   JSON_ARRAY("0 to 10", 0), 
   JSON_ARRAY("10 TO 20", 0), 
   JSON_ARRAY("20 to 30", 51), 
   JSON_ARRAY("30 to 40", 600),
   JSON_ARRAY("40 to 50", 8310),
   JSON_ARRAY("50 to 60", 10000),
   JSON_ARRAY("60 to 70", 20000),
   JSON_ARRAY("70 or more", 80000)
  ) 
));

INSERT INTO dataset_facts VALUES (
2, 'cardio', JSON_OBJECT( "tasks", 
    JSON_OBJECT(
      "Angiogram", 12000, 
      "Echocardiogram", 8000
    )
  )
);

INSERT INTO dataset_facts VALUES (
2, 'tpt',
JSON_OBJECT("ranges" , 
  JSON_ARRAY(
    JSON_ARRAY("0 to  0.01", 1000),
    JSON_ARRAY(">0.01 to 0.02", 2000),
    JSON_ARRAY(">0.02 to 0.03", 3000),
    JSON_ARRAY(">0.03 to 0.04", 4000),
    JSON_ARRAY(">0.05", 26000)
  )
));

INSERT INTO dataset_facts VALUES (
3, 'hepatitis',
JSON_OBJECT("dashboard" , 
  JSON_ARRAY(
    JSON_ARRAY("Virus", "Gender", "Population"),
    JSON_ARRAY("HepA", "male", 25),
    JSON_ARRAY("HepA", "female", 17),
    JSON_ARRAY("HepB", "male", 24),
    JSON_ARRAY("HepB", "female", 18),
    JSON_ARRAY("HepC", "male", 11),
    JSON_ARRAY("HepC", "female", 12),
    JSON_ARRAY("HepD", "male", 15),
    JSON_ARRAY("HepD", "female", 27)
  )
));

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
