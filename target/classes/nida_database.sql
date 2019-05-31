/*
SQLyog Community Edition- MySQL GUI v8.14 
MySQL - 5.1.54-community : Database - nida_school_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`nida_school_db` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `nida_school_db`;

/*Table structure for table `advance_salary` */

DROP TABLE IF EXISTS `advance_salary`;

CREATE TABLE `advance_salary` (
  `advance_salary_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `date_of_payment` datetime DEFAULT NULL,
  `paid_amount` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `alloted_month_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`advance_salary_id`),
  KEY `FK6BD4E827FABA0282` (`employee_id`),
  KEY `FK6BD4E8276BB72D85` (`alloted_month_id`),
  KEY `FK6BD4E827F45088EB` (`session_id`),
  CONSTRAINT `FK6BD4E8276BB72D85` FOREIGN KEY (`alloted_month_id`) REFERENCES `month` (`month_id`),
  CONSTRAINT `FK6BD4E827F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`),
  CONSTRAINT `FK6BD4E827FABA0282` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `advance_salary` */

insert  into `advance_salary`(`advance_salary_id`,`is_active`,`date_of_payment`,`paid_amount`,`employee_id`,`alloted_month_id`,`session_id`) values (1,1,'2015-05-26 11:56:18',500,1,3,1);

/*Table structure for table `allot_dress` */

DROP TABLE IF EXISTS `allot_dress`;

CREATE TABLE `allot_dress` (
  `allotdress_id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` int(11) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `netamount` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `dress_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `student_admission_number` varchar(255) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `product_purchase_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`allotdress_id`),
  KEY `FKB14A83FE67C2729C` (`class_id`),
  KEY `FKB14A83FE9197618B` (`dress_id`),
  KEY `FKB14A83FEF45088EB` (`session_id`),
  KEY `FKB14A83FE1B690E8A` (`student_admission_number`),
  KEY `FKB14A83FEA5C20504` (`subject_id`),
  KEY `FKB14A83FEC5F0F28F` (`product_purchase_id`),
  KEY `FKB14A83FEAA42F28B` (`section_id`),
  CONSTRAINT `FKB14A83FE1B690E8A` FOREIGN KEY (`student_admission_number`) REFERENCES `students` (`student_admission_number`),
  CONSTRAINT `FKB14A83FE67C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FKB14A83FE9197618B` FOREIGN KEY (`dress_id`) REFERENCES `dress` (`dress_id`),
  CONSTRAINT `FKB14A83FEA5C20504` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`),
  CONSTRAINT `FKB14A83FEAA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FKB14A83FEC5F0F28F` FOREIGN KEY (`product_purchase_id`) REFERENCES `uniform_purchase` (`product_purchase_id`),
  CONSTRAINT `FKB14A83FEF45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `allot_dress` */

/*Table structure for table `annual_exam_gain_marks` */

DROP TABLE IF EXISTS `annual_exam_gain_marks`;

CREATE TABLE `annual_exam_gain_marks` (
  `annual_exam_gain_marks_id` int(11) NOT NULL AUTO_INCREMENT,
  `gain_marks` double DEFAULT NULL,
  `annual_exam_report_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`annual_exam_gain_marks_id`),
  KEY `FKD19BF44612E1BE7` (`annual_exam_report_id`),
  KEY `FKD19BF446A5C20504` (`subject_id`),
  CONSTRAINT `FKD19BF44612E1BE7` FOREIGN KEY (`annual_exam_report_id`) REFERENCES `annual_exam_report` (`annual_exam_report_id`),
  CONSTRAINT `FKD19BF446A5C20504` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `annual_exam_gain_marks` */

insert  into `annual_exam_gain_marks`(`annual_exam_gain_marks_id`,`gain_marks`,`annual_exam_report_id`,`subject_id`) values (1,61,1,1),(2,80,2,1);

/*Table structure for table `annual_exam_report` */

DROP TABLE IF EXISTS `annual_exam_report`;

CREATE TABLE `annual_exam_report` (
  `annual_exam_report_id` int(11) NOT NULL AUTO_INCREMENT,
  `annual_exam_type` varchar(255) DEFAULT NULL,
  `exam_type` varchar(255) DEFAULT NULL,
  `max_marks` double DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`annual_exam_report_id`),
  KEY `FK44A782F4AA42F28B` (`section_id`),
  KEY `FK44A782F4F45088EB` (`session_id`),
  KEY `FK44A782F467C2729C` (`class_id`),
  KEY `FK44A782F4759AFE66` (`student_id`),
  CONSTRAINT `FK44A782F467C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FK44A782F4759AFE66` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_admission_number`),
  CONSTRAINT `FK44A782F4AA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FK44A782F4F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `annual_exam_report` */

insert  into `annual_exam_report`(`annual_exam_report_id`,`annual_exam_type`,`exam_type`,`max_marks`,`section_id`,`session_id`,`class_id`,`student_id`) values (1,'HALF-YEARLY','MAIN EXAM',100,29,1,1,'1'),(2,'HALF-YEARLY','UT+ORAL+PROJECT',100,29,1,1,'1');

/*Table structure for table `annual_exam_total_gain_marks` */

DROP TABLE IF EXISTS `annual_exam_total_gain_marks`;

CREATE TABLE `annual_exam_total_gain_marks` (
  `annual_exam_total_gain_marks_id` int(11) NOT NULL AUTO_INCREMENT,
  `annual_exam_type` varchar(255) DEFAULT NULL,
  `total_gain_marks` double DEFAULT NULL,
  `total_marks` double DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`annual_exam_total_gain_marks_id`),
  KEY `FKBFCB2C21AA42F28B` (`section_id`),
  KEY `FKBFCB2C21F45088EB` (`session_id`),
  KEY `FKBFCB2C2167C2729C` (`class_id`),
  KEY `FKBFCB2C21759AFE66` (`student_id`),
  CONSTRAINT `FKBFCB2C2167C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FKBFCB2C21759AFE66` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_admission_number`),
  CONSTRAINT `FKBFCB2C21AA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FKBFCB2C21F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `annual_exam_total_gain_marks` */

insert  into `annual_exam_total_gain_marks`(`annual_exam_total_gain_marks_id`,`annual_exam_type`,`total_gain_marks`,`total_marks`,`section_id`,`session_id`,`class_id`,`student_id`) values (1,'HALF-YEARLY',141,200,29,1,1,'1');

/*Table structure for table `annually_subject_marks` */

DROP TABLE IF EXISTS `annually_subject_marks`;

CREATE TABLE `annually_subject_marks` (
  `annually_subject_marks_id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_report_type` varchar(255) DEFAULT NULL,
  `exam_type` varchar(255) DEFAULT NULL,
  `max_marks` varchar(255) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`annually_subject_marks_id`),
  KEY `FKF9FDF320AA42F28B` (`section_id`),
  KEY `FKF9FDF320F45088EB` (`session_id`),
  KEY `FKF9FDF32067C2729C` (`class_id`),
  KEY `FKF9FDF320A5C20504` (`subject_id`),
  CONSTRAINT `FKF9FDF32067C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FKF9FDF320A5C20504` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`),
  CONSTRAINT `FKF9FDF320AA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FKF9FDF320F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `annually_subject_marks` */

/*Table structure for table `assign_class` */

DROP TABLE IF EXISTS `assign_class`;

CREATE TABLE `assign_class` (
  `assign_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`assign_class_id`),
  KEY `FK8863DE28FABA0282` (`employee_id`),
  KEY `FK8863DE28AA42F28B` (`section_id`),
  KEY `FK8863DE2867C2729C` (`class_id`),
  CONSTRAINT `FK8863DE2867C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FK8863DE28AA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FK8863DE28FABA0282` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `assign_class` */

/*Table structure for table `book_purchase` */

DROP TABLE IF EXISTS `book_purchase`;

