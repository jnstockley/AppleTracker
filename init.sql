-- MySQL Script generated by MySQL Workbench
-- Wed Aug  9 15:57:33 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Software`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Software` (
  `type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`type`),
  UNIQUE INDEX `type_UNIQUE` (`type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ios` (
  `version` INT NOT NULL,
  `introduced` DATE NOT NULL,
  `about` MEDIUMTEXT NULL,
  `tagline` VARCHAR(45) NULL,
  `Software_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`version`, `Software_type`),
  UNIQUE INDEX `version_UNIQUE` (`version` ASC) VISIBLE,
  INDEX `fk_ios_Software1_idx` (`Software_type` ASC) VISIBLE,
  CONSTRAINT `fk_ios_Software1`
    FOREIGN KEY (`Software_type`)
    REFERENCES `mydb`.`Software` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`distribution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`distribution` (
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`distribution_has_ios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`distribution_has_ios` (
  `distribution_name` VARCHAR(10) NOT NULL,
  `ios_version` INT NOT NULL,
  `ios_Software_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`distribution_name`, `ios_version`, `ios_Software_type`),
  INDEX `fk_distribution_has_ios_ios1_idx` (`ios_version` ASC, `ios_Software_type` ASC) VISIBLE,
  INDEX `fk_distribution_has_ios_distribution1_idx` (`distribution_name` ASC) VISIBLE,
  CONSTRAINT `fk_distribution_has_ios_distribution1`
    FOREIGN KEY (`distribution_name`)
    REFERENCES `mydb`.`distribution` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_distribution_has_ios_ios1`
    FOREIGN KEY (`ios_version` , `ios_Software_type`)
    REFERENCES `mydb`.`ios` (`version` , `Software_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ipados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ipados` (
  `version` INT NOT NULL,
  `introduced` DATE NOT NULL,
  `about` MEDIUMTEXT NULL,
  `tagline` VARCHAR(45) NULL,
  `Software_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`version`, `Software_type`),
  UNIQUE INDEX `version_UNIQUE` (`version` ASC) VISIBLE,
  UNIQUE INDEX `introduced_UNIQUE` (`introduced` ASC) VISIBLE,
  INDEX `fk_ipados_Software1_idx` (`Software_type` ASC) VISIBLE,
  CONSTRAINT `fk_ipados_Software1`
    FOREIGN KEY (`Software_type`)
    REFERENCES `mydb`.`Software` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`watchos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`watchos` (
  `version` INT NOT NULL,
  `introduced` DATE NOT NULL,
  `about` MEDIUMTEXT NULL,
  `tagline` VARCHAR(45) NULL,
  `Software_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`version`, `Software_type`),
  UNIQUE INDEX `version_UNIQUE` (`version` ASC) VISIBLE,
  UNIQUE INDEX `introduced_UNIQUE` (`introduced` ASC) VISIBLE,
  INDEX `fk_watchos_Software1_idx` (`Software_type` ASC) VISIBLE,
  CONSTRAINT `fk_watchos_Software1`
    FOREIGN KEY (`Software_type`)
    REFERENCES `mydb`.`Software` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`macos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`macos` (
  `version` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `introduced` DATE NOT NULL,
  `initialPrice` INT NOT NULL,
  `about` MEDIUMTEXT NULL,
  `tagline` VARCHAR(45) NULL,
  `Software_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`version`, `Software_type`),
  UNIQUE INDEX `version_UNIQUE` (`version` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `introduced_UNIQUE` (`introduced` ASC) VISIBLE,
  INDEX `fk_macos_Software1_idx` (`Software_type` ASC) VISIBLE,
  CONSTRAINT `fk_macos_Software1`
    FOREIGN KEY (`Software_type`)
    REFERENCES `mydb`.`Software` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tvos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tvos` (
  `version` INT NOT NULL,
  `introduced` DATE NOT NULL,
  `Software_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`version`, `Software_type`),
  UNIQUE INDEX `version_UNIQUE` (`version` ASC) VISIBLE,
  UNIQUE INDEX `introduced_UNIQUE` (`introduced` ASC) VISIBLE,
  INDEX `fk_tvos_Software1_idx` (`Software_type` ASC) VISIBLE,
  CONSTRAINT `fk_tvos_Software1`
    FOREIGN KEY (`Software_type`)
    REFERENCES `mydb`.`Software` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`build`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`build` (
  `version` VARCHAR(5) NOT NULL,
  `build` VARCHAR(7) NOT NULL,
  `ios_version` INT NOT NULL,
  `ios_Software_type` VARCHAR(10) NOT NULL,
  `ipados_version` INT NOT NULL,
  `ipados_Software_type` VARCHAR(10) NOT NULL,
  `watchos_version` INT NOT NULL,
  `watchos_Software_type` VARCHAR(10) NOT NULL,
  `macos_version` INT NOT NULL,
  `macos_Software_type` VARCHAR(10) NOT NULL,
  `tvos_version` INT NOT NULL,
  `tvos_Software_type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`version`, `ios_version`, `ios_Software_type`, `ipados_version`, `ipados_Software_type`, `watchos_version`, `watchos_Software_type`, `macos_version`, `macos_Software_type`, `tvos_version`, `tvos_Software_type`),
  UNIQUE INDEX `build_UNIQUE` (`build` ASC) VISIBLE,
  INDEX `fk_build_ios1_idx` (`ios_version` ASC, `ios_Software_type` ASC, `ipados_version` ASC, `ipados_Software_type` ASC) VISIBLE,
  INDEX `fk_build_ipados1_idx` (`ipados_version` ASC, `ipados_Software_type` ASC) VISIBLE,
  INDEX `fk_build_watchos1_idx` (`watchos_version` ASC, `watchos_Software_type` ASC) VISIBLE,
  INDEX `fk_build_macos1_idx` (`macos_version` ASC, `macos_Software_type` ASC) VISIBLE,
  INDEX `fk_build_tvos1_idx` (`tvos_version` ASC, `tvos_Software_type` ASC) VISIBLE,
  CONSTRAINT `fk_build_ios1`
    FOREIGN KEY (`ios_version` , `ios_Software_type` , `ipados_version` , `ipados_Software_type`)
    REFERENCES `mydb`.`ios` (`version` , `Software_type` , `version` , `Software_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_build_ipados1`
    FOREIGN KEY (`ipados_version` , `ipados_Software_type`)
    REFERENCES `mydb`.`ipados` (`version` , `Software_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_build_watchos1`
    FOREIGN KEY (`watchos_version` , `watchos_Software_type`)
    REFERENCES `mydb`.`watchos` (`version` , `Software_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_build_macos1`
    FOREIGN KEY (`macos_version` , `macos_Software_type`)
    REFERENCES `mydb`.`macos` (`version` , `Software_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_build_tvos1`
    FOREIGN KEY (`tvos_version` , `tvos_Software_type`)
    REFERENCES `mydb`.`tvos` (`version` , `Software_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ipados_has_distribution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ipados_has_distribution` (
  `ipados_version` INT NOT NULL,
  `ipados_Software_type` VARCHAR(10) NOT NULL,
  `distribution_name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`ipados_version`, `ipados_Software_type`, `distribution_name`),
  INDEX `fk_ipados_has_distribution_distribution1_idx` (`distribution_name` ASC) VISIBLE,
  INDEX `fk_ipados_has_distribution_ipados1_idx` (`ipados_version` ASC, `ipados_Software_type` ASC) VISIBLE,
  CONSTRAINT `fk_ipados_has_distribution_ipados1`
    FOREIGN KEY (`ipados_version` , `ipados_Software_type`)
    REFERENCES `mydb`.`ipados` (`version` , `Software_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ipados_has_distribution_distribution1`
    FOREIGN KEY (`distribution_name`)
    REFERENCES `mydb`.`distribution` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`watchos_has_distribution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`watchos_has_distribution` (
  `watchos_version` INT NOT NULL,
  `distribution_name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`watchos_version`, `distribution_name`),
  INDEX `fk_watchos_has_distribution_distribution1_idx` (`distribution_name` ASC) VISIBLE,
  INDEX `fk_watchos_has_distribution_watchos1_idx` (`watchos_version` ASC) VISIBLE,
  CONSTRAINT `fk_watchos_has_distribution_watchos1`
    FOREIGN KEY (`watchos_version`)
    REFERENCES `mydb`.`watchos` (`version`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_watchos_has_distribution_distribution1`
    FOREIGN KEY (`distribution_name`)
    REFERENCES `mydb`.`distribution` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`macos_has_distribution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`macos_has_distribution` (
  `macos_version` INT NOT NULL,
  `macos_Software_type` VARCHAR(10) NOT NULL,
  `distribution_name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`macos_version`, `macos_Software_type`, `distribution_name`),
  INDEX `fk_macos_has_distribution_distribution1_idx` (`distribution_name` ASC) VISIBLE,
  INDEX `fk_macos_has_distribution_macos1_idx` (`macos_version` ASC, `macos_Software_type` ASC) VISIBLE,
  CONSTRAINT `fk_macos_has_distribution_macos1`
    FOREIGN KEY (`macos_version` , `macos_Software_type`)
    REFERENCES `mydb`.`macos` (`version` , `Software_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_macos_has_distribution_distribution1`
    FOREIGN KEY (`distribution_name`)
    REFERENCES `mydb`.`distribution` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tvos_has_distribution`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tvos_has_distribution` (
  `tvos_version` INT NOT NULL,
  `tvos_Software_type` VARCHAR(10) NOT NULL,
  `distribution_name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`tvos_version`, `tvos_Software_type`, `distribution_name`),
  INDEX `fk_tvos_has_distribution_distribution1_idx` (`distribution_name` ASC) VISIBLE,
  INDEX `fk_tvos_has_distribution_tvos1_idx` (`tvos_version` ASC, `tvos_Software_type` ASC) VISIBLE,
  CONSTRAINT `fk_tvos_has_distribution_tvos1`
    FOREIGN KEY (`tvos_version` , `tvos_Software_type`)
    REFERENCES `mydb`.`tvos` (`version` , `Software_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tvos_has_distribution_distribution1`
    FOREIGN KEY (`distribution_name`)
    REFERENCES `mydb`.`distribution` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
