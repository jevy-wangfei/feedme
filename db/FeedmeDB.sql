-- MySQL Script generated by MySQL Workbench
-- Wed Oct  7 15:59:04 2015
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema foodie
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `foodie` ;

-- -----------------------------------------------------
-- Schema foodie
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `foodie` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `foodie` ;

-- -----------------------------------------------------
-- Table `foodie`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`user` ;

CREATE TABLE IF NOT EXISTS `foodie`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `birthday` DATE NULL,
  `password` VARCHAR(45) NULL,
  `registerTime` DATETIME NULL,
  `preferLangugae` VARCHAR(20) NULL,
  `photo` VARCHAR(45) NULL,
  `phoneNumber` VARCHAR(45) NULL,
  `email` VARCHAR(60) NULL,
  `title` CHAR(5) NULL,
  `user_id` INT NOT NULL,
  `user_id1` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`restaurant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`restaurant` ;

CREATE TABLE IF NOT EXISTS `foodie`.`restaurant` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `logo` VARCHAR(200) NULL,
  `description` VARCHAR(500) NULL,
  `type` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `openTimeMorning` VARCHAR(45) NULL COMMENT 'with formate \"10:30 am - 01:30 pm\"',
  `openTimeAfternoon` VARCHAR(45) NULL COMMENT 'with formate “04:30 pm - 09:30 pm\"',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`staff` ;

CREATE TABLE IF NOT EXISTS `foodie`.`staff` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`dish`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`dish` ;

CREATE TABLE IF NOT EXISTS `foodie`.`dish` (
  `dishId` INT NOT NULL AUTO_INCREMENT,
  `shopId` INT NULL,
  `type` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `describtion` VARCHAR(500) NULL,
  `photo` VARCHAR(200) NULL,
  `ingredient` VARCHAR(300) NULL,
  `price` INT NULL,
  `discount` INT NULL,
  `spicy` INT NULL COMMENT 'From 0 to 5 ',
  `sold` INT NULL,
  INDEX `fk_dish_shop1_idx` (`shopId` ASC),
  PRIMARY KEY (`dishId`),
  CONSTRAINT `fk_dish_shop1`
    FOREIGN KEY (`shopId`)
    REFERENCES `foodie`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`deliver`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`deliver` ;

CREATE TABLE IF NOT EXISTS `foodie`.`deliver` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `sax` TINYINT(1) NULL,
  `phone` VARCHAR(12) NULL,
  `email` VARCHAR(60) NULL,
  `picture` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`orders` ;

CREATE TABLE IF NOT EXISTS `foodie`.`orders` (
  `id` INT NOT NULL,
  `restaurantId` INT NOT NULL,
  `deliverId` INT NOT NULL,
  `creatTime` DATETIME NULL,
  `state` VARCHAR(10) NULL,
  `deliverTime` VARCHAR(45) NULL,
  `finishTime` DATETIME NULL,
  `totalPrice` INT NULL,
  `deliveryFee` INT NULL,
  `paymentStatus` VARCHAR(10) NULL COMMENT '\nWaiting for payment\nPaid',
  PRIMARY KEY (`id`),
  INDEX `fk_order_deliver1_idx` (`deliverId` ASC),
  INDEX `fk_order_restaurant1_idx` (`restaurantId` ASC),
  CONSTRAINT `fk_order_deliver1`
    FOREIGN KEY (`deliverId`)
    REFERENCES `foodie`.`deliver` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_restaurant1`
    FOREIGN KEY (`restaurantId`)
    REFERENCES `foodie`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`address` ;

CREATE TABLE IF NOT EXISTS `foodie`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userId` INT NOT NULL,
  `building` VARCHAR(45) NULL,
  `street` VARCHAR(100) NULL,
  `district` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `isPrime` TINYINT(1) NULL,
  `postcode` VARCHAR(4) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_address_user_idx` (`userId` ASC),
  CONSTRAINT `fk_address_user`
    FOREIGN KEY (`userId`)
    REFERENCES `foodie`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`shopAddress`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`shopAddress` ;

