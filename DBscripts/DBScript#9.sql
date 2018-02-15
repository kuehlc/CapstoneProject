-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ulistit
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ulistit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ulistit` DEFAULT CHARACTER SET utf8 ;
USE `ulistit` ;

-- -----------------------------------------------------
-- Table `ulistit`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ulistit`.`user` (
  `user_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `school_email` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `password` VARCHAR(45) NOT NULL,
  `active` TINYINT(4) NOT NULL DEFAULT '1',
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `login_attempts` INT(11) NOT NULL DEFAULT '0',
  `locked` TINYINT(4) NOT NULL DEFAULT '1',
  `admin_level` TINYINT(4) NOT NULL DEFAULT '0',
  `image_path` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`user_ID`),
  UNIQUE INDEX `user_ID_UNIQUE` (`user_ID` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `school_email_UNIQUE` (`school_email` ASC),
  INDEX `fk_user_security1_idx` (`login_attempts` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ulistit`.`listing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ulistit`.`listing` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `userID` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL DEFAULT 'default',
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `category` VARCHAR(45) NOT NULL DEFAULT 'other',
  `price` DOUBLE NOT NULL DEFAULT '0',
  `type` VARCHAR(10) NOT NULL,
  `image_path` VARCHAR(45) NOT NULL,
  `highest_bid_userID` INT(11) NULL DEFAULT NULL,
  `highest_bid` DOUBLE NULL DEFAULT NULL,
  `bid_count` INT(11) NULL DEFAULT NULL,
  `start_timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_timestamp` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` TINYINT(4) NOT NULL DEFAULT '1',
  `ended` TINYINT(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `userID_fk_idx` (`userID` ASC),
  INDEX `listing_cat_fk_idx` (`category` ASC),
  CONSTRAINT `userID_fk`
    FOREIGN KEY (`userID`)
    REFERENCES `ulistit`.`user` (`user_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ulistit`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ulistit`.`category` (
  `category` VARCHAR(45) NOT NULL,
  `sub_category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category`, `sub_category`),
  CONSTRAINT `cat_listing_fk`
    FOREIGN KEY (`category`)
    REFERENCES `ulistit`.`listing` (`category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ulistit`.`conversation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ulistit`.`conversation` (
  `conversation_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `userId_1` INT(11) NOT NULL,
  `userId_2` INT(11) NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`conversation_ID`),
  INDEX `userID_connect_idx` (`userId_1` ASC),
  INDEX `userID2_conect_idx` (`userId_2` ASC),
  CONSTRAINT `userID1_connect`
    FOREIGN KEY (`userId_1`)
    REFERENCES `ulistit`.`user` (`user_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `userID2_conect`
    FOREIGN KEY (`userId_2`)
    REFERENCES `ulistit`.`user` (`user_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'fk_conversation_1';


-- -----------------------------------------------------
-- Table `ulistit`.`dispute`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ulistit`.`dispute` (
  `dispute_id` INT(11) NOT NULL AUTO_INCREMENT,
  `listing_id` INT(11) NOT NULL,
  `accusing_id` INT(11) NOT NULL,
  `defending_id` INT(11) NOT NULL,
  `complaint` VARCHAR(1000) NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(200) NOT NULL DEFAULT 'FILED',
  PRIMARY KEY (`dispute_id`),
  INDEX `dispute_listing_fk_idx` (`listing_id` ASC),
  INDEX `dispute_accusing_fk_idx` (`accusing_id` ASC),
  INDEX `dispute_defending_fk_idx` (`defending_id` ASC),
  CONSTRAINT `dispute_accusing_fk`
    FOREIGN KEY (`accusing_id`)
    REFERENCES `ulistit`.`user` (`user_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dispute_defending_fk`
    FOREIGN KEY (`defending_id`)
    REFERENCES `ulistit`.`user` (`user_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dispute_listing_fk`
    FOREIGN KEY (`listing_id`)
    REFERENCES `ulistit`.`listing` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ulistit`.`favorite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ulistit`.`favorite` (
  `favoriteID` INT(11) NOT NULL AUTO_INCREMENT,
  `userID` INT(11) NULL DEFAULT NULL,
  `listingID` INT(11) NULL DEFAULT NULL,
  `userWatching` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`favoriteID`),
  INDEX `userID_fk2_idx` (`userID` ASC),
  INDEX `listingID_fk_idx` (`listingID` ASC),
  CONSTRAINT `listingID_fk`
    FOREIGN KEY (`listingID`)
    REFERENCES `ulistit`.`listing` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `userID_fk2`
    FOREIGN KEY (`userID`)
    REFERENCES `ulistit`.`user` (`user_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ulistit`.`listing_bid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ulistit`.`listing_bid` (
  `listing_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`listing_id`, `user_id`),
  INDEX `listing_bid_user_idx` (`user_id` ASC),
  CONSTRAINT `listing_bid_listing`
    FOREIGN KEY (`listing_id`)
    REFERENCES `ulistit`.`listing` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `listing_bid_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `ulistit`.`user` (`user_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ulistit`.`notification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ulistit`.`notification` (
  `notification_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `listing_id` INT(11) NOT NULL,
  `subject` VARCHAR(100) NOT NULL DEFAULT 'U-ListIt Notification',
  `message` VARCHAR(2000) NOT NULL,
  `send_timestamp` TIMESTAMP NULL DEFAULT NULL,
  `active` TINYINT(4) NOT NULL DEFAULT '1',
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sent` TINYINT(4) NOT NULL DEFAULT '0',
  `dismissed` TINYINT(4) NOT NULL DEFAULT '0',
  `viewed` TINYINT(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`notification_id`),
  INDEX `not_listing_id_idx` (`listing_id` ASC),
  INDEX `not_user_id_idx` (`user_id` ASC),
  CONSTRAINT `not_listing_id`
    FOREIGN KEY (`listing_id`)
    REFERENCES `ulistit`.`listing` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `not_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `ulistit`.`user` (`user_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ulistit`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ulistit`.`transaction` (
  `transaction_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `buyer_ID` INT(11) NOT NULL,
  `seller_ID` INT(11) NOT NULL,
  `listing_ID` INT(11) NOT NULL,
  `transaction_type` VARCHAR(30) NOT NULL,
  `user_ID` INT(11) NOT NULL,
  `completed` TINYINT(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`transaction_ID`),
  INDEX `fk_transaction_user1_idx` (`user_ID` ASC),
  CONSTRAINT `fk_transaction_user1`
    FOREIGN KEY (`user_ID`)
    REFERENCES `ulistit`.`user` (`user_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
