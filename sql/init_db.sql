--
-- Table structure for table `approval_identifiers`
--

DROP TABLE IF EXISTS `approval_identifiers`;

CREATE TABLE `approval_identifiers` (
  `request_id` int(11) NOT NULL,
  `ptName` tinyint(1) DEFAULT NULL,
  `ptNumber` tinyint(1) DEFAULT NULL,
  `dob` tinyint(1) DEFAULT NULL,
  `nhsNumber` tinyint(1) DEFAULT NULL,
  `addr` tinyint(1) DEFAULT NULL,
  `other` text,
  `approver` int(11) NOT NULL,
  PRIMARY KEY (`request_id`),
  KEY `key_approval_identifiers_approver` (`approver`),
  CONSTRAINT `fk_approval_identifiers_approver` FOREIGN KEY (`approver`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_approval_identifiers_request` FOREIGN KEY (`request_id`) REFERENCES `data_request` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `approval_identifiers_history`
--

DROP TABLE IF EXISTS `approval_identifiers_history`;

CREATE TABLE `approval_identifiers_history` (
  `request_id` int(11) NOT NULL,
  `ptName` tinyint(1) DEFAULT NULL,
  `ptNumber` tinyint(1) DEFAULT NULL,
  `dob` tinyint(1) DEFAULT NULL,
  `nhsNumber` tinyint(1) DEFAULT NULL,
  `addr` tinyint(1) DEFAULT NULL,
  `other` text,
  `approval_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `approver` int(11) NOT NULL,
  PRIMARY KEY (`request_id`,`approval_date`),
  CONSTRAINT `fk_approval_identifiers_history` FOREIGN KEY (`request_id`) REFERENCES `approval_identifiers` (`request_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `approval_requestor`
--

DROP TABLE IF EXISTS `approval_requestor`;

CREATE TABLE `approval_requestor` (
  `request_id` int(11) NOT NULL,
  `validated` tinyint(1) NOT NULL DEFAULT '0',
  `verification_method` int(11) DEFAULT NULL,
  `notes` text,
  `approver` int(11) NOT NULL,
  PRIMARY KEY (`request_id`),
  KEY `fk_approval_requesor_approver` (`approver`),
  CONSTRAINT `fk_approval_requesor_approver` FOREIGN KEY (`approver`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_approval_requestor_request` FOREIGN KEY (`request_id`) REFERENCES `data_request` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `approval_requestor_history`
--

DROP TABLE IF EXISTS `approval_requestor_history`;

CREATE TABLE `approval_requestor_history` (
  `request_id` int(11) NOT NULL,
  `approval_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `validated` tinyint(1) NOT NULL DEFAULT '0',
  `verification_method` int(11) DEFAULT NULL,
  `notes` text,
  `approver` int(11) NOT NULL,
  PRIMARY KEY (`request_id`,`approval_date`),
  CONSTRAINT `fk_approval_requestor_history` FOREIGN KEY (`request_id`) REFERENCES `approval_requestor` (`request_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `approval_research`
--

DROP TABLE IF EXISTS `approval_research`;

CREATE TABLE `approval_research` (
  `request_id` int(11) NOT NULL,
  `rec_approval_ref` varchar(30) DEFAULT NULL,
  `rec_approval_file` varchar(30) DEFAULT NULL,
  `consent_method` int(11) DEFAULT NULL,
  `approver` int(11) NOT NULL,
  PRIMARY KEY (`request_id`),
  KEY `fk_approval_research_approver` (`approver`),
  CONSTRAINT `fk_approval_research_approver` FOREIGN KEY (`approver`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_approval_research_request` FOREIGN KEY (`request_id`) REFERENCES `data_request` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `approval_research_history`
--

DROP TABLE IF EXISTS `approval_research_history`;

CREATE TABLE `approval_research_history` (
  `request_id` int(11) NOT NULL,
  `rec_approval_ref` varchar(30) DEFAULT NULL,
  `rec_approval_file` varchar(30) DEFAULT NULL,
  `consent_method` int(11) DEFAULT NULL,
  `approval_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `approver` int(11) NOT NULL,
  PRIMARY KEY (`request_id`,`approval_date`),
  CONSTRAINT `fk_approval_research_history` FOREIGN KEY (`request_id`) REFERENCES `approval_research` (`request_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `approval_service`
--

DROP TABLE IF EXISTS `approval_service`;

CREATE TABLE `approval_service` (
  `request_id` int(11) NOT NULL,
  `service_auth` tinyint(1) NOT NULL DEFAULT '0',
  `approver` int(11) NOT NULL,
  PRIMARY KEY (`request_id`),
  KEY `fk_approval_service_approver` (`approver`),
  CONSTRAINT `fk_approval_service_approver` FOREIGN KEY (`approver`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_approval_service_request` FOREIGN KEY (`request_id`) REFERENCES `data_request` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `approval_service_history`
--

DROP TABLE IF EXISTS `approval_service_history`;

CREATE TABLE `approval_service_history` (
  `request_id` int(11) NOT NULL,
  `service_auth` tinyint(1) NOT NULL DEFAULT '0',
  `approval_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `approver` int(11) NOT NULL,
  PRIMARY KEY (`request_id`,`approval_date`),
  CONSTRAINT `fk_approval_service_history` FOREIGN KEY (`request_id`) REFERENCES `approval_service` (`request_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `c_application`
--

DROP TABLE IF EXISTS `c_application`;

CREATE TABLE `c_application` (
  `app_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `erid_id` int(11) DEFAULT NULL,
  `kpe_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `cat2_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`app_id`),
  UNIQUE KEY `application_name_uni` (`name`),
  KEY `cat2_fk` (`cat2_id`),
  KEY `supplier_fk` (`supplier_id`),
  KEY `kpe_fk` (`kpe_id`),
  KEY `erid_fk` (`erid_id`),
  CONSTRAINT `cat2_fk` FOREIGN KEY (`cat2_id`) REFERENCES `cat2` (`cat2_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `erid_fk` FOREIGN KEY (`erid_id`) REFERENCES `erid` (`erid_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kpe_fk` FOREIGN KEY (`kpe_id`) REFERENCES `kpe` (`kpe_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `supplier_fk` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=latin1;

--
-- Table structure for table `c_column`
--

DROP TABLE IF EXISTS `c_column`;

CREATE TABLE `c_column` (
  `col_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `col_type` varchar(50) DEFAULT NULL,
  `col_size` varchar(50) DEFAULT NULL,
  `col_enum` varchar(50) DEFAULT NULL,
  `col_pattern` varchar(50) DEFAULT NULL,
  `completion_rate` varchar(50) DEFAULT NULL,
  `first_record_date` timestamp NULL DEFAULT NULL,
  `last_record_date` timestamp NULL DEFAULT NULL,
  `tbl_id` int(11) NOT NULL,
  PRIMARY KEY (`col_id`),
  KEY `column_table_fk` (`tbl_id`),
  CONSTRAINT `column_table_fk` FOREIGN KEY (`tbl_id`) REFERENCES `c_table` (`tbl_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=117019 DEFAULT CHARSET=latin1;

--
-- Table structure for table `c_database`
--

DROP TABLE IF EXISTS `c_database`;

CREATE TABLE `c_database` (
  `db_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `srv_id` int(11) NOT NULL,
  PRIMARY KEY (`db_id`),
  KEY `server_fk` (`srv_id`),
  CONSTRAINT `server_fk` FOREIGN KEY (`srv_id`) REFERENCES `c_server` (`srv_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Table structure for table `c_schema`
--

DROP TABLE IF EXISTS `c_schema`;

CREATE TABLE `c_schema` (
  `sch_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  `db_id` int(11) NOT NULL,
  PRIMARY KEY (`sch_id`),
  KEY `schema_db_fk` (`db_id`),
  CONSTRAINT `schema_db_fk` FOREIGN KEY (`db_id`) REFERENCES `c_database` (`db_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

--
-- Table structure for table `c_server`
--

DROP TABLE IF EXISTS `c_server`;

CREATE TABLE `c_server` (
  `srv_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`srv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Table structure for table `c_table`
--

DROP TABLE IF EXISTS `c_table`;

CREATE TABLE `c_table` (
  `tbl_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `description` text,
  `sch_id` int(11) NOT NULL,
  PRIMARY KEY (`tbl_id`),
  KEY `table_schema_fk` (`sch_id`),
  CONSTRAINT `table_schema_fk` FOREIGN KEY (`sch_id`) REFERENCES `c_schema` (`sch_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7970 DEFAULT CHARSET=latin1;

--
-- Table structure for table `cat2`
--

DROP TABLE IF EXISTS `cat2`;

CREATE TABLE `cat2` (
  `cat2_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`cat2_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_handling`
--

DROP TABLE IF EXISTS `data_handling`;

CREATE TABLE `data_handling` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` int(11) NOT NULL,
  `identifiable` int(11) DEFAULT NULL,
  `identifiers` text,
  `additional_identifiers` text,
  `publish` int(11) DEFAULT NULL,
  `publish_to` text,
  `storing` text,
  `completion` text,
  `additional_info` text,
  `objective` text,
  `service_area` text,
  `population` text,
  `research_area` text,
  `rec_approval` text,
  `consent` text,
  PRIMARY KEY (`id`),
  KEY `request_id_fk` (`request_id`),
  CONSTRAINT `request_id_fk` FOREIGN KEY (`request_id`) REFERENCES `data_request` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;

--
-- Table structure for table `data_request`
--

DROP TABLE IF EXISTS `data_request`;

CREATE TABLE `data_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `cardiology_details` text,
  `chemotherapy_details` text,
  `diagnosis_details` text,
  `episode_details` text,
  `other_details` text,
  `pathology_details` text,
  `pharmacy_details` text,
  `radiology_details` text,
  `theatre_details` text,
  `request_type_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `status_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `request_user_fk` (`user_id`),
  KEY `status_type_fk` (`status_id`),
  KEY `request_type_fk` (`request_type_id`),
  CONSTRAINT `request_type_fk` FOREIGN KEY (`request_type_id`) REFERENCES `request_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `request_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `status_type_fk` FOREIGN KEY (`status_id`) REFERENCES `request_status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;

--
-- Table structure for table `dataset_facts`
--

DROP TABLE IF EXISTS `dataset_facts`;

CREATE TABLE `dataset_facts` (
  `dataset_id` int(11) NOT NULL,
  `fact_type` varchar(50) NOT NULL,
  `fact` json DEFAULT NULL,
  PRIMARY KEY (`dataset_id`,`fact_type`),
  CONSTRAINT `dataset_facts_ibfk_1` FOREIGN KEY (`dataset_id`) REFERENCES `datasets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `datasets`
--

DROP TABLE IF EXISTS `datasets`;

CREATE TABLE `datasets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Table structure for table `db_type`
--

DROP TABLE IF EXISTS `db_type`;

CREATE TABLE `db_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Table structure for table `erid`
--

DROP TABLE IF EXISTS `erid`;

CREATE TABLE `erid` (
  `erid_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`erid_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Table structure for table `kpe`
--

DROP TABLE IF EXISTS `kpe`;

CREATE TABLE `kpe` (
  `kpe_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`kpe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;

--
-- Table structure for table `registration_request`
--

DROP TABLE IF EXISTS `registration_request`;

CREATE TABLE `registration_request` (
  `email_address` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `department` varchar(100) NOT NULL,
  `organisation` varchar(100) NOT NULL,
  `address1` varchar(100) NOT NULL,
  `address2` varchar(100) DEFAULT NULL,
  `address3` varchar(100) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `agree1` varchar(3) DEFAULT NULL,
  `agree2` varchar(3) DEFAULT NULL,
  `agree3` varchar(3) DEFAULT NULL,
  `request_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `approval_date` datetime DEFAULT NULL,
  `approved_by` varchar(50) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`email_address`),
  KEY `user_fk` (`user_id`),
  CONSTRAINT `user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `request_history`
--

DROP TABLE IF EXISTS `request_history`;

CREATE TABLE `request_history` (
  `request_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cardiology_details` text,
  `chemotherapy_details` text,
  `diagnosis_details` text,
  `episode_details` text,
  `other_details` text,
  `pathology_details` text,
  `pharmacy_details` text,
  `radiology_details` text,
  `theatre_details` text,
  `request_type_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `status_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `identifiable` int(11) DEFAULT NULL,
  `identifiers` text,
  `additional_identifiers` text,
  `publish` int(11) DEFAULT NULL,
  `publish_to` text,
  `storing` text,
  `completion` text,
  `additional_info` text,
  `objective` text,
  `service_area` text,
  `population` text,
  `research_area` text,
  `rec_approval` text,
  `consent` text,
  PRIMARY KEY (`request_id`,`status_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `request_status`
--

DROP TABLE IF EXISTS `request_status`;

CREATE TABLE `request_status` (
  `id` int(11) NOT NULL,
  `description` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `request_type`
--

DROP TABLE IF EXISTS `request_type`;

CREATE TABLE `request_type` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `role` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;

CREATE TABLE `supplier` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=latin1;

--
-- Table structure for table `todolist`
--

DROP TABLE IF EXISTS `todolist`;

CREATE TABLE `todolist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `task` varchar(100) NOT NULL,
  `comment` text,
  `project` varchar(50) NOT NULL DEFAULT 'Catalogue',
  `assigned_by` varchar(50) NOT NULL DEFAULT 'anon',
  `assigned_to` varchar(100) DEFAULT NULL,
  `completed_by` varchar(50) DEFAULT NULL,
  `completed_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;

CREATE TABLE `user_roles` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `role_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email_address` varchar(100) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `organisation` varchar(100) DEFAULT NULL,
  `address1` varchar(100) DEFAULT NULL,
  `address2` varchar(100) DEFAULT NULL,
  `address3` varchar(100) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;

--
-- Table structure for table `wp_fact`
--

DROP TABLE IF EXISTS `wp_fact`;

CREATE TABLE `wp_fact` (
  `order_code` varchar(4) NOT NULL,
  `test_code` varchar(4) NOT NULL,
  `laboratory_code` varchar(2) NOT NULL DEFAULT 'U',
  `cluster_name` varchar(30) NOT NULL,
  `year_of_birth` int(11) NOT NULL,
  `year_of_result` int(11) NOT NULL,
  `gender` char(1) NOT NULL,
  `requests` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_code`,`test_code`,`laboratory_code`,`cluster_name`,`year_of_birth`,`year_of_result`,`gender`),
  KEY `test_code_fk` (`test_code`),
  KEY `laboratory_code_fk` (`laboratory_code`),
  CONSTRAINT `laboratory_code_fk` FOREIGN KEY (`laboratory_code`) REFERENCES `wp_laboratory` (`code`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_code_fk` FOREIGN KEY (`order_code`) REFERENCES `wp_order` (`code`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `test_code_fk` FOREIGN KEY (`test_code`) REFERENCES `wp_test` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `wp_laboratory`
--

DROP TABLE IF EXISTS `wp_laboratory`;

CREATE TABLE `wp_laboratory` (
  `code` varchar(2) NOT NULL,
  `discipline` varchar(30) DEFAULT NULL,
  `cluster` varchar(30) DEFAULT NULL,
  `specialty` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `wp_order`
--

DROP TABLE IF EXISTS `wp_order`;

CREATE TABLE `wp_order` (
  `code` varchar(4) NOT NULL,
  `type` char(1) DEFAULT NULL,
  `description` varchar(30) DEFAULT NULL,
  `laboratory_code` varchar(2) NOT NULL DEFAULT 'U',
  PRIMARY KEY (`code`),
  KEY `laboratory_order_fk` (`laboratory_code`),
  CONSTRAINT `laboratory_order_fk` FOREIGN KEY (`laboratory_code`) REFERENCES `wp_laboratory` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `wp_test`
--

DROP TABLE IF EXISTS `wp_test`;

CREATE TABLE `wp_test` (
  `code` varchar(4) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `laboratory_code` varchar(2) NOT NULL DEFAULT 'U',
  `units` varchar(30) DEFAULT NULL,
  `function` varchar(30) DEFAULT NULL,
  `flags` varchar(30) DEFAULT NULL,
  `report_section` varchar(2) DEFAULT NULL,
  `line_number` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`,`laboratory_code`),
  KEY `laboratory_test_fk` (`laboratory_code`),
  CONSTRAINT `laboratory_test_fk` FOREIGN KEY (`laboratory_code`) REFERENCES `wp_laboratory` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