CREATE TABLE IF NOT EXISTS `foodie`.`shopAddress` (
  `shopId` INT NOT NULL,
  `no` VARCHAR(45) NULL,
  `building` VARCHAR(45) NULL,
  `street` VARCHAR(45) NULL,
  `district` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `gpsPosition` VARCHAR(45) NULL,
  INDEX `fk_shop_address_shop1_idx` (`shopId` ASC),
  CONSTRAINT `fk_shop_address_shop1`
    FOREIGN KEY (`shopId`)
    REFERENCES `foodie`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`loginLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`loginLog` ;

CREATE TABLE IF NOT EXISTS `foodie`.`loginLog` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userId` INT NOT NULL,
  `time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_login_log_user1_idx` (`userId` ASC),
  CONSTRAINT `fk_login_log_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `foodie`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`photo` ;

CREATE TABLE IF NOT EXISTS `foodie`.`photo` (
  `id_photo` INT NOT NULL,
  `org_name` VARCHAR(45) NULL,
  `url` VARCHAR(45) NULL,
  `size` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `shop_id` INT NOT NULL,
  `dish_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id_photo`),
  INDEX `fk_photo_shop1_idx` (`shop_id` ASC),
  INDEX `fk_photo_dish1_idx` (`dish_id` ASC),
  INDEX `fk_photo_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_photo_shop1`
    FOREIGN KEY (`shop_id`)
    REFERENCES `foodie`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_photo_dish1`
    FOREIGN KEY (`dish_id`)
    REFERENCES `foodie`.`dish` (`dishId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_photo_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `foodie`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`comment` ;

CREATE TABLE IF NOT EXISTS `foodie`.`comment` (
  `orderId` INT NOT NULL,
  `userId` INT NOT NULL,
  `dishId` INT NOT NULL,
  `datetime` DATETIME NULL,
  `comment` VARCHAR(500) NULL,
  `star` VARCHAR(45) NULL,
  PRIMARY KEY (`orderId`),
  INDEX `fk_discuss_user1_idx` (`userId` ASC),
  INDEX `fk_comment_dish1_idx` (`dishId` ASC),
  CONSTRAINT `fk_discuss_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `foodie`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_discuss_order`
    FOREIGN KEY (`orderId`)
    REFERENCES `foodie`.`orders` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_dish1`
    FOREIGN KEY (`dishId`)
    REFERENCES `foodie`.`dish` (`dishId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`userPrefer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`userPrefer` ;

CREATE TABLE IF NOT EXISTS `foodie`.`userPrefer` (
  `id` INT NOT NULL,
  `language` VARCHAR(45) NULL,
  `dishes` VARCHAR(45) NULL,
  `background_pic` VARCHAR(45) NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_prefer_user1_idx` (`userId` ASC),
  CONSTRAINT `fk_user_prefer_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `foodie`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`complain`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`complain` ;

CREATE TABLE IF NOT EXISTS `foodie`.`complain` (
  `orderId` INT NOT NULL,
  `userId` INT NOT NULL,
  `date` DATETIME NULL,
  `title` VARCHAR(45) NULL,
  `detail` VARCHAR(500) NULL,
  `soluction` VARCHAR(500) NULL,
  INDEX `fk_complain_user1_idx` (`userId` ASC),
  INDEX `fk_complain_order1_idx` (`orderId` ASC),
  CONSTRAINT `fk_complain_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `foodie`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_complain_order1`
    FOREIGN KEY (`orderId`)
    REFERENCES `foodie`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`shoppingCart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`shoppingCart` ;

CREATE TABLE IF NOT EXISTS `foodie`.`shoppingCart` (
  `userId` INT NOT NULL,
  `shoppingCart` TEXT(2000) NOT NULL,
  INDEX `fk_shoppingCart_user1_idx` (`userId` ASC),
  CONSTRAINT `fk_shoppingCart_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `foodie`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`orderDish`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`orderDish` ;

CREATE TABLE IF NOT EXISTS `foodie`.`orderDish` (
  `orderId` INT NOT NULL,
  `dishId` INT NOT NULL,
  `amount` INT NULL,
  `price` INT NULL,
  INDEX `fk_table1_order1_idx` (`orderId` ASC),
  INDEX `fk_table1_dish1_idx` (`dishId` ASC),
  CONSTRAINT `fk_table1_order1`
    FOREIGN KEY (`orderId`)
    REFERENCES `foodie`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_dish1`
    FOREIGN KEY (`dishId`)
    REFERENCES `foodie`.`dish` (`dishId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`state` ;

CREATE TABLE IF NOT EXISTS `foodie`.`state` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `shortName` VARCHAR(10) NULL,
  `fullName` VARCHAR(80) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`city` ;

CREATE TABLE IF NOT EXISTS `foodie`.`city` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(45) NULL,
  `postcode` VARCHAR(45) NULL,
  `stateId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_city_state1_idx` (`stateId` ASC),
  CONSTRAINT `fk_city_state1`
    FOREIGN KEY (`stateId`)
    REFERENCES `foodie`.`state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`district`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`district` ;

CREATE TABLE IF NOT EXISTS `foodie`.`district` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `postcode` VARCHAR(8) NULL,
  `district` VARCHAR(45) NULL,
  `shortName` VARCHAR(45) NULL,
  `cityId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_district_city1_idx` (`cityId` ASC),
  CONSTRAINT `fk_district_city1`
    FOREIGN KEY (`cityId`)
    REFERENCES `foodie`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`street`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`street` ;

CREATE TABLE IF NOT EXISTS `foodie`.`street` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(100) NULL,
  `shortName` VARCHAR(45) NULL,
  `districtId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_road_district1_idx` (`districtId` ASC),
  CONSTRAINT `fk_road_district1`
    FOREIGN KEY (`districtId`)
    REFERENCES `foodie`.`district` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`building`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`building` ;

CREATE TABLE IF NOT EXISTS `foodie`.`building` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `buildingNumber` VARCHAR(10) NULL,
  `buildingName` VARCHAR(45) NULL,
  `buildingShortName` VARCHAR(45) NULL,
  `roadId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_building_road1_idx` (`roadId` ASC),
  CONSTRAINT `fk_building_road1`
    FOREIGN KEY (`roadId`)
    REFERENCES `foodie`.`street` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`deliveryTogether`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`deliveryTogether` ;

CREATE TABLE IF NOT EXISTS `foodie`.`deliveryTogether` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userId` INT NOT NULL COMMENT 'Create user id',
  `restaurantId` INT NOT NULL,
  `status` VARCHAR(45) NULL COMMENT 'Starting\nClosed\nCooking\nDelivering \nDelivered  \n',
  `startTime` DATETIME NULL,
  `endTime` DATETIME NULL,
  `deliveryFee` INT NULL,
  `deliverId` INT NOT NULL,
  `deliveryTime` DATETIME NULL,
  `deliveriedTime` DATETIME NULL,
  `deliveryAddressDistrict` VARCHAR(45) NULL,
  `deliveryAddressStreet` VARCHAR(45) NULL,
  `deliveryAddressBuilding` VARCHAR(45) NULL,
  `deliveryAddressGPS` VARCHAR(45) NULL,
  `paymentStatus` VARCHAR(45) NULL COMMENT '\nWaiting For Payment\nPaid',
  PRIMARY KEY (`id`),
  INDEX `fk_deliveryTogether_user1_idx` (`userId` ASC),
  INDEX `fk_deliveryTogether_restaurant1_idx` (`restaurantId` ASC),
  INDEX `fk_deliveryTogether_deliver1_idx` (`deliverId` ASC),
  CONSTRAINT `fk_deliveryTogether_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `foodie`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deliveryTogether_restaurant1`
    FOREIGN KEY (`restaurantId`)
    REFERENCES `foodie`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deliveryTogether_deliver1`
    FOREIGN KEY (`deliverId`)
    REFERENCES `foodie`.`deliver` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`joinedMember`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`joinedMember` ;

CREATE TABLE IF NOT EXISTS `foodie`.`joinedMember` (
  `joinId` INT NOT NULL,
  `deliveryTogetherId` INT NOT NULL,
  `userId` INT NOT NULL,
  `paidDeliveryFee` INT NULL,
  `togetherDeliveryFee` INT NULL,
  `returnedCredit` INT NULL,
  `totalPrice` INT NULL,
  `paymentStatus` VARCHAR(45) NULL COMMENT 'Waiting for payment\npaid',
  INDEX `fk_joinedMember_deliveryTogether1_idx` (`deliveryTogetherId` ASC),
  PRIMARY KEY (`joinId`, `deliveryTogetherId`),
  INDEX `fk_joinedMember_user1_idx` (`userId` ASC),
  CONSTRAINT `fk_joinedMember_deliveryTogether1`
    FOREIGN KEY (`deliveryTogetherId`)
    REFERENCES `foodie`.`deliveryTogether` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_joinedMember_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `foodie`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`deliveryTogetherDishes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`deliveryTogetherDishes` ;

CREATE TABLE IF NOT EXISTS `foodie`.`deliveryTogetherDishes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `deliveryTogetherId` INT NOT NULL,
  `userId` INT NOT NULL,
  `dishId` INT NOT NULL,
  `amount` INT NULL,
  `price` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_DeliveryTogetherDishes_joinedMember1_idx` (`deliveryTogetherId` ASC, `userId` ASC),
  INDEX `fk_DeliveryTogetherDishes_dish1_idx` (`dishId` ASC),
  CONSTRAINT `fk_DeliveryTogetherDishes_joinedMember1`
    FOREIGN KEY (`deliveryTogetherId` , `userId`)
    REFERENCES `foodie`.`joinedMember` (`deliveryTogetherId` , `userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DeliveryTogetherDishes_dish1`
    FOREIGN KEY (`dishId`)
    REFERENCES `foodie`.`dish` (`dishId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`DeliveryTogetherShoppingCart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`DeliveryTogetherShoppingCart` ;

CREATE TABLE IF NOT EXISTS `foodie`.`DeliveryTogetherShoppingCart` (
  `deliveryTogetherId` INT NOT NULL,
  `shoppingCart` TEXT(2000) NOT NULL,
  INDEX `fk_shoppingCart_user10_idx` (`deliveryTogetherId` ASC),
  CONSTRAINT `fk_shoppingCart_user10`
    FOREIGN KEY (`deliveryTogetherId`)
    REFERENCES `foodie`.`deliveryTogether` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`DeliveryTogetherPayment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`DeliveryTogetherPayment` ;

CREATE TABLE IF NOT EXISTS `foodie`.`DeliveryTogetherPayment` (
  `paymentId` INT NOT NULL AUTO_INCREMENT,
  `deliveryTogetherId` INT NOT NULL,
  `userId` INT NOT NULL,
  `startTime` DATETIME NULL,
  `channel` VARCHAR(20) NULL COMMENT 'Visa\nbalpay',
  `paymentClient` VARCHAR(100) NULL,
  `status` VARCHAR(10) NULL,
  `finishTime` DATETIME NULL,
  `paymentAmount` VARCHAR(45) NULL,
  INDEX `fk_payment_joinedMember1_idx` (`deliveryTogetherId` ASC, `userId` ASC),
  PRIMARY KEY (`paymentId`),
  CONSTRAINT `fk_payment_joinedMember1`
    FOREIGN KEY (`deliveryTogetherId` , `userId`)
    REFERENCES `foodie`.`joinedMember` (`deliveryTogetherId` , `userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodie`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodie`.`payment` ;

CREATE TABLE IF NOT EXISTS `foodie`.`payment` (
  `paymentId` INT NOT NULL AUTO_INCREMENT,
  `orderId` INT NOT NULL,
  `startTime` DATETIME NULL,
  `finishTime` DATETIME NULL,
  `channel` VARCHAR(20) NULL,
  `paymentClient` VARCHAR(100) NULL,
  `status` VARCHAR(10) NULL,
  INDEX `fk_payment_order1_idx` (`orderId` ASC),
  PRIMARY KEY (`paymentId`),
  CONSTRAINT `fk_payment_order1`
    FOREIGN KEY (`orderId`)
    REFERENCES `foodie`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `foodie` ;

-- -----------------------------------------------------
-- Placeholder table for view `foodie`.`orderedDishesView`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `foodie`.`orderedDishesView` (`orderId` INT, `dishId` INT, `amount` INT, `name` INT, `price` INT);

-- -----------------------------------------------------
-- View `foodie`.`orderedDishesView`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `foodie`.`orderedDishesView` ;
DROP TABLE IF EXISTS `foodie`.`orderedDishesView`;
USE `foodie`;
CREATE  OR REPLACE VIEW `orderedDishesView` AS
select  o.id as orderId, 
	d.dishId as dishId,
	d.amount as amount, 
    h.name as name,
	d.price as price
from orders o, orderDish d, dish h where o.id = d.orderId and d.dishId=h.dishId;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
