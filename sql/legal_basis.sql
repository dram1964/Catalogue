DROP TABLE IF EXISTS legal_basis;

CREATE TABLE legal_basis (
id int(11) not null,
description text not null,
PRIMARY KEY (id)
);

INSERT INTO legal_basis VALUES
(1, 'Consent Obtained from all Data Subjects'),
(2, 'Section 251 Exemption Granted for all Data Subjects'),
(3, 'Contractual Obligation to Monitory and Improve Clinical Service Provision'),
(4, 'Direct Patient Care'),
(5, 'Statutory Requirement'),
(6, 'Public Health Interest');