CREATE TABLE `book_purchase` (
  `book_purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `book_price` int(11) DEFAULT NULL,
  `book_title` varchar(255) DEFAULT NULL,
  `quantity_bought` int(11) DEFAULT NULL,
  `date_of_purchase` datetime DEFAULT NULL,
  `net_amount` int(11) DEFAULT NULL,
  `product_no` int(11) DEFAULT NULL,
  `quantity_remaining` int(11) DEFAULT NULL,
  `supplier_name` varchar(255) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `stock_purchase_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`book_purchase_id`),
  KEY `FKBB59319767C2729C` (`class_id`),
  KEY `FKBB593197F45088EB` (`session_id`),
  KEY `FKBB593197D8C74CF4` (`stock_purchase_id`),
  KEY `FKBB593197A5C20504` (`subject_id`),
  KEY `FKBB593197AA42F28B` (`section_id`),
  CONSTRAINT `FKBB59319767C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FKBB593197A5C20504` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`),
  CONSTRAINT `FKBB593197AA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FKBB593197D8C74CF4` FOREIGN KEY (`stock_purchase_id`) REFERENCES `book_supplier` (`stock_purchase_id`),
  CONSTRAINT `FKBB593197F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `book_purchase` */

/*Table structure for table `book_sell` */

DROP TABLE IF EXISTS `book_sell`;

CREATE TABLE `book_sell` (
  `book_payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(255) DEFAULT NULL,
  `cheque_no` int(11) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `dues` int(11) DEFAULT NULL,
  `dues_receiptno` int(11) DEFAULT NULL,
  `in_word` varchar(255) DEFAULT NULL,
  `paid_amount` int(11) DEFAULT NULL,
  `paid_status` varchar(255) DEFAULT NULL,
  `pay_date` datetime DEFAULT NULL,
  `payment_mode` varchar(255) DEFAULT NULL,
  `receipt_no` int(11) DEFAULT NULL,
  `total_amount` int(11) DEFAULT NULL,
  `book_purchase_id` int(11) DEFAULT NULL,
  `student_wise_fee_id` int(11) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`book_payment_id`),
  KEY `FK78AFB6E821A9777C` (`book_purchase_id`),
  KEY `FK78AFB6E88FFBD1E1` (`student_wise_fee_id`),
  KEY `FK78AFB6E8759AFE66` (`student_id`),
  CONSTRAINT `FK78AFB6E821A9777C` FOREIGN KEY (`book_purchase_id`) REFERENCES `book_purchase` (`book_purchase_id`),
  CONSTRAINT `FK78AFB6E8759AFE66` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_admission_number`),
  CONSTRAINT `FK78AFB6E88FFBD1E1` FOREIGN KEY (`student_wise_fee_id`) REFERENCES `student_wise_fee` (`student_wise_fee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `book_sell` */

/*Table structure for table `book_supplier` */

DROP TABLE IF EXISTS `book_supplier`;

CREATE TABLE `book_supplier` (
  `stock_purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `balance_amount` int(11) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `cheque_no` int(11) DEFAULT NULL,
  `date_of_purchase` datetime DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `dues` int(11) DEFAULT NULL,
  `gross_amount` int(11) DEFAULT NULL,
  `in_word` varchar(255) DEFAULT NULL,
  `paid_amount` int(11) DEFAULT NULL,
  `paid_status` varchar(255) DEFAULT NULL,
  `payment_mode` varchar(255) DEFAULT NULL,
  `receipt_no` int(11) DEFAULT NULL,
  `supplier_name` varchar(255) DEFAULT NULL,
  `supplier_no` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`stock_purchase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `book_supplier` */

/*Table structure for table `branch` */

DROP TABLE IF EXISTS `branch`;

CREATE TABLE `branch` (
  `branch_id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) DEFAULT NULL,
  `branch_active` varchar(255) DEFAULT NULL,
  `branch_address` varchar(255) DEFAULT NULL,
  `branch_city` varchar(255) DEFAULT NULL,
  `branch_code` varchar(255) DEFAULT NULL,
  `branch_contact` varchar(255) DEFAULT NULL,
  `branch_date` datetime DEFAULT NULL,
  `branch_effictive_date` varchar(255) DEFAULT NULL,
  `branch_manager` varchar(255) DEFAULT NULL,
  `branch_name` varchar(255) DEFAULT NULL,
  `branch_royalty` varchar(255) DEFAULT NULL,
  `branch_state` varchar(255) DEFAULT NULL,
  `branch_status` varchar(255) DEFAULT NULL,
  `branch_tax_percentage` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `branch` */

/*Table structure for table `catagory` */

DROP TABLE IF EXISTS `catagory`;

