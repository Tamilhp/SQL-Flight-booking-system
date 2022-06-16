-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Flight_Booking_System
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Flight_Booking_System
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Flight_Booking_System` DEFAULT CHARACTER SET utf8 ;
USE `Flight_Booking_System` ;

-- -----------------------------------------------------
-- Table `Flight_Booking_System`.`Passengers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_Booking_System`.`Passengers` (
  `PassengerId` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`PassengerId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_Booking_System`.`AirLine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_Booking_System`.`AirLine` (
  `AirlineId` INT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`AirlineId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_Booking_System`.`AirPort`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_Booking_System`.`AirPort` (
  `IATACode` VARCHAR(50) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `City` VARCHAR(50) NOT NULL,
  `State` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`IATACode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_Booking_System`.`Flights`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_Booking_System`.`Flights` (
  `FlightNumber` CHAR(6) NOT NULL,
  `AirlineId` INT NOT NULL,
  `IATACode` VARCHAR(50) NOT NULL,
  `DepartureDateTime` DATETIME NOT NULL,
  `ArrivalDateTime` DATETIME NOT NULL,
  `DurationInMinutes` INT NOT NULL,
  `DistanceInMiles` INT NOT NULL,
  `DepartureAirportId` INT NOT NULL,
  `ArrivalAirportId` INT NOT NULL,
  PRIMARY KEY (`FlightNumber`),
  INDEX `fk_Flights_AirLine1_idx` (`AirlineId` ASC) VISIBLE,
  INDEX `fk_Flights_AirPort1_idx` (`IATACode` ASC) VISIBLE,
  CONSTRAINT `fk_Flights_AirLine`
    FOREIGN KEY (`AirlineId`)
    REFERENCES `Flight_Booking_System`.`AirLine` (`AirlineId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Flights_AirPort`
    FOREIGN KEY (`IATACode`)
    REFERENCES `Flight_Booking_System`.`AirPort` (`IATACode`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_Booking_System`.`FlightClass`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_Booking_System`.`FlightClass` (
  `ClassId` INT NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ClassId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Flight_Booking_System`.`Tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Flight_Booking_System`.`Tickets` (
  `PassengerId` INT NOT NULL,
  `FlightNumber` CHAR(6) NOT NULL,
  `ClassId` INT NOT NULL,
  `TicketNumber` VARCHAR(50) NOT NULL,
  `Price` FLOAT NOT NULL,
  `ConfirmationNumber` VARCHAR(50) NOT NULL,
  INDEX `fk_Tickets_Passengers_idx` (`PassengerId` ASC) VISIBLE,
  INDEX `fk_Tickets_Flights1_idx` (`FlightNumber` ASC) VISIBLE,
  PRIMARY KEY (`PassengerId`, `FlightNumber`),
  INDEX `fk_Tickets_FlightClass1_idx` (`ClassId` ASC) VISIBLE,
  CONSTRAINT `fk_Tickets_Passengers`
    FOREIGN KEY (`PassengerId`)
    REFERENCES `Flight_Booking_System`.`Passengers` (`PassengerId`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Tickets_Flights`
    FOREIGN KEY (`FlightNumber`)
    REFERENCES `Flight_Booking_System`.`Flights` (`FlightNumber`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Tickets_FlightClass`
    FOREIGN KEY (`ClassId`)
    REFERENCES `Flight_Booking_System`.`FlightClass` (`ClassId`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
