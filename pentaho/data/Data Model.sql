SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Appointment`;
DROP TABLE IF EXISTS `Appointment Type Group`;
DROP TABLE IF EXISTS `Diagnosis Codes`;
DROP TABLE IF EXISTS `Patient`;
DROP TABLE IF EXISTS `Patient Athena ID`;
DROP TABLE IF EXISTS `Patient OpenEMR ID`;
DROP TABLE IF EXISTS `Procedure Codes`;
DROP TABLE IF EXISTS `Provider`;
DROP TABLE IF EXISTS `Referring Provider Event`;
DROP TABLE IF EXISTS `Site`;
DROP TABLE IF EXISTS `Transaction`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `Appointment` (
    `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
    `patient_id` INTEGER(11) NOT NULL,
    `site_id` INTEGER(11) NOT NULL,
    `appointment_type` VARCHAR(50) NOT NULL,
    `start` DATETIME NOT NULL,
    `scheduled_at` DATETIME,
    `cancelled` BOOLEAN NOT NULL,
    `cancelled_at` DATETIME,
    PRIMARY KEY (`id`)
);

CREATE TABLE `Appointment Type Group` (
    `appointment_type` VARCHAR(50) NOT NULL,
    `group_name` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`appointment_type`)
);

CREATE TABLE `Diagnosis Codes` (
  `code` VARCHAR(7) NOT NULL,
  `type` VARCHAR(5) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`code`)
);

CREATE TABLE `Patient` (
    `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(35) NOT NULL,
    `last_name` VARCHAR(35) NOT NULL,
    `date_of_birth` DATE NOT NULL,
    `sex` VARCHAR(6),
    `referral_source` VARCHAR(100),
    `referring_provider_id` INTEGER(11),
    `street` VARCHAR(50),
    `street2` VARCHAR(50),
    `city` VARCHAR(40),
    `state` VARCHAR(2),
    `zip` VARCHAR(5),
    `home_phone` VARCHAR(10),
    `work_phone` VARCHAR(10),
    `cell_phone` VARCHAR(10),
    `email` VARCHAR(100),
    PRIMARY KEY (`id`)
);

CREATE TABLE `Patient Athena ID` (
    `athena_patient_id` INTEGER(11) NOT NULL,
    `patient_id` INTEGER(11) NOT NULL,
    PRIMARY KEY (`athena_patient_id`)
);

CREATE TABLE `Patient OpenEMR ID` (
    `openemr_patient_id` INTEGER(11) NOT NULL,
    `patient_id` INTEGER(11) NOT NULL,
    PRIMARY KEY (`openemr_patient_id`)
);

CREATE TABLE `Provider` (
    `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
    `npi` INTEGER(10),
    `first_name` VARCHAR(35) NOT NULL,
    `last_name` VARCHAR(35) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE (`npi`)
);

CREATE TABLE `Procedure Codes` (
  `code` VARCHAR(5) NOT NULL,
  `short_description` VARCHAR(50) NOT NULL,
  `long_description` TEXT NOT NULL,
  PRIMARY KEY (`code`)
);

CREATE TABLE `Referring Provider Event` (
    `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
    `date` DATETIME NOT NULL,
    `provider_id` INTEGER(11) NOT NULL,
    `event_type` VARCHAR(7) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `Site` (
    `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
    `street` VARCHAR(50) NOT NULL,
    `street2` VARCHAR(50),
    `city` VARCHAR(40) NOT NULL,
    `state` VARCHAR(2) NOT NULL,
    `zip` VARCHAR(5) NOT NULL,
	`athena_department_name` VARCHAR(40) NOT NULL,
    `opened` DATETIME NOT NULL,
    `closed` DATETIME,
    PRIMARY KEY (`id`)
);

CREATE TABLE `Transaction` (
    `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
    `patient_id` INTEGER(11) NOT NULL,
    `provider_id` INTEGER(11) NOT NULL,
    `site_id` INTEGER(11) NOT NULL,
    `code` VARCHAR(35) NOT NULL,
    `date_of_service` DATE NOT NULL,
    `post_date` DATE NOT NULL,
    `payer_role` VARCHAR(15) NOT NULL,
    `insurance_package` VARCHAR(255) NOT NULL,
    `type` VARCHAR(11) NOT NULL,
    `amount` DECIMAL(9,2) NOT NULL,
    PRIMARY KEY (`id`)
);

ALTER TABLE `Appointment` ADD FOREIGN KEY (`patient_id`) REFERENCES `Patient`(`id`);
ALTER TABLE `Appointment` ADD FOREIGN KEY (`site_id`) REFERENCES `Site`(`id`);
-- ALTER TABLE `Appointment` ADD FOREIGN KEY (`appointment_type`) REFERENCES `Appointment Type Group`(`appointment_type`);
ALTER TABLE `Appointment` ADD INDEX (`appointment_type`);
ALTER TABLE `Appointment` ADD INDEX (`start`);
ALTER TABLE `Appointment` ADD INDEX (`scheduled_at`);
ALTER TABLE `Appointment` ADD INDEX (`cancelled_at`);
ALTER TABLE `Appointment Type Group` ADD INDEX (`group_name`);
ALTER TABLE `Diagnosis Codes` ADD INDEX (`type`);
ALTER TABLE `Patient` ADD FOREIGN KEY (`referring_provider_id`) REFERENCES `Provider`(`id`);
ALTER TABLE `Patient` ADD INDEX (`first_name`);
ALTER TABLE `Patient` ADD INDEX (`last_name`);
ALTER TABLE `Patient` ADD INDEX (`date_of_birth`);
ALTER TABLE `Patient Athena ID` ADD FOREIGN KEY (`patient_id`) REFERENCES `Patient`(`id`);
ALTER TABLE `Patient OpenEMR ID` ADD FOREIGN KEY (`patient_id`) REFERENCES `Patient`(`id`);
ALTER TABLE `Provider` ADD INDEX (`npi`);
ALTER TABLE `Provider` ADD INDEX (`first_name`);
ALTER TABLE `Provider` ADD INDEX (`last_name`);
ALTER TABLE `Referring Provider Event` ADD FOREIGN KEY (`provider_id`) REFERENCES `Provider`(`id`);
ALTER TABLE `Transaction` ADD FOREIGN KEY (`patient_id`) REFERENCES `Patient`(`id`);
ALTER TABLE `Transaction` ADD FOREIGN KEY (`provider_id`) REFERENCES `Provider`(`id`);
ALTER TABLE `Transaction` ADD FOREIGN KEY (`site_id`) REFERENCES `Site`(`id`);
ALTER TABLE `Transaction` ADD INDEX (`code`);
ALTER TABLE `Transaction` ADD INDEX (`date_of_service`);
ALTER TABLE `Transaction` ADD INDEX (`post_date`);
ALTER TABLE `Transaction` ADD INDEX (`payer_role`);
ALTER TABLE `Transaction` ADD INDEX (`insurance_package`);
ALTER TABLE `Transaction` ADD INDEX (`type`);
ALTER TABLE `Site` ADD INDEX (`street`);
ALTER TABLE `Site` ADD INDEX (`city`);