CREATE TABLE `catagory` (
  `catagory_id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) DEFAULT NULL,
  `catagory_date_created` varchar(255) DEFAULT NULL,
  `catagory_description` varchar(255) DEFAULT NULL,
  `catagory_name` varchar(255) DEFAULT NULL,
  `catagory_tex_percentage` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`catagory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `catagory` */

/*Table structure for table `city` */

DROP TABLE IF EXISTS `city`;

CREATE TABLE `city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `city_name` varchar(100) DEFAULT NULL,
  `city_code` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `country_id` varchar(100) DEFAULT NULL,
  `state_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `city` */

insert  into `city`(`city_id`,`city_name`,`city_code`,`created_at`,`updated_at`,`is_active`,`country_id`,`state_id`) values (4,'Delhi','DL','2014-12-01 00:00:00','2014-12-01 00:00:00',1,'1','4'),(6,'Noida','1002','2014-12-13 00:00:00','2014-12-13 00:00:00',1,'1','4');

/*Table structure for table `class` */

DROP TABLE IF EXISTS `class`;

CREATE TABLE `class` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(50) NOT NULL,
  `sl_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `class` */

insert  into `class`(`class_id`,`class_name`,`sl_no`) values (1,'Nursery',NULL),(2,'L.K.G',NULL),(3,'U.K.G',NULL),(4,'I',NULL),(5,'II',NULL),(6,'III',NULL),(7,'IV',NULL),(8,'V',NULL),(9,'VI',NULL),(10,'VII',NULL),(11,'VIII',NULL),(12,'IX',NULL),(13,'X',NULL),(14,'XI',NULL),(15,'XII',NULL);

/*Table structure for table `class_wise_fee` */

DROP TABLE IF EXISTS `class_wise_fee`;

CREATE TABLE `class_wise_fee` (
  `class_wise_fee_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `fee_amount` double DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `month_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`class_wise_fee_id`),
  KEY `FK4D8E285267C2729C` (`class_id`),
  KEY `FK4D8E28526C169794` (`category_id`),
  KEY `FK4D8E2852A9B190EB` (`month_id`),
  KEY `FK4D8E2852F45088EB` (`session_id`),
  CONSTRAINT `FK4D8E285267C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FK4D8E28526C169794` FOREIGN KEY (`category_id`) REFERENCES `fees_categories` (`fee_category_id`),
  CONSTRAINT `FK4D8E2852A9B190EB` FOREIGN KEY (`month_id`) REFERENCES `month` (`month_id`),
  CONSTRAINT `FK4D8E2852F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `class_wise_fee` */

insert  into `class_wise_fee`(`class_wise_fee_id`,`is_active`,`fee_amount`,`class_id`,`category_id`,`month_id`,`session_id`) values (1,1,200,1,1,13,1);

/*Table structure for table `country` */

DROP TABLE IF EXISTS `country`;

CREATE TABLE `country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(100) DEFAULT NULL,
  `country_code` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_active` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `country` */

insert  into `country`(`country_id`,`country_name`,`country_code`,`created_at`,`updated_at`,`is_active`) values (1,'India','1','2014-12-01 00:00:00','2014-12-01 00:00:00',1),(3,'Nepal',NULL,'2015-04-28 00:00:00','2015-04-28 00:00:00',1);

/*Table structure for table `discount` */

DROP TABLE IF EXISTS `discount`;

CREATE TABLE `discount` (
  `discount_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_delete` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `discount_about` varchar(255) DEFAULT NULL,
  `discount_amount` double DEFAULT NULL,
  `student_fee_sub_detail_id` int(11) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`discount_id`),
  KEY `FK10487541C5468449` (`student_fee_sub_detail_id`),
  KEY `FK10487541759AFE66` (`student_id`),
  CONSTRAINT `FK10487541759AFE66` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_admission_number`),
  CONSTRAINT `FK10487541C5468449` FOREIGN KEY (`student_fee_sub_detail_id`) REFERENCES `student_fee_submission_details` (`student_fee_submission_details_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `discount` */

insert  into `discount`(`discount_id`,`is_delete`,`created_at`,`discount_about`,`discount_amount`,`student_fee_sub_detail_id`,`student_id`) values (1,1,'2015-05-26 10:46:02',NULL,0,1,'1');

/*Table structure for table `document_category` */

DROP TABLE IF EXISTS `document_category`;

CREATE TABLE `document_category` (
  `document_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `document_category_name` varchar(255) DEFAULT NULL,
  `document_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `document_category` */

insert  into `document_category`(`document_category_id`,`is_active`,`document_category_name`,`document_type`) values (1,1,'Aadhar','Student');

/*Table structure for table `dress` */

DROP TABLE IF EXISTS `dress`;

CREATE TABLE `dress` (
  `dress_id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `dress_name` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dress_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `dress` */

/*Table structure for table `dress_payment` */

DROP TABLE IF EXISTS `dress_payment`;

CREATE TABLE `dress_payment` (
  `dress_payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(255) DEFAULT NULL,
  `cheque_no` int(11) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `dues` int(11) DEFAULT NULL,
  `dues_receiptno` int(11) DEFAULT NULL,
  `in_word` varchar(255) DEFAULT NULL,
  `paid_amount` int(11) DEFAULT NULL,
  `paid_status` varchar(255) DEFAULT NULL,
  `pay_date` datetime DEFAULT NULL,
  `payment_mode` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `receipt_no` int(11) DEFAULT NULL,
  `total_amount` int(11) DEFAULT NULL,
  `dress_id` int(11) DEFAULT NULL,
  `student_wise_fee_id` int(11) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  `product_purchase_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`dress_payment_id`),
  KEY `FKBEC3BFE9197618B` (`dress_id`),
  KEY `FKBEC3BFE8FFBD1E1` (`student_wise_fee_id`),
  KEY `FKBEC3BFE759AFE66` (`student_id`),
  KEY `FKBEC3BFEC5F0F28F` (`product_purchase_id`),
  CONSTRAINT `FKBEC3BFE759AFE66` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_admission_number`),
  CONSTRAINT `FKBEC3BFE8FFBD1E1` FOREIGN KEY (`student_wise_fee_id`) REFERENCES `student_wise_fee` (`student_wise_fee_id`),
  CONSTRAINT `FKBEC3BFE9197618B` FOREIGN KEY (`dress_id`) REFERENCES `dress` (`dress_id`),
  CONSTRAINT `FKBEC3BFEC5F0F28F` FOREIGN KEY (`product_purchase_id`) REFERENCES `uniform_purchase` (`product_purchase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `dress_payment` */

/*Table structure for table `edit_fee_amount` */

DROP TABLE IF EXISTS `edit_fee_amount`;

CREATE TABLE `edit_fee_amount` (
  `edit_fee_amount_id` int(11) NOT NULL AUTO_INCREMENT,
  `discount` double DEFAULT NULL,
  `fee_category_id` int(11) DEFAULT NULL,
  `month_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`edit_fee_amount_id`),
  KEY `FK5C927C864AA1685B` (`fee_category_id`),
  KEY `FK5C927C86A9B190EB` (`month_id`),
  KEY `FK5C927C86AA42F28B` (`section_id`),
  KEY `FK5C927C86F45088EB` (`session_id`),
  KEY `FK5C927C8667C2729C` (`class_id`),
  KEY `FK5C927C86759AFE66` (`student_id`),
  CONSTRAINT `FK5C927C864AA1685B` FOREIGN KEY (`fee_category_id`) REFERENCES `fees_categories` (`fee_category_id`),
  CONSTRAINT `FK5C927C8667C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FK5C927C86759AFE66` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_admission_number`),
  CONSTRAINT `FK5C927C86A9B190EB` FOREIGN KEY (`month_id`) REFERENCES `month` (`month_id`),
  CONSTRAINT `FK5C927C86AA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FK5C927C86F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `edit_fee_amount` */

/*Table structure for table `employee_attendance` */

DROP TABLE IF EXISTS `employee_attendance`;

CREATE TABLE `employee_attendance` (
  `employee_attendance_id` int(11) NOT NULL AUTO_INCREMENT,
  `attendance_status` varchar(255) DEFAULT NULL,
  `date_of_attendance` date DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`employee_attendance_id`),
  KEY `FKD6E5F91AFABA0282` (`employee_id`),
  CONSTRAINT `FKD6E5F91AFABA0282` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `employee_attendance` */

/*Table structure for table `employee_document` */

DROP TABLE IF EXISTS `employee_document`;

CREATE TABLE `employee_document` (
  `employee_document_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `uploaded_on` datetime DEFAULT NULL,
  `document_category_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`employee_document_id`),
  KEY `FKDD6CBF8C4131345F` (`document_category_id`),
  KEY `FKDD6CBF8CFABA0282` (`employee_id`),
  CONSTRAINT `FKDD6CBF8C4131345F` FOREIGN KEY (`document_category_id`) REFERENCES `document_category` (`document_category_id`),
  CONSTRAINT `FKDD6CBF8CFABA0282` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `employee_document` */

/*Table structure for table `employee_role` */

DROP TABLE IF EXISTS `employee_role`;

CREATE TABLE `employee_role` (
  `employee_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `employee_role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`employee_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `employee_role` */

/*Table structure for table `employee_salary` */

DROP TABLE IF EXISTS `employee_salary`;

CREATE TABLE `employee_salary` (
  `employee_salary_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `cheque_no` varchar(255) DEFAULT NULL,
  `date_of_payment` datetime DEFAULT NULL,
  `due` int(11) DEFAULT NULL,
  `fine_amount` int(11) DEFAULT NULL,
  `incentive` int(11) DEFAULT NULL,
  `paid_amount` int(11) DEFAULT NULL,
  `paid_amount_in_word` varchar(255) DEFAULT NULL,
  `paid_by` varchar(255) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `salary_amount` int(11) DEFAULT NULL,
  `salary_paid_status` varchar(255) DEFAULT NULL,
  `slip_no` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `month_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `advance` int(11) DEFAULT NULL,
  PRIMARY KEY (`employee_salary_id`),
  KEY `FK2331A07BFABA0282` (`employee_id`),
  KEY `FK2331A07BA9B190EB` (`month_id`),
  KEY `FK2331A07BF45088EB` (`session_id`),
  CONSTRAINT `FK2331A07BA9B190EB` FOREIGN KEY (`month_id`) REFERENCES `month` (`month_id`),
  CONSTRAINT `FK2331A07BF45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`),
  CONSTRAINT `FK2331A07BFABA0282` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `employee_salary` */

/*Table structure for table `employees` */

DROP TABLE IF EXISTS `employees`;

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_Active` tinyint(1) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `birth_place` varchar(255) DEFAULT NULL,
  `blood_group` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `highest_qualification` varchar(255) DEFAULT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  `joining_date` datetime DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `mother_tongue` varchar(255) DEFAULT NULL,
  `occupation` varchar(255) DEFAULT NULL,
  `passout_month` varchar(255) DEFAULT NULL,
  `passout_year` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `pin_code` varchar(255) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `FK9D39EF8576F31C89` (`city_id`),
  KEY `FK9D39EF85176468EB` (`country_id`),
  KEY `FK9D39EF85B9E0B4B` (`state_id`),
  KEY `FK9D39EF853F658089` (`user_id`),
  CONSTRAINT `FK9D39EF85176468EB` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`),
  CONSTRAINT `FK9D39EF853F658089` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`),
  CONSTRAINT `FK9D39EF8576F31C89` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  CONSTRAINT `FK9D39EF85B9E0B4B` FOREIGN KEY (`state_id`) REFERENCES `state` (`state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `employees` */

insert  into `employees`(`employee_id`,`is_Active`,`address`,`birth_place`,`blood_group`,`created_at`,`date_of_birth`,`email`,`father_name`,`first_name`,`gender`,`highest_qualification`,`image_name`,`joining_date`,`last_name`,`mobile`,`mother_name`,`mother_tongue`,`occupation`,`passout_month`,`passout_year`,`password`,`pin_code`,`salary`,`updated_at`,`city_id`,`country_id`,`state_id`,`user_id`) values (1,1,'rgvrtfhbh ','','','2015-05-26 10:40:47','2015-05-13 00:00:00','','hjmkmj','hgjh kukm','Male','BA','defultimage.png','2015-05-05 00:00:00','juk uikmui','5676576879','hjmhmkj','','hbghbgn','FEB','2013','790569','645657',8000,'2015-05-26 10:40:47',4,1,4,5);

/*Table structure for table `enquiry` */

DROP TABLE IF EXISTS `enquiry`;

CREATE TABLE `enquiry` (
  `enquiry_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `child_name` varchar(255) DEFAULT NULL,
  `city` int(11) DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `father_occupation` varchar(255) DEFAULT NULL,
  `followup_date` datetime DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `info_source` varchar(255) DEFAULT NULL,
  `mobile_no` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `mother_occupation` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `residence_phone_no` varchar(255) DEFAULT NULL,
  `sibling1_age` varchar(255) DEFAULT NULL,
  `sibling1_name` varchar(255) DEFAULT NULL,
  `sibling2_age` varchar(255) DEFAULT NULL,
  `sibling2_name` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `visited_website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`enquiry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `enquiry` */

/*Table structure for table `expenses` */

DROP TABLE IF EXISTS `expenses`;

CREATE TABLE `expenses` (
  `expenses_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `employee_name` varchar(255) DEFAULT NULL,
  `employee_role` varchar(255) DEFAULT NULL,
  `expense_amount` float DEFAULT NULL,
  `purpose_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`expenses_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `expenses` */

/*Table structure for table `fee` */

DROP TABLE IF EXISTS `fee`;

CREATE TABLE `fee` (
  `fee_id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) DEFAULT NULL,
  `activity_charges` int(11) DEFAULT NULL,
  `addmission_fee` int(11) DEFAULT NULL,
  `annual_charges` int(11) DEFAULT NULL,
  `annual_fee_to_date` datetime DEFAULT NULL,
  `annul_fee_from_date` datetime DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `branch_id` varchar(255) DEFAULT NULL,
  `cheque_amount` int(11) DEFAULT NULL,
  `cheque_number` varchar(255) DEFAULT NULL,
  `child_name` varchar(255) DEFAULT NULL,
  `development_charges` int(11) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `fee_for` varchar(255) DEFAULT NULL,
  `fee_from_date` datetime DEFAULT NULL,
  `fee_to_date` datetime DEFAULT NULL,
  `fine_amount` int(11) DEFAULT NULL,
  `monthly_quartely` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `payment_name` varchar(255) DEFAULT NULL,
  `prospects_fee` int(11) DEFAULT NULL,
  `reciept_number` int(11) DEFAULT NULL,
  `registration_fee` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `token_amount` int(11) DEFAULT NULL,
  `total_fee` int(11) DEFAULT NULL,
  PRIMARY KEY (`fee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `fee` */

/*Table structure for table `fee_discount` */

DROP TABLE IF EXISTS `fee_discount`;

CREATE TABLE `fee_discount` (
  `fee_discount_id` int(11) NOT NULL AUTO_INCREMENT,
  `fee_discount_amount` double DEFAULT NULL,
  `fee_discount_name` varchar(255) DEFAULT NULL,
  `from_date` datetime DEFAULT NULL,
  `last_date` datetime DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fee_discount_id`),
  KEY `FK45A9B1DAAA42F28B` (`section_id`),
  KEY `FK45A9B1DA67C2729C` (`class_id`),
  KEY `FK45A9B1DA759AFE66` (`student_id`),
  CONSTRAINT `FK45A9B1DA67C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FK45A9B1DA759AFE66` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_admission_number`),
  CONSTRAINT `FK45A9B1DAAA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `fee_discount` */

/*Table structure for table `fees_categories` */

DROP TABLE IF EXISTS `fees_categories`;

CREATE TABLE `fees_categories` (
  `fee_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `fee_category_name` varchar(40) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`fee_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `fees_categories` */

insert  into `fees_categories`(`fee_category_id`,`fee_category_name`,`is_active`) values (1,'Tution Fee',1),(4,'Admission Fee',1),(5,'Annual Charge',1),(7,'Fine',1),(13,'Any Other Dues',1),(14,'Uniform Fees',1),(15,'Book Fees',1);

/*Table structure for table `fine` */

DROP TABLE IF EXISTS `fine`;

CREATE TABLE `fine` (
  `fine_id` int(11) NOT NULL AUTO_INCREMENT,
  `fine_name` varchar(50) DEFAULT NULL,
  `fine_amount` int(11) DEFAULT NULL,
  `max_fine_amount` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`fine_id`),
  KEY `FK2FF5BAF45088EB` (`session_id`),
  CONSTRAINT `FK2FF5BAF45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `fine` */

/*Table structure for table `gate_pass` */

DROP TABLE IF EXISTS `gate_pass`;

CREATE TABLE `gate_pass` (
  `gate_pass_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `leaving_date` date DEFAULT NULL,
  `leaving_time` time DEFAULT NULL,
  `leaving_with` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `admission_no` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`gate_pass_id`),
  KEY `FKADF61705C130EE7E` (`admission_no`),
  CONSTRAINT `FKADF61705C130EE7E` FOREIGN KEY (`admission_no`) REFERENCES `students` (`student_admission_number`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `gate_pass` */

insert  into `gate_pass`(`gate_pass_id`,`is_active`,`leaving_date`,`leaving_time`,`leaving_with`,`reason`,`admission_no`) values (1,1,'2015-05-26','10:37:15','Father','dfdrg','1');

/*Table structure for table `holiday` */

DROP TABLE IF EXISTS `holiday`;

CREATE TABLE `holiday` (
  `holiday_id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `holiday_date` date DEFAULT NULL,
  PRIMARY KEY (`holiday_id`),
  KEY `FK41152858F45088EB` (`session_id`),
  CONSTRAINT `FK41152858F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `holiday` */

/*Table structure for table `isbn` */

DROP TABLE IF EXISTS `isbn`;

CREATE TABLE `isbn` (
  `isbn_id` int(11) NOT NULL AUTO_INCREMENT,
  `isbn_no` varchar(255) DEFAULT NULL,
  `library_book_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`isbn_id`),
  KEY `FK3176F644C60E59` (`library_book_id`),
  CONSTRAINT `FK3176F644C60E59` FOREIGN KEY (`library_book_id`) REFERENCES `library` (`library_book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `isbn` */

/*Table structure for table `issue_book` */

DROP TABLE IF EXISTS `issue_book`;

CREATE TABLE `issue_book` (
  `issue_book_id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` tinyblob,
  `issue_date` datetime DEFAULT NULL,
  `student_id` tinyblob,
  PRIMARY KEY (`issue_book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `issue_book` */

/*Table structure for table `last_date` */

DROP TABLE IF EXISTS `last_date`;

CREATE TABLE `last_date` (
  `lastdate_id` int(11) NOT NULL AUTO_INCREMENT,
  `month_id` int(11) DEFAULT NULL,
  `lastdate` date DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`lastdate_id`),
  KEY `FK77F943B7A9B190EB` (`month_id`),
  KEY `FK77F943B7F45088EB` (`session_id`),
  CONSTRAINT `FK77F943B7A9B190EB` FOREIGN KEY (`month_id`) REFERENCES `month` (`month_id`),
  CONSTRAINT `FK77F943B7F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `last_date` */

insert  into `last_date`(`lastdate_id`,`month_id`,`lastdate`,`session_id`) values (1,1,'2015-04-10',1),(2,2,'2015-05-10',1),(3,3,'2015-06-10',1),(4,4,'2015-07-10',1),(5,5,'2015-08-10',1),(6,6,'2015-09-10',1),(7,7,'2015-10-10',1),(8,8,'2015-11-10',1),(9,9,'2015-12-10',1),(10,10,'2016-01-10',1),(11,11,'2016-02-10',1),(12,12,'2016-03-10',1);

/*Table structure for table `library` */

DROP TABLE IF EXISTS `library`;

CREATE TABLE `library` (
  `library_book_id` int(11) NOT NULL AUTO_INCREMENT,
  `book_name` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `remaining_quantity` int(11) DEFAULT NULL,
  `subject_name` varchar(255) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`library_book_id`),
  KEY `FK9E824BB67C2729C` (`class_id`),
  CONSTRAINT `FK9E824BB67C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `library` */

/*Table structure for table `library_settings` */

DROP TABLE IF EXISTS `library_settings`;

CREATE TABLE `library_settings` (
  `library_setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) DEFAULT NULL,
  `fine_amount` double DEFAULT NULL,
  `maximum_no_books` int(11) DEFAULT NULL,
  `maximum_no_days` int(11) DEFAULT NULL,
  `max_fine` double DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`library_setting_id`),
  KEY `FKBB8DEB27F45088EB` (`session_id`),
  CONSTRAINT `FKBB8DEB27F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `library_settings` */

/*Table structure for table `login_role` */

DROP TABLE IF EXISTS `login_role`;

CREATE TABLE `login_role` (
  `ID` smallint(6) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(50) NOT NULL,
  `DESCRIPTION` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `login_role` */

insert  into `login_role`(`ID`,`NAME`,`DESCRIPTION`) values (1,'ROLE_ADMIN','Adminstrator'),(2,'ROLE_STUDENT','Student'),(3,'ROLE_EMPLOYEE','Employee'),(4,'ROLE_PARENTS','Parents'),(5,'ROLE_BRANCH','Branch');

/*Table structure for table `month` */

DROP TABLE IF EXISTS `month`;

CREATE TABLE `month` (
  `month_id` int(11) NOT NULL AUTO_INCREMENT,
  `month_name` varchar(40) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `serial_no` int(1) DEFAULT NULL,
  PRIMARY KEY (`month_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `month` */

insert  into `month`(`month_id`,`month_name`,`is_active`,`serial_no`) values (1,'Apr',1,1),(2,'May',1,2),(3,'Jun',1,3),(4,'Jul',1,4),(5,'Aug',1,5),(6,'Sep',1,6),(7,'Oct',1,7),(8,'Nov',1,8),(9,'Dec',1,9),(10,'Jan',1,10),(11,'Feb',1,11),(12,'Mar',1,12),(13,'All',1,13);

/*Table structure for table `monthly_exam_report` */

DROP TABLE IF EXISTS `monthly_exam_report`;

CREATE TABLE `monthly_exam_report` (
  `monthly_exam_report_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `marks` double DEFAULT NULL,
  `max_marks` double DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `month_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`monthly_exam_report_id`),
  KEY `FK20A34C22A9B190EB` (`month_id`),
  KEY `FK20A34C22AA42F28B` (`section_id`),
  KEY `FK20A34C22F45088EB` (`session_id`),
  KEY `FK20A34C2267C2729C` (`class_id`),
  KEY `FK20A34C22759AFE66` (`student_id`),
  KEY `FK20A34C22A5C20504` (`subject_id`),
  CONSTRAINT `FK20A34C2267C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FK20A34C22759AFE66` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_admission_number`),
  CONSTRAINT `FK20A34C22A5C20504` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`),
  CONSTRAINT `FK20A34C22A9B190EB` FOREIGN KEY (`month_id`) REFERENCES `month` (`month_id`),
  CONSTRAINT `FK20A34C22AA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FK20A34C22F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `monthly_exam_report` */

/*Table structure for table `new_studenttransfer` */

DROP TABLE IF EXISTS `new_studenttransfer`;

CREATE TABLE `new_studenttransfer` (
  `transferId` int(11) NOT NULL AUTO_INCREMENT,
  `BehaviourInIX` varchar(255) DEFAULT NULL,
  `BehaviourInVI` varchar(255) DEFAULT NULL,
  `BehaviourInVII` varchar(255) DEFAULT NULL,
  `BehaviourInVIII` varchar(255) DEFAULT NULL,
  `BehaviourInX` varchar(255) DEFAULT NULL,
  `BehaviourInXI` varchar(255) DEFAULT NULL,
  `BehaviourInXII` varchar(255) DEFAULT NULL,
  `SignatureOfPrincipalInIX` varchar(255) DEFAULT NULL,
  `SignatureOfPrincipalInVI` varchar(255) DEFAULT NULL,
  `SignatureOfPrincipalInVII` varchar(255) DEFAULT NULL,
  `SignatureOfPrincipalInVIII` varchar(255) DEFAULT NULL,
  `SignatureOfPrincipalInX` varchar(255) DEFAULT NULL,
  `SignatureOfPrincipalInXI` varchar(255) DEFAULT NULL,
  `SignatureOfPrincipalInXII` varchar(255) DEFAULT NULL,
  `UPDefaultDurationOfStay` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `dateOfEntryInIX` varchar(255) DEFAULT NULL,
  `dateOfEntryInVI` varchar(255) DEFAULT NULL,
  `dateOfEntryInVII` varchar(255) DEFAULT NULL,
  `dateOfEntryInVIII` varchar(255) DEFAULT NULL,
  `dateOfEntryInX` varchar(255) DEFAULT NULL,
  `dateOfEntryInXI` varchar(255) DEFAULT NULL,
  `dateOfEntryInXII` varchar(255) DEFAULT NULL,
  `dateOfPromotionInIX` varchar(255) DEFAULT NULL,
  `dateOfPromotionInVI` varchar(255) DEFAULT NULL,
  `dateOfPromotionInVII` varchar(255) DEFAULT NULL,
  `dateOfPromotionInVIII` varchar(255) DEFAULT NULL,
  `dateOfPromotionInX` varchar(255) DEFAULT NULL,
  `dateOfPromotionInXI` varchar(255) DEFAULT NULL,
  `dateOfPromotionInXII` varchar(255) DEFAULT NULL,
  `dateOfTransferInIX` varchar(255) DEFAULT NULL,
  `dateOfTransferInVI` varchar(255) DEFAULT NULL,
  `dateOfTransferInVII` varchar(255) DEFAULT NULL,
  `dateOfTransferInVIII` varchar(255) DEFAULT NULL,
  `dateOfTransferInX` varchar(255) DEFAULT NULL,
  `dateOfTransferInXI` varchar(255) DEFAULT NULL,
  `dateOfTransferInXII` varchar(255) DEFAULT NULL,
  `dobInWords` varchar(255) DEFAULT NULL,
  `fatherOccuption` varchar(255) DEFAULT NULL,
  `reasonForTransferInIX` varchar(255) DEFAULT NULL,
  `reasonForTransferInVI` varchar(255) DEFAULT NULL,
  `reasonForTransferInVII` varchar(255) DEFAULT NULL,
  `reasonForTransferInVIII` varchar(255) DEFAULT NULL,
  `reasonForTransferInX` varchar(255) DEFAULT NULL,
  `reasonForTransferInXI` varchar(255) DEFAULT NULL,
  `reasonForTransferInXII` varchar(255) DEFAULT NULL,
  `cast` varchar(255) DEFAULT NULL,
  `resultInIX` varchar(255) DEFAULT NULL,
  `resultInVI` varchar(255) DEFAULT NULL,
  `resultInVII` varchar(255) DEFAULT NULL,
  `resultInVIII` varchar(255) DEFAULT NULL,
  `resultInX` varchar(255) DEFAULT NULL,
  `resultInXI` varchar(255) DEFAULT NULL,
  `resultInXII` varchar(255) DEFAULT NULL,
  `sessionInIX` varchar(255) DEFAULT NULL,
  `sessionInVI` varchar(255) DEFAULT NULL,
  `sessionInVII` varchar(255) DEFAULT NULL,
  `sessionInVIII` varchar(255) DEFAULT NULL,
  `sessionInX` varchar(255) DEFAULT NULL,
  `sessionInXI` varchar(255) DEFAULT NULL,
  `sessionInXII` varchar(255) DEFAULT NULL,
  `studentId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`transferId`),
  KEY `FK1E7772673D8B695D` (`studentId`),
  CONSTRAINT `FK1E7772673D8B695D` FOREIGN KEY (`studentId`) REFERENCES `students` (`student_admission_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `new_studenttransfer` */

/*Table structure for table `notice` */

DROP TABLE IF EXISTS `notice`;

CREATE TABLE `notice` (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `genrated_by` varchar(255) DEFAULT NULL,
  `notice_date` datetime DEFAULT NULL,
  `notice_description` varchar(255) DEFAULT NULL,
  `notice_subject` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `notice` */

/*Table structure for table `parents` */

DROP TABLE IF EXISTS `parents`;

CREATE TABLE `parents` (
  `parents_id` int(11) NOT NULL AUTO_INCREMENT,
  `parents_email` varchar(255) DEFAULT NULL,
  `parents_mobile` varchar(255) DEFAULT NULL,
  `parents_name` varchar(255) DEFAULT NULL,
  `student_admission_number` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`parents_id`),
  KEY `FKD0B60D091B690E8A` (`student_admission_number`),
  KEY `FKD0B60D093F658089` (`user_id`),
  CONSTRAINT `FKD0B60D091B690E8A` FOREIGN KEY (`student_admission_number`) REFERENCES `students` (`student_admission_number`),
  CONSTRAINT `FKD0B60D093F658089` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `parents` */

/*Table structure for table `payment_due_date` */

DROP TABLE IF EXISTS `payment_due_date`;

CREATE TABLE `payment_due_date` (
  `lastdate_id` int(11) NOT NULL AUTO_INCREMENT,
  `lastdate` datetime DEFAULT NULL,
  `month_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`lastdate_id`),
  KEY `FK388BA132A9B190EB` (`month_id`),
  CONSTRAINT `FK388BA132A9B190EB` FOREIGN KEY (`month_id`) REFERENCES `month` (`month_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `payment_due_date` */

/*Table structure for table `religion` */

DROP TABLE IF EXISTS `religion`;

CREATE TABLE `religion` (
  `religion_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `religion_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`religion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `religion` */

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRIPTION` varchar(100) DEFAULT NULL,
  `NAME` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID` (`ID`),
  UNIQUE KEY `NAME` (`NAME`),
  UNIQUE KEY `NAME_2` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `role` */

/*Table structure for table `section` */

DROP TABLE IF EXISTS `section`;

CREATE TABLE `section` (
  `section_id` int(11) NOT NULL AUTO_INCREMENT,
  `section_name` varchar(255) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  KEY `FK756F7EE567C2729C` (`class_id`),
  CONSTRAINT `FK756F7EE567C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

/*Data for the table `section` */

insert  into `section`(`section_id`,`section_name`,`class_id`) values (29,'A',1),(30,'A',2),(31,'A',3),(32,'A',4),(33,'A',5),(34,'A',6),(35,'A',7),(36,'A',8),(37,'A',9),(38,'A',10),(39,'A',11),(40,'A',12),(41,'A',13),(42,'B',4);

/*Table structure for table `section_wise_fee` */

DROP TABLE IF EXISTS `section_wise_fee`;

CREATE TABLE `section_wise_fee` (
  `section_wise_fee_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `fee_amount` double DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `month_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`section_wise_fee_id`),
  KEY `FKAE491D8567C2729C` (`class_id`),
  KEY `FKAE491D856C169794` (`category_id`),
  KEY `FKAE491D85A9B190EB` (`month_id`),
  KEY `FKAE491D85AA42F28B` (`section_id`),
  KEY `FKAE491D85F45088EB` (`session_id`),
  CONSTRAINT `FKAE491D8567C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FKAE491D856C169794` FOREIGN KEY (`category_id`) REFERENCES `fees_categories` (`fee_category_id`),
  CONSTRAINT `FKAE491D85A9B190EB` FOREIGN KEY (`month_id`) REFERENCES `month` (`month_id`),
  CONSTRAINT `FKAE491D85AA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FKAE491D85F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `section_wise_fee` */

/*Table structure for table `session` */

DROP TABLE IF EXISTS `session`;

CREATE TABLE `session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  `session_duration` varchar(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `current_session` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `session` */

insert  into `session`(`session_id`,`session_duration`,`is_active`,`current_session`) values (1,'2015-2016',1,1),(2,'2014-2015',1,0);

/*Table structure for table `state` */

DROP TABLE IF EXISTS `state`;

CREATE TABLE `state` (
  `state_id` int(11) NOT NULL AUTO_INCREMENT,
  `state_name` varchar(100) DEFAULT NULL,
  `state_code` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `country_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `state` */

insert  into `state`(`state_id`,`state_name`,`state_code`,`created_at`,`updated_at`,`is_active`,`country_id`) values (4,'Delhi NCR','1','2014-12-01 00:00:00','2014-12-13 00:00:00',1,'1'),(5,'Uttar Pradesh','UP','2015-01-02 00:00:00','2015-01-02 00:00:00',1,'1'),(6,'Haryana','HR','2015-01-13 00:00:00','2015-01-13 00:00:00',1,'1'),(8,'Punjab',NULL,'2015-04-28 00:00:00','2015-04-28 00:00:00',1,'1');

/*Table structure for table `student_admission` */

DROP TABLE IF EXISTS `student_admission`;

CREATE TABLE `student_admission` (
  `student_id` int(11) NOT NULL AUTO_INCREMENT,
  `admission_date` datetime DEFAULT NULL,
  `admission_no` varchar(255) DEFAULT NULL,
  `admit_in_class` varchar(255) DEFAULT NULL,
  `brother_or_sister_age1` varchar(255) DEFAULT NULL,
  `brother_or_sister_age2` varchar(255) DEFAULT NULL,
  `brother_or_sister_class1` varchar(255) DEFAULT NULL,
  `brother_or_sister_class2` varchar(255) DEFAULT NULL,
  `brother_or_sister_name1` varchar(255) DEFAULT NULL,
  `brother_or_sister_name2` varchar(255) DEFAULT NULL,
  `brother_or_sister_school_or_college1` varchar(255) DEFAULT NULL,
  `brother_or_sister_school_or_college2` varchar(255) DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `father_annual_income` varchar(255) DEFAULT NULL,
  `father_education` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `father_occupation` varchar(255) DEFAULT NULL,
  `father_office_address` varchar(255) DEFAULT NULL,
  `father_phone_no` varchar(255) DEFAULT NULL,
  `fee_receipt_date` datetime DEFAULT NULL,
  `fee_receipt_no` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  `mother_annual_income` varchar(255) DEFAULT NULL,
  `mother_education` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `mother_occupation` varchar(255) DEFAULT NULL,
  `mother_office_address` varchar(255) DEFAULT NULL,
  `mother_phone_no` varchar(255) DEFAULT NULL,
  `mother_tounge` varchar(255) DEFAULT NULL,
  `phone_no` varchar(255) DEFAULT NULL,
  `physical_disability` varchar(255) DEFAULT NULL,
  `principal_or_director_name` varchar(255) DEFAULT NULL,
  `reg_no` varchar(255) DEFAULT NULL,
  `res_address` varchar(255) DEFAULT NULL,
  `s_no` int(11) DEFAULT NULL,
  `student_name` varchar(255) DEFAULT NULL,
  `written_or_interview_date` datetime DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `school_address` varchar(255) DEFAULT NULL,
  `school_name` varchar(255) DEFAULT NULL,
  `school_phone` varchar(255) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `transfer_status` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`student_id`),
  KEY `FK46DC470567C2729C` (`class_id`),
  KEY `FK46DC4705176468EB` (`country_id`),
  KEY `FK46DC470576F31C89` (`city_id`),
  KEY `FK46DC4705AA42F28B` (`section_id`),
  KEY `FK46DC4705B9E0B4B` (`state_id`),
  CONSTRAINT `FK46DC470576F31C89` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  CONSTRAINT `FK46DC4705AA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FK46DC4705B9E0B4B` FOREIGN KEY (`state_id`) REFERENCES `state` (`state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `student_admission` */

insert  into `student_admission`(`student_id`,`admission_date`,`admission_no`,`admit_in_class`,`brother_or_sister_age1`,`brother_or_sister_age2`,`brother_or_sister_class1`,`brother_or_sister_class2`,`brother_or_sister_name1`,`brother_or_sister_name2`,`brother_or_sister_school_or_college1`,`brother_or_sister_school_or_college2`,`date_of_birth`,`father_annual_income`,`father_education`,`father_name`,`father_occupation`,`father_office_address`,`father_phone_no`,`fee_receipt_date`,`fee_receipt_no`,`gender`,`image_name`,`mother_annual_income`,`mother_education`,`mother_name`,`mother_occupation`,`mother_office_address`,`mother_phone_no`,`mother_tounge`,`phone_no`,`physical_disability`,`principal_or_director_name`,`reg_no`,`res_address`,`s_no`,`student_name`,`written_or_interview_date`,`class_id`,`country_id`,`school_address`,`school_name`,`school_phone`,`city_id`,`section_id`,`state_id`,`transfer_status`,`is_active`,`is_delete`) values (1,NULL,NULL,NULL,'','','','','','','','','2015-05-09 00:00:00','','','Deep','','','8888888888',NULL,NULL,'Male','defultimage.png','','','XYZrrrrrrrrrr','','','','Hindi','8888888888','No',NULL,'','Noida Sec 15',1,'Deepak',NULL,1,1,'','','',6,29,4,'yes',1,1);

/*Table structure for table `student_attendance` */

DROP TABLE IF EXISTS `student_attendance`;

CREATE TABLE `student_attendance` (
  `student_attendance_id` int(11) NOT NULL AUTO_INCREMENT,
  `attendance_status` varchar(255) DEFAULT NULL,
  `date_of_attendance` date DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_attendance_id`),
  KEY `FKD323936DFABA0282` (`employee_id`),
  KEY `FKD323936DAA42F28B` (`section_id`),
  KEY `FKD323936D67C2729C` (`class_id`),
  KEY `FKD323936D759AFE66` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `student_attendance` */

insert  into `student_attendance`(`student_attendance_id`,`attendance_status`,`date_of_attendance`,`employee_id`,`section_id`,`class_id`,`student_id`) values (1,'PRESENT','2015-05-26',1,29,1,'1'),(2,'PRESENT','2015-05-27',1,29,1,'1');

/*Table structure for table `student_categories` */

DROP TABLE IF EXISTS `student_categories`;

CREATE TABLE `student_categories` (
  `student_categories_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_categories_name` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`student_categories_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `student_categories` */

insert  into `student_categories`(`student_categories_id`,`student_categories_name`,`is_active`) values (1,'OBC',1),(2,'General',1),(3,'SC',1),(4,'ST',1);

/*Table structure for table `student_document` */

DROP TABLE IF EXISTS `student_document`;

CREATE TABLE `student_document` (
  `student_document_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  `uploaded_on` datetime DEFAULT NULL,
  `document_category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`student_document_id`),
  KEY `FK5EE2D29F4131345F` (`document_category_id`),
  CONSTRAINT `FK5EE2D29F4131345F` FOREIGN KEY (`document_category_id`) REFERENCES `document_category` (`document_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `student_document` */

insert  into `student_document`(`student_document_id`,`is_active`,`file_name`,`student_id`,`uploaded_on`,`document_category_id`) values (1,1,'Aadhar(1)logo25.png','1','2015-05-26 10:38:24',1);

/*Table structure for table `student_fee_submission_details` */

DROP TABLE IF EXISTS `student_fee_submission_details`;

CREATE TABLE `student_fee_submission_details` (
  `student_fee_submission_details_id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(255) DEFAULT NULL,
  `cheque_no` varchar(255) DEFAULT NULL,
  `common_reciept_no` int(11) DEFAULT NULL,
  `fee_paid_date` date DEFAULT NULL,
  `fee_paid_status` varchar(255) DEFAULT NULL,
  `gross_amount` double DEFAULT NULL,
  `l_f_no` int(11) DEFAULT NULL,
  `paid_amount` float DEFAULT NULL,
  `paid_amount_in_word` varchar(255) DEFAULT NULL,
  `paid_by` varchar(255) DEFAULT NULL,
  `reciept_no` int(11) DEFAULT NULL,
  `month_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `student_admission_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_fee_submission_details_id`),
  KEY `FKA1CCE42CA9B190EB` (`month_id`),
  KEY `FKA1CCE42CAA42F28B` (`section_id`),
  KEY `FKA1CCE42CF45088EB` (`session_id`),
  KEY `FKA1CCE42C67C2729C` (`class_id`),
  KEY `FKA1CCE42C1B690E8A` (`student_admission_number`),
  CONSTRAINT `FKA1CCE42C1B690E8A` FOREIGN KEY (`student_admission_number`) REFERENCES `students` (`student_admission_number`),
  CONSTRAINT `FKA1CCE42C67C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FKA1CCE42CA9B190EB` FOREIGN KEY (`month_id`) REFERENCES `month` (`month_id`),
  CONSTRAINT `FKA1CCE42CAA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FKA1CCE42CF45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `student_fee_submission_details` */

insert  into `student_fee_submission_details`(`student_fee_submission_details_id`,`bank_name`,`cheque_no`,`common_reciept_no`,`fee_paid_date`,`fee_paid_status`,`gross_amount`,`l_f_no`,`paid_amount`,`paid_amount_in_word`,`paid_by`,`reciept_no`,`month_id`,`section_id`,`session_id`,`class_id`,`student_admission_number`) values (1,NULL,NULL,1,'2015-05-26','completed',0,0,120,'One Hundred Twenty ','cash',50501,1,29,1,1,'1');

/*Table structure for table `student_fine` */

DROP TABLE IF EXISTS `student_fine`;

CREATE TABLE `student_fine` (
  `student_fine_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `fine_amount` varchar(255) DEFAULT NULL,
  `fine_name` varchar(255) DEFAULT NULL,
  `from_date` datetime DEFAULT NULL,
  `last_date` datetime DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `student_fee_sub_detail_id` int(11) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_fine_id`),
  KEY `FKFEDB593EAA42F28B` (`section_id`),
  KEY `FKFEDB593E67C2729C` (`class_id`),
  KEY `FKFEDB593EC5468449` (`student_fee_sub_detail_id`),
  KEY `FKFEDB593E759AFE66` (`student_id`),
  CONSTRAINT `FKFEDB593E67C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FKFEDB593E759AFE66` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_admission_number`),
  CONSTRAINT `FKFEDB593EAA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FKFEDB593EC5468449` FOREIGN KEY (`student_fee_sub_detail_id`) REFERENCES `student_fee_submission_details` (`student_fee_submission_details_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `student_fine` */

insert  into `student_fine`(`student_fine_id`,`created_at`,`fine_amount`,`fine_name`,`from_date`,`last_date`,`is_paid`,`to_date`,`updated_at`,`section_id`,`class_id`,`student_fee_sub_detail_id`,`student_id`) values (1,'2015-05-26 10:46:02','0','Fine',NULL,NULL,1,NULL,NULL,29,1,1,'1');

/*Table structure for table `student_transfer` */

DROP TABLE IF EXISTS `student_transfer`;

CREATE TABLE `student_transfer` (
  `transfer_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` varchar(50) DEFAULT NULL,
  `date_of_transfer` date DEFAULT NULL,
  `reason` varchar(50) DEFAULT NULL,
  `moral` varchar(50) DEFAULT NULL,
  `behavior` varchar(50) DEFAULT NULL,
  `progress` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `class_in_word` varchar(255) DEFAULT NULL,
  `conduct` varchar(255) DEFAULT NULL,
  `date_of_withdrawl` datetime DEFAULT NULL,
  `in_word_dob` varchar(255) DEFAULT NULL,
  `newclass_inword` varchar(255) DEFAULT NULL,
  `new_class` varchar(255) DEFAULT NULL,
  `religion_caste` varchar(255) DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`transfer_id`),
  KEY `FK77DEB96F759AFE66` (`student_id`),
  CONSTRAINT `FK77DEB96F759AFE66` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_admission_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `student_transfer` */

/*Table structure for table `student_wise_fee` */

DROP TABLE IF EXISTS `student_wise_fee`;

CREATE TABLE `student_wise_fee` (
  `student_wise_fee_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `fee_amount` double DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `month_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`student_wise_fee_id`),
  KEY `FKF1997AEF67C2729C` (`class_id`),
  KEY `FKF1997AEF6C169794` (`category_id`),
  KEY `FKF1997AEFA9B190EB` (`month_id`),
  KEY `FKF1997AEFAA42F28B` (`section_id`),
  KEY `FKF1997AEFF45088EB` (`session_id`),
  KEY `FKF1997AEF759AFE66` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `student_wise_fee` */

insert  into `student_wise_fee`(`student_wise_fee_id`,`is_active`,`fee_amount`,`class_id`,`category_id`,`month_id`,`section_id`,`session_id`,`student_id`) values (1,1,80,1,13,2,29,1,'1');

/*Table structure for table `students` */

DROP TABLE IF EXISTS `students`;

CREATE TABLE `students` (
  `student_admission_number` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `address_line1` varchar(255) DEFAULT NULL,
  `address_line2` varchar(255) DEFAULT NULL,
  `admission_date` datetime DEFAULT NULL,
  `date_of_cancellation` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `guardian_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `lf_no` int(11) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `photo1_file_name` varchar(255) DEFAULT NULL,
  `photo2_file_name` varchar(255) DEFAULT NULL,
  `photo3_file_name` varchar(255) DEFAULT NULL,
  `photo_file_name` varchar(255) DEFAULT NULL,
  `physically_challenged` varchar(255) DEFAULT NULL,
  `pin_code` varchar(255) DEFAULT NULL,
  `religion` varchar(255) DEFAULT NULL,
  `roll_no` int(11) DEFAULT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `student_categories_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `school_address` varchar(255) DEFAULT NULL,
  `school_name` varchar(255) DEFAULT NULL,
  `school_phone` varchar(255) DEFAULT NULL,
  `unique_id` int(11) DEFAULT NULL,
  `sr_no` varchar(255) DEFAULT NULL,
  `admitclass_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`student_admission_number`),
  KEY `FK6FD1C59876F31C89` (`city_id`),
  KEY `FK6FD1C59867C2729C` (`class_id`),
  KEY `FK6FD1C598176468EB` (`country_id`),
  KEY `FK6FD1C598AA42F28B` (`section_id`),
  KEY `FK6FD1C598F45088EB` (`session_id`),
  KEY `FK6FD1C598B9E0B4B` (`state_id`),
  KEY `FK6FD1C59812635564` (`student_categories_id`),
  KEY `FK6FD1C5983F658089` (`user_id`),
  KEY `FK6FD1C5988F4E50F1` (`admitclass_id`),
  CONSTRAINT `FK6FD1C59812635564` FOREIGN KEY (`student_categories_id`) REFERENCES `student_categories` (`student_categories_id`),
  CONSTRAINT `FK6FD1C598176468EB` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`),
  CONSTRAINT `FK6FD1C5983F658089` FOREIGN KEY (`user_id`) REFERENCES `user` (`ID`),
  CONSTRAINT `FK6FD1C59867C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FK6FD1C59876F31C89` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  CONSTRAINT `FK6FD1C5988F4E50F1` FOREIGN KEY (`admitclass_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FK6FD1C598AA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FK6FD1C598B9E0B4B` FOREIGN KEY (`state_id`) REFERENCES `state` (`state_id`),
  CONSTRAINT `FK6FD1C598F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `students` */

insert  into `students`(`student_admission_number`,`is_active`,`address_line1`,`address_line2`,`admission_date`,`date_of_cancellation`,`created_at`,`date_of_birth`,`email`,`father_name`,`first_name`,`gender`,`guardian_name`,`last_name`,`lf_no`,`middle_name`,`mobile`,`mother_name`,`nationality`,`password`,`phone`,`photo1_file_name`,`photo2_file_name`,`photo3_file_name`,`photo_file_name`,`physically_challenged`,`pin_code`,`religion`,`roll_no`,`student_id`,`updated_at`,`city_id`,`class_id`,`country_id`,`section_id`,`session_id`,`state_id`,`student_categories_id`,`user_id`,`school_address`,`school_name`,`school_phone`,`unique_id`,`sr_no`,`admitclass_id`) values ('1',1,'Noida Sec 15',NULL,'2015-05-26 10:18:59',NULL,'2015-05-26 10:18:59','2015-05-09 00:00:00','','Deep','Deepak','Male','','',1,'','8888888888','XYZrrrrrrrrrr','','913b3d','','parent.jpg','father.jpg','kids.jpg','defultimage.png','No','','',1,'1',NULL,6,1,1,29,1,4,NULL,3,'','','',1,NULL,1),('2',1,'Noida Sec 15',NULL,'2015-05-26 10:18:59',NULL,'2015-05-26 10:18:59','2015-05-09 00:00:00','','Deep','Deepak','Male',NULL,'',1,'','8888888888','XYZrrrrrrrrrr','','123456','','parent.jpg','father.jpg','kids.jpg','defultimage.png','No','','',1,'1','2015-05-26 10:34:34',6,2,1,30,2,4,NULL,4,NULL,NULL,NULL,NULL,NULL,1);

/*Table structure for table `subjects` */

DROP TABLE IF EXISTS `subjects`;

CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL AUTO_INCREMENT,
  `isActive` tinyint(1) DEFAULT NULL,
  `subject_name` varchar(255) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `session_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`subject_id`),
  KEY `FK84A050C7AA42F28B` (`section_id`),
  KEY `FK84A050C7F45088EB` (`session_id`),
  KEY `FK84A050C767C2729C` (`class_id`),
  CONSTRAINT `FK84A050C767C2729C` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`),
  CONSTRAINT `FK84A050C7AA42F28B` FOREIGN KEY (`section_id`) REFERENCES `section` (`section_id`),
  CONSTRAINT `FK84A050C7F45088EB` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `subjects` */

insert  into `subjects`(`subject_id`,`isActive`,`subject_name`,`section_id`,`session_id`,`class_id`) values (1,1,'English',29,1,1);

/*Table structure for table `supplier` */

DROP TABLE IF EXISTS `supplier`;

CREATE TABLE `supplier` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `contact_no` int(11) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `fitst_name` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `product_category` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `recipt_code` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `website_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `supplier` */

/*Table structure for table `uniform_purchase` */

DROP TABLE IF EXISTS `uniform_purchase`;

CREATE TABLE `uniform_purchase` (
  `product_purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `quantity_bought` int(11) DEFAULT NULL,
  `date_of_purchase` datetime DEFAULT NULL,
  `net_amount` int(11) DEFAULT NULL,
  `product_no` int(11) DEFAULT NULL,
  `quantity_remaining` int(11) DEFAULT NULL,
  `shop_name` varchar(255) DEFAULT NULL,
  `uniform_category` varchar(255) DEFAULT NULL,
  `uniform_name` varchar(255) DEFAULT NULL,
  `uniform_price` int(11) DEFAULT NULL,
  `uniform_size` varchar(255) DEFAULT NULL,
  `stock_purchase_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_purchase_id`),
  KEY `FK7490072C55680F01` (`stock_purchase_id`),
  CONSTRAINT `FK7490072C55680F01` FOREIGN KEY (`stock_purchase_id`) REFERENCES `uniform_supplier` (`stock_purchase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `uniform_purchase` */

/*Table structure for table `uniform_supplier` */

DROP TABLE IF EXISTS `uniform_supplier`;

CREATE TABLE `uniform_supplier` (
  `stock_purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `balance_amount` int(11) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `cheque_no` int(11) DEFAULT NULL,
  `date_of_purchase` datetime DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `dues` int(11) DEFAULT NULL,
  `gross_amount` int(11) DEFAULT NULL,
  `in_word` varchar(255) DEFAULT NULL,
  `paid_amount` int(11) DEFAULT NULL,
  `paid_status` varchar(255) DEFAULT NULL,
  `payment_mode` varchar(255) DEFAULT NULL,
  `receipt_no` int(11) DEFAULT NULL,
  `supplier_name` varchar(255) DEFAULT NULL,
  `supplier_no` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`stock_purchase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `uniform_supplier` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `ENABLED` tinyint(1) NOT NULL DEFAULT '1',
  `RETRY_COUNT` tinyint(4) NOT NULL DEFAULT '5',
  `LAST_LOGIN_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USERNAME` (`USERNAME`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`ID`,`USERNAME`,`PASSWORD`,`ENABLED`,`RETRY_COUNT`,`LAST_LOGIN_TIME`) values (1,'admin','e10adc3949ba59abbe56e057f20f883e',1,0,'2015-05-27 10:55:09'),(2,'user','e10adc3949ba59abbe56e057f20f883e',1,0,'2015-04-27 17:56:05'),(3,'Deepak11','33032a86ba022cd50fffe4f6ba1a059c',1,0,'2015-05-26 12:21:12'),(4,'Deepak12','e10adc3949ba59abbe56e057f20f883e',1,0,'2015-05-26 10:34:34'),(5,'hg1','57be1cd14fca4fcf4fce7122c4094bc5',1,0,'2015-05-26 10:40:47');

/*Table structure for table `user_role` */

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `USER_ID` int(11) NOT NULL,
  `ROLE_ID` smallint(6) NOT NULL,
  PRIMARY KEY (`USER_ID`,`ROLE_ID`),
  KEY `FK143BF46A3F658089` (`USER_ID`),
  KEY `FK143BF46A129ACBB4` (`ROLE_ID`),
  CONSTRAINT `FK143BF46A129ACBB4` FOREIGN KEY (`ROLE_ID`) REFERENCES `login_role` (`ID`),
  CONSTRAINT `FK143BF46A3F658089` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `user_role` */

insert  into `user_role`(`USER_ID`,`ROLE_ID`) values (1,1),(3,2),(4,2),(5,3),(2,5);

/*Table structure for table `visitor_details` */

DROP TABLE IF EXISTS `visitor_details`;

CREATE TABLE `visitor_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `in_time` time DEFAULT NULL,
  `mobile_no` varchar(255) DEFAULT NULL,
  `out_time` time DEFAULT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `to_meet` varchar(255) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `visitor_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `visitor_details` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
