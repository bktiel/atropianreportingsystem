-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema reportsystem
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema reportsystem
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `reportsystem` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `reportsystem` ;

-- -----------------------------------------------------
-- Table `reportsystem`.`auth_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`auth_group` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`auth_group` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(150) NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
	ENGINE = InnoDB
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`django_content_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`django_content_type` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`django_content_type` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `app_label` VARCHAR(100) NOT NULL,
	  `model` VARCHAR(100) NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label` ASC, `model` ASC) VISIBLE)
	ENGINE = InnoDB
	AUTO_INCREMENT = 13
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`auth_permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`auth_permission` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`auth_permission` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `name` VARCHAR(255) NOT NULL,
	  `content_type_id` INT NOT NULL,
	  `codename` VARCHAR(100) NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id` ASC, `codename` ASC) VISIBLE,
	  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co`
	    FOREIGN KEY (`content_type_id`)
	    REFERENCES `reportsystem`.`django_content_type` (`id`))
	ENGINE = InnoDB
	AUTO_INCREMENT = 49
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`auth_group_permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`auth_group_permissions` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`auth_group_permissions` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `group_id` INT NOT NULL,
	  `permission_id` INT NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id` ASC, `permission_id` ASC) VISIBLE,
	  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id` ASC) VISIBLE,
	  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`
	    FOREIGN KEY (`permission_id`)
	    REFERENCES `reportsystem`.`auth_permission` (`id`),
	  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id`
	    FOREIGN KEY (`group_id`)
	    REFERENCES `reportsystem`.`auth_group` (`id`))
	ENGINE = InnoDB
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`auth_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`auth_user` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`auth_user` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `password` VARCHAR(128) NOT NULL,
	  `last_login` DATETIME(6) NULL DEFAULT NULL,
	  `is_superuser` TINYINT(1) NOT NULL,
	  `username` VARCHAR(150) NOT NULL,
	  `first_name` VARCHAR(150) NOT NULL,
	  `last_name` VARCHAR(150) NOT NULL,
	  `email` VARCHAR(254) NOT NULL,
	  `is_staff` TINYINT(1) NOT NULL,
	  `is_active` TINYINT(1) NOT NULL,
	  `date_joined` DATETIME(6) NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `username` (`username` ASC) VISIBLE)
	ENGINE = InnoDB
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`auth_user_groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`auth_user_groups` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`auth_user_groups` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `user_id` INT NOT NULL,
	  `group_id` INT NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id` ASC, `group_id` ASC) VISIBLE,
	  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id` ASC) VISIBLE,
	  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id`
	    FOREIGN KEY (`group_id`)
	    REFERENCES `reportsystem`.`auth_group` (`id`),
	  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id`
	    FOREIGN KEY (`user_id`)
	    REFERENCES `reportsystem`.`auth_user` (`id`))
	ENGINE = InnoDB
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`auth_user_user_permissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`auth_user_user_permissions` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`auth_user_user_permissions` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `user_id` INT NOT NULL,
	  `permission_id` INT NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id` ASC, `permission_id` ASC) VISIBLE,
	  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id` ASC) VISIBLE,
	  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`
	    FOREIGN KEY (`permission_id`)
	    REFERENCES `reportsystem`.`auth_permission` (`id`),
	  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id`
	    FOREIGN KEY (`user_id`)
	    REFERENCES `reportsystem`.`auth_user` (`id`))
	ENGINE = InnoDB
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`django_admin_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`django_admin_log` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`django_admin_log` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `action_time` DATETIME(6) NOT NULL,
	  `object_id` LONGTEXT NULL DEFAULT NULL,
	  `object_repr` VARCHAR(200) NOT NULL,
	  `action_flag` SMALLINT UNSIGNED NOT NULL,
	  `change_message` LONGTEXT NOT NULL,
	  `content_type_id` INT NULL DEFAULT NULL,
	  `user_id` INT NOT NULL,
	  PRIMARY KEY (`id`),
	  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id` ASC) VISIBLE,
	  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id` ASC) VISIBLE,
	  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co`
	    FOREIGN KEY (`content_type_id`)
	    REFERENCES `reportsystem`.`django_content_type` (`id`),
	  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id`
	    FOREIGN KEY (`user_id`)
	    REFERENCES `reportsystem`.`auth_user` (`id`))
	ENGINE = InnoDB
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`django_migrations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`django_migrations` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`django_migrations` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `app` VARCHAR(255) NOT NULL,
	  `name` VARCHAR(255) NOT NULL,
	  `applied` DATETIME(6) NOT NULL,
	  PRIMARY KEY (`id`))
	ENGINE = InnoDB
	AUTO_INCREMENT = 22
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`django_session`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`django_session` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`django_session` (
	  `session_key` VARCHAR(40) NOT NULL,
	  `session_data` LONGTEXT NOT NULL,
	  `expire_date` DATETIME(6) NOT NULL,
	  PRIMARY KEY (`session_key`),
	  INDEX `django_session_expire_date_a5c62663` (`expire_date` ASC) VISIBLE)
	ENGINE = InnoDB
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`reportsite_city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`reportsite_city` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`reportsite_city` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `cityName` VARCHAR(64) NOT NULL,
	  PRIMARY KEY (`id`))
	ENGINE = InnoDB
	AUTO_INCREMENT = 253
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`reportsite_citizen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`reportsite_citizen` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`reportsite_citizen` (
	  `id` INT UNSIGNED NOT NULL,
	  `firstName` VARCHAR(32) NOT NULL,
	  `lastName` VARCHAR(32) NOT NULL,
	  `password` VARCHAR(64) NOT NULL,
	  `role` SMALLINT UNSIGNED NOT NULL,
	  `city_id` INT NOT NULL,
	  PRIMARY KEY (`id`),
	  INDEX `reportsite_citizen_city_id_56eaed45_fk_reportsite_city_id` (`city_id` ASC) VISIBLE,
	  CONSTRAINT `reportsite_citizen_city_id_56eaed45_fk_reportsite_city_id`
	    FOREIGN KEY (`city_id`)
	    REFERENCES `reportsystem`.`reportsite_city` (`id`))
	ENGINE = InnoDB
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`reportsite_report`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`reportsite_report` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`reportsite_report` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `reportTime` DATETIME(6) NOT NULL,
	  `priority` SMALLINT NOT NULL,
	  `remarks` LONGTEXT NOT NULL,
	  `city_id` INT NOT NULL,
	  `patriot_id` INT UNSIGNED NOT NULL,
	  `traitor_id` INT UNSIGNED NOT NULL,
	  PRIMARY KEY (`id`),
	  INDEX `reportsite_report_city_id_260838fd_fk_reportsite_city_id` (`city_id` ASC) VISIBLE,
	  INDEX `reportsite_report_patriot_id_4822f024_fk_reportsite_citizen_id` (`patriot_id` ASC) VISIBLE,
	  INDEX `reportsite_report_traitor_id_88a0f547_fk_reportsite_citizen_id` (`traitor_id` ASC) VISIBLE,
	  CONSTRAINT `reportsite_report_city_id_260838fd_fk_reportsite_city_id`
	    FOREIGN KEY (`city_id`)
	    REFERENCES `reportsystem`.`reportsite_city` (`id`),
	  CONSTRAINT `reportsite_report_patriot_id_4822f024_fk_reportsite_citizen_id`
	    FOREIGN KEY (`patriot_id`)
	    REFERENCES `reportsystem`.`reportsite_citizen` (`id`),
	  CONSTRAINT `reportsite_report_traitor_id_88a0f547_fk_reportsite_citizen_id`
	    FOREIGN KEY (`traitor_id`)
	    REFERENCES `reportsystem`.`reportsite_citizen` (`id`))
	ENGINE = InnoDB
	AUTO_INCREMENT = 8
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`reportsite_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`reportsite_comment` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`reportsite_comment` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `commentTime` DATETIME(6) NOT NULL,
	  `priority` SMALLINT NOT NULL,
	  `content` LONGTEXT NOT NULL,
	  `informant_id` INT UNSIGNED NOT NULL,
	  `reportID_id` INT NOT NULL,
	  PRIMARY KEY (`id`),
	  INDEX `reportsite_comment_informant_id_4be31e16_fk_reportsit` (`informant_id` ASC) VISIBLE,
	  INDEX `reportsite_comment_reportID_id_6a5d1243_fk_reportsite_report_id` (`reportID_id` ASC) VISIBLE,
	  CONSTRAINT `reportsite_comment_informant_id_4be31e16_fk_reportsit`
	    FOREIGN KEY (`informant_id`)
	    REFERENCES `reportsystem`.`reportsite_citizen` (`id`),
	  CONSTRAINT `reportsite_comment_reportID_id_6a5d1243_fk_reportsite_report_id`
	    FOREIGN KEY (`reportID_id`)
	    REFERENCES `reportsystem`.`reportsite_report` (`id`))
	ENGINE = InnoDB
	AUTO_INCREMENT = 10
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`reportsite_crime`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`reportsite_crime` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`reportsite_crime` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `crimeName` VARCHAR(64) NOT NULL,
	  `description` LONGTEXT NOT NULL,
	  `severity` SMALLINT UNSIGNED NOT NULL,
	  PRIMARY KEY (`id`))
	ENGINE = InnoDB
	AUTO_INCREMENT = 7
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`reportsite_investigationqueue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`reportsite_investigationqueue` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`reportsite_investigationqueue` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `priority` SMALLINT NOT NULL,
	  `agentID_id` INT UNSIGNED NOT NULL,
	  `reportID_id` INT NOT NULL,
	  PRIMARY KEY (`id`),
	  INDEX `reportsite_investiga_agentID_id_c496bb8a_fk_reportsit` (`agentID_id` ASC) VISIBLE,
	  INDEX `reportsite_investiga_reportID_id_0694c63c_fk_reportsit` (`reportID_id` ASC) VISIBLE,
	  CONSTRAINT `reportsite_investiga_agentID_id_c496bb8a_fk_reportsit`
	    FOREIGN KEY (`agentID_id`)
	    REFERENCES `reportsystem`.`reportsite_citizen` (`id`),
	  CONSTRAINT `reportsite_investiga_reportID_id_0694c63c_fk_reportsit`
	    FOREIGN KEY (`reportID_id`)
	    REFERENCES `reportsystem`.`reportsite_report` (`id`))
	ENGINE = InnoDB
	AUTO_INCREMENT = 2
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	-- -----------------------------------------------------
-- Table `reportsystem`.`reportsite_report_crimename`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reportsystem`.`reportsite_report_crimename` ;

CREATE TABLE IF NOT EXISTS `reportsystem`.`reportsite_report_crimename` (
	  `id` INT NOT NULL AUTO_INCREMENT,
	  `report_id` INT NOT NULL,
	  `crime_id` INT NOT NULL,
	  PRIMARY KEY (`id`),
	  UNIQUE INDEX `reportsite_report_crimeName_report_id_crime_id_c5660203_uniq` (`report_id` ASC, `crime_id` ASC) VISIBLE,
	  INDEX `reportsite_report_cr_crime_id_a24ce200_fk_reportsit` (`crime_id` ASC) VISIBLE,
	  CONSTRAINT `reportsite_report_cr_crime_id_a24ce200_fk_reportsit`
	    FOREIGN KEY (`crime_id`)
	    REFERENCES `reportsystem`.`reportsite_crime` (`id`),
	  CONSTRAINT `reportsite_report_cr_report_id_084bc4db_fk_reportsit`
	    FOREIGN KEY (`report_id`)
	    REFERENCES `reportsystem`.`reportsite_report` (`id`))
	ENGINE = InnoDB
	AUTO_INCREMENT = 10
	DEFAULT CHARACTER SET = utf8mb4
	COLLATE = utf8mb4_0900_ai_ci;


	SET SQL_MODE=@OLD_SQL_MODE;
	SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
	SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

