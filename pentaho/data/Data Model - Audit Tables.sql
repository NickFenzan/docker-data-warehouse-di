SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `audit_Appointment`;
DROP TABLE IF EXISTS `audit_Appointment Type Group`;
DROP TABLE IF EXISTS `audit_Diagnosis Codes`;
DROP TABLE IF EXISTS `audit_Patient`;
DROP TABLE IF EXISTS `audit_Patient Athena ID`;
DROP TABLE IF EXISTS `audit_Patient OpenEMR ID`;
DROP TABLE IF EXISTS `audit_Procedure Codes`;
DROP TABLE IF EXISTS `audit_Provider`;
DROP TABLE IF EXISTS `audit_Referring Provider Event`;
DROP TABLE IF EXISTS `audit_Site`;
DROP TABLE IF EXISTS `audit_Transaction`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `audit_Appointment` LIKE `Appointment`;
CREATE TABLE `audit_Appointment Type Group` LIKE `Appointment Type Group`;
CREATE TABLE `audit_Diagnosis Codes` LIKE `Diagnosis Codes`;
CREATE TABLE `audit_Patient` LIKE `Patient`;
CREATE TABLE `audit_Patient Athena ID` LIKE `Patient Athena ID`;
CREATE TABLE `audit_Patient OpenEMR ID` LIKE `Patient OpenEMR ID`;
CREATE TABLE `audit_Procedure Codes` LIKE `Procedure Codes`;
CREATE TABLE `audit_Provider` LIKE `Provider`;
CREATE TABLE `audit_Referring Provider Event` LIKE `Referring Provider Event`;
CREATE TABLE `audit_Site` LIKE `Site`;
CREATE TABLE `audit_Transaction` LIKE `Transaction`;

ALTER TABLE `audit_Appointment` MODIFY COLUMN id int(11) NOT NULL,
   DROP PRIMARY KEY, ENGINE = MyISAM, ADD action VARCHAR(8) DEFAULT 'insert' FIRST,
   ADD revision INT(6) NOT NULL AUTO_INCREMENT AFTER action,
   ADD dt_datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER revision,
   ADD PRIMARY KEY (id, revision);
