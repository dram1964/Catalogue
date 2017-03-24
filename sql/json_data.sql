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
   JSON_ARRAY("10 to 20", 0), 
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
   JSON_ARRAY("10 to 20", 20000), 
   JSON_ARRAY("20 to 30", 30000), 
   JSON_ARRAY("30 to 40", 40000),
   JSON_ARRAY("40 to 50", 50000),
   JSON_ARRAY("50 to 60", 60000),
   JSON_ARRAY("60 to 70", 70000),
   JSON_ARRAY("70 or more", 80000)
  ) 
));

INSERT INTO dataset_facts VALUES (
1, 'orgchart', 
JSON_OBJECT("tree", 
  JSON_ARRAY(
    JSON_ARRAY("accnumber", "ptnumber", "Accession Number: Unique identifier for a sample"),
    JSON_ARRAY("ptnumber", "", "Patient Number: Unique identifier for a patient"),
    JSON_ARRAY("ptname", "ptnumber", "Patient Name: Name of patient providing the sample"),
    JSON_ARRAY("ptloc", "ptnumber", "Patient Location: Code for location of patient at sample collection"),
    JSON_ARRAY("ptsex", "ptnumber", "Patient Gender"),
    JSON_ARRAY("birthdate", "ptnumber", "Patient Gender"),
    JSON_ARRAY("collectdate", "accnumber", "Date sample collected"),
    JSON_ARRAY("collectime", "accnumber", "Time sample collected"),
    JSON_ARRAY("receivedate", "accnumber", "Date sample received in laboratory"),
    JSON_ARRAY("receivetime", "accnumber", "Time sample received in laboratory"),
    JSON_ARRAY("admitdate", "eventindex", "Start date of patient episode"),
    JSON_ARRAY("dischdate", "eventindex", "End date of patient episode"),
    JSON_ARRAY("admitphys1", "eventindex", "Code for primary physician associated with this patient episode"),
    JSON_ARRAY("admitphys2", "eventindex", "Code for secondary physician associated with this patient episode"),
    JSON_ARRAY("eventindex", "ptnumber", "Unique identifier for a patient episode"),
    JSON_ARRAY("eventtype", "eventindex", "Code for patient episode type"),
    JSON_ARRAY("orderdate", "accnumber", "Date order recorded on pathology system"),
    JSON_ARRAY("ordertime", "accnumber", "Time order recorded on pathology system"),
    JSON_ARRAY("ptorderloc", "accnumber", "Location of patient when order placed"),
    JSON_ARRAY("orderlab", "accnumber", "Code for laboratory placing the order"),
    JSON_ARRAY("orderphys", "accnumber", "Code for physician placing the order"),
    JSON_ARRAY("physcode", "accnumber", "Physician managing patient episode"),
    JSON_ARRAY("battestcode", "accnumber", "Code for pathology battery ordered"),
    JSON_ARRAY("testcode", "battestcode", "Code for pathology analyte"),
    JSON_ARRAY("resultdate", "testcode", "Date result obtained for analyte"),
    JSON_ARRAY("resulttime", "testcode", "Time result obtained for analyte"),
    JSON_ARRAY("result", "testcode", "Result obtained for analyte"),
    JSON_ARRAY("resultmodifiers", "testcode", "Result modifier codes"),
    JSON_ARRAY("resultqaflags", "testcode", "Result QA flags"),
    JSON_ARRAY("labdept", "battestcode", "Code for laboratory performing test battery"),
    JSON_ARRAY("spclbillcode", "accnumber", "Billing code for order"),
    JSON_ARRAY("hospcode", "accnumber", "Code for laboratory hospital location"),
    JSON_ARRAY("specimentype", "accnumber", "Code for specimen type"),
    JSON_ARRAY("creditdate", "accnumber", "Date billing credit note issued for order")
  )
));
