SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema products
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `products` ;

-- -----------------------------------------------------
-- Schema products
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `products` ;
USE `products` ;

-- -----------------------------------------------------
-- Table `product_type_enforcer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_type_enforcer` ;

CREATE TABLE IF NOT EXISTS `product_type_enforcer` (
  `product_type` CHAR(3) NOT NULL,
  `product_type_name` VARCHAR(45) NULL,
  `product_type_label` VARCHAR(45) NULL,
  PRIMARY KEY (`product_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product_common`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_common` ;

CREATE TABLE IF NOT EXISTS `product_common` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sku` VARCHAR(45) NOT NULL,
  `cost_price` DECIMAL(9,2) NULL,
  `sale_price` DECIMAL(9,2) NULL,
  `product_type` CHAR(3) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `sku_UNIQUE` (`sku` ASC) VISIBLE,
  INDEX `fk_product_type_enforcer_idx` (`product_type` ASC) VISIBLE,
  CONSTRAINT `fk_product_type_enforcer`
    FOREIGN KEY (`product_type`)
    REFERENCES `product_type_enforcer` (`product_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attr_physical`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attr_physical` ;

CREATE TABLE IF NOT EXISTS `attr_physical` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attr_group` CHAR(3) NULL DEFAULT 'phy',
  `attr_group_sort` INT(3) NULL DEFAULT '110',
  `weight` INT(5) NULL,
  `height` INT(5) NULL,
  `width` INT(5) NULL,
  `depth` INT(5) NULL,
  `colour` VARCHAR(14) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attr_cpu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attr_cpu` ;

CREATE TABLE IF NOT EXISTS `attr_cpu` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attr_group` CHAR(3) NULL DEFAULT 'cpu',
  `attr_group_sort` INT(3) NULL DEFAULT 102,
  `cooling` VARCHAR(45) NULL,
  `cpu_name` VARCHAR(45) NULL,
  `cpu_clock_speed` DECIMAL(4,2) NULL,
  `cpu_max_clock_speed` DECIMAL(4,2) NULL,
  `cpu_core_count` INT(3) NULL,
  `cpu_threads` INT(3) NULL,
  `chipset_architecture` VARCHAR(11) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpu_name_UNIQUE` (`cpu_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attr_thin_client_software`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attr_thin_client_software` ;

CREATE TABLE IF NOT EXISTS `attr_thin_client_software` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attr_group` CHAR(3) NULL DEFAULT 'tcs',
  `attr_group_sort` INT(3) NULL DEFAULT '103',
  `os_name` VARCHAR(45) NULL,
  `os_type` VARCHAR(15) NULL,
  `supported_platforms` VARCHAR(45) NULL,
  `management` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thin_client_enforcer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `thin_client_enforcer` ;

CREATE TABLE IF NOT EXISTS `thin_client_enforcer` (
  `product_type` CHAR(3) NOT NULL,
  PRIMARY KEY (`product_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attr_ram`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attr_ram` ;

CREATE TABLE IF NOT EXISTS `attr_ram` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attr_group` CHAR(3) NULL DEFAULT 'ram',
  `attr_group_sort` INT(3) NULL DEFAULT '102',
  `capacity` INT(4) NULL,
  `transfer_rate` INT(6) NULL,
  `ram_type` VARCHAR(6) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attr_network`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attr_network` ;

CREATE TABLE IF NOT EXISTS `attr_network` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attr_group` CHAR(3) NULL DEFAULT 'net',
  `attr_group_sort` INT(3) NULL DEFAULT 130,
  `ethernet_standard` VARCHAR(45) NULL,
  `wifi` TINYINT(1) NULL,
  `wifi_bands` VARCHAR(45) NULL,
  `wifi_certification` VARCHAR(45) NULL,
  `bluetooth` TINYINT(1) NULL,
  `bluetooth_version` DECIMAL(2,1) NULL,
  `wwan` TINYINT(1) NULL,
  `nfc` TINYINT(1) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attr_graphics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attr_graphics` ;

CREATE TABLE IF NOT EXISTS `attr_graphics` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attr_group` CHAR(3) NULL DEFAULT 'gra',
  `attr_group_sort` INT(3) NULL DEFAULT 120,
  `max_resolution` VARCHAR(45) NULL,
  `graphics_name` VARCHAR(45) NULL,
  `graphics_memory` INT(2) NULL,
  `max_total_displays` INT(2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attr_ports`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attr_ports` ;

CREATE TABLE IF NOT EXISTS `attr_ports` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attr_group` CHAR(3) NULL DEFAULT 'por',
  `attr_group_sort` INT(3) NULL DEFAULT 180,
  `connectivity_ports` VARCHAR(45) NULL,
  `display_ports` VARCHAR(45) NULL,
  `network_ports` VARCHAR(45) NULL,
  `audio_ports` VARCHAR(45) NULL,
  `serial_com_ports` VARCHAR(45) NULL,
  `power_ports` VARCHAR(45) NULL,
  `misc_ports` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attr_energy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attr_energy` ;

CREATE TABLE IF NOT EXISTS `attr_energy` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attr_group` CHAR(3) NULL DEFAULT 'ene',
  `attr_group_sort` INT(3) NULL DEFAULT 104,
  `energy_star_rating` CHAR(1) NULL,
  `typical_power_usage` INT(4) NULL,
  `max_power_usage` INT(4) NULL,
  `idle_power_usage` INT(4) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attr_security`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attr_security` ;

CREATE TABLE IF NOT EXISTS `attr_security` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attr_group` CHAR(3) NULL DEFAULT 'sec',
  `attr_group_sort` INT(3) NULL DEFAULT 180,
  `tpm` TINYINT(1) NULL,
  `smartcard_reader` TINYINT(1) NULL,
  `tpm_version` DECIMAL(2,1) NULL,
  `kensington_lock` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attr_ssd_storage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attr_ssd_storage` ;

CREATE TABLE IF NOT EXISTS `attr_ssd_storage` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attr_group` CHAR(3) NULL DEFAULT 'ssd',
  `attr_group_sort` INT(3) NULL DEFAULT 140,
  `capacity` INT(5) NULL,
  `write_speed` INT(8) NULL,
  `ssd_type` VARCHAR(20) NULL,
  `interface` VARCHAR(20) NULL,
  `read_speed` INT(8) NULL,
  `throughput` INT(8) NULL,
  `iops` INT(8) NULL,
  `endurance` INT(8) NULL,
  `ssd_class` VARCHAR(45) NULL,
  `response_time` DECIMAL(3,2) NULL,
  `cache_type` VARCHAR(5) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thin_client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `thin_client` ;

CREATE TABLE IF NOT EXISTS `thin_client` (
  `product_type` CHAR(3) NULL DEFAULT 'thi',
  `product_id` INT NOT NULL,
  `attr_physical_id` INT NULL,
  `attr_thin_client_software_id` INT NULL,
  `attr_cpu_id` INT NULL,
  `attr_ram_id` INT NULL,
  `attr_ssd_storage_id` INT NULL,
  `attr_network_id` INT NULL,
  `attr_graphics_id` INT NULL,
  `attr_ports_id` INT NULL,
  `attr_energy_id` INT NULL,
  `attr_security_id` INT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_thin_client_attr_thin_client_software_id_idx` (`attr_thin_client_software_id` ASC) VISIBLE,
  INDEX `fk_thin_client_attr_cpu_id_idx` (`attr_cpu_id` ASC) VISIBLE,
  INDEX `fk_thin_client_attr_physical_id_idx` (`attr_physical_id` ASC) VISIBLE,
  INDEX `fk_thin_client_enforcer_idx` (`product_type` ASC) VISIBLE,
  INDEX `fk_thin_client_attr_ram_id_idx` (`attr_ram_id` ASC) VISIBLE,
  INDEX `fk_thin_client_attr_network_id_idx` (`attr_network_id` ASC) VISIBLE,
  INDEX `fk_thin_client_attr_graphics_id_idx` (`attr_graphics_id` ASC) VISIBLE,
  INDEX `fk_thin_client_security_id_idx` (`attr_security_id` ASC) VISIBLE,
  INDEX `fk_thin_client_energy_id_idx` (`attr_energy_id` ASC) VISIBLE,
  INDEX `fk_thin_client_attr_ports_id_idx` (`attr_ports_id` ASC) VISIBLE,
  INDEX `fk_thin_client_ssd_id_idx` (`attr_ssd_storage_id` ASC) VISIBLE,
  CONSTRAINT `fk_thin_client_product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `product_common` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_thin_client_attr_physical_id`
    FOREIGN KEY (`attr_physical_id`)
    REFERENCES `attr_physical` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_thin_client_attr_cpu_id`
    FOREIGN KEY (`attr_cpu_id`)
    REFERENCES `attr_cpu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_thin_client_attr_thin_client_software_id`
    FOREIGN KEY (`attr_thin_client_software_id`)
    REFERENCES `attr_thin_client_software` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_thin_client_enforcer`
    FOREIGN KEY (`product_type`)
    REFERENCES `thin_client_enforcer` (`product_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_thin_client_attr_ram_id`
    FOREIGN KEY (`attr_ram_id`)
    REFERENCES `attr_ram` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_thin_client_attr_network_id`
    FOREIGN KEY (`attr_network_id`)
    REFERENCES `attr_network` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_thin_client_attr_graphics_id`
    FOREIGN KEY (`attr_graphics_id`)
    REFERENCES `attr_graphics` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_thin_client_attr_ports_id`
    FOREIGN KEY (`attr_ports_id`)
    REFERENCES `attr_ports` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_thin_client_energy_id`
    FOREIGN KEY (`attr_energy_id`)
    REFERENCES `attr_energy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_thin_client_security_id`
    FOREIGN KEY (`attr_security_id`)
    REFERENCES `attr_security` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_thin_client_ssd_id`
    FOREIGN KEY (`attr_ssd_storage_id`)
    REFERENCES `attr_ssd_storage` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitor_enforcer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `monitor_enforcer` ;

CREATE TABLE IF NOT EXISTS `monitor_enforcer` (
  `product_type` CHAR(3) NOT NULL,
  PRIMARY KEY (`product_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attr_display`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attr_display` ;

CREATE TABLE IF NOT EXISTS `attr_display` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attr_group` CHAR(3) NULL DEFAULT 'dis',
  `attr_group_sort` INT(3) NULL,
  `display_size` DECIMAL(3,1) NULL,
  `aspect_ratio` VARCHAR(5) NULL,
  `display_max_res` VARCHAR(45) NULL,
  `display_standard` VARCHAR(45) NULL,
  `contrast_ratio` VARCHAR(10) NULL,
  `brightness` INT(6) NULL,
  `response_time` INT(3) NULL,
  `max_display_frequency` INT(4) NULL,
  `colour_depth` VARCHAR(45) NULL,
  `panel_type` CHAR(3) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attr_monitor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attr_monitor` ;

CREATE TABLE IF NOT EXISTS `attr_monitor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `attr_group` CHAR(3) NULL DEFAULT 'mon',
  `attr_group_sort` INT(3) NULL DEFAULT 110,
  `vesa_compatible` VARCHAR(25) NULL,
  `pip` TINYINT(1) NULL,
  `pbp` TINYINT(1) NULL,
  `tilt` TINYINT(1) NULL,
  `swivel` TINYINT(1) NULL,
  `pivot` TINYINT(1) NULL,
  `height_adjustable` TINYINT(1) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `monitor` ;

CREATE TABLE IF NOT EXISTS `monitor` (
  `product_type` CHAR(3) NULL,
  `product_id` INT NOT NULL,
  `attr_physical_id` INT NULL,
  `attr_energy_id` INT NULL,
  `attr_security_id` INT NULL,
  `attr_ports_id` INT NULL,
  `attr_display_id` INT NULL,
  `attr_monitor_id` INT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_monitor_enforcer_idx` (`product_type` ASC) VISIBLE,
  INDEX `fk_monitor_physical_idx` (`attr_physical_id` ASC) VISIBLE,
  INDEX `fk_monitor_energy_idx` (`attr_energy_id` ASC) VISIBLE,
  INDEX `fk_monitor_ports_idx` (`attr_ports_id` ASC) VISIBLE,
  INDEX `fk_monitor_security_idx` (`attr_security_id` ASC) VISIBLE,
  INDEX `fk_monitor_display_idx` (`attr_display_id` ASC) VISIBLE,
  INDEX `fk_monitor_monitor_idx` (`attr_monitor_id` ASC) VISIBLE,
  CONSTRAINT `fk_monitor_enforcer`
    FOREIGN KEY (`product_type`)
    REFERENCES `monitor_enforcer` (`product_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_monitor_product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `product_common` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_monitor_physical`
    FOREIGN KEY (`attr_physical_id`)
    REFERENCES `attr_physical` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_monitor_energy`
    FOREIGN KEY (`attr_energy_id`)
    REFERENCES `attr_energy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_monitor_ports`
    FOREIGN KEY (`attr_ports_id`)
    REFERENCES `attr_ports` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_monitor_security`
    FOREIGN KEY (`attr_security_id`)
    REFERENCES `attr_security` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_monitor_display`
    FOREIGN KEY (`attr_display_id`)
    REFERENCES `attr_display` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_monitor_monitor`
    FOREIGN KEY (`attr_monitor_id`)
    REFERENCES `attr_monitor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laptop_enforcer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `laptop_enforcer` ;

CREATE TABLE IF NOT EXISTS `laptop_enforcer` (
  `product_type` CHAR(3) NOT NULL,
  PRIMARY KEY (`product_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laptop`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `laptop` ;

CREATE TABLE IF NOT EXISTS `laptop` (
  `product_type` CHAR(3) NULL,
  `product_id` INT NOT NULL,
  `attr_physical_id` INT NULL,
  `attr_cpu_id` INT NULL,
  `attr_ram_id` INT NULL,
  `attr_thin_client_software_id` INT NULL,
  `attr_network_id` INT NULL,
  `attr_graphics_id` INT NULL,
  `attr_ports_id` INT NULL,
  `attr_security_id` INT NULL,
  `attr_display_id` INT NULL,
  `attr_energy_id` INT NULL,
  `attr_ssd_storage_id` INT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_laptop_enforcer_idx` (`product_type` ASC) VISIBLE,
  INDEX `fk_laptop_physical_idx` (`attr_physical_id` ASC) VISIBLE,
  INDEX `fk_laptop_ram_idx` (`attr_ram_id` ASC) VISIBLE,
  INDEX `fk_laptop_cpu_idx` (`attr_cpu_id` ASC) VISIBLE,
  INDEX `fk_laptop_thin_client_software_idx` (`attr_thin_client_software_id` ASC) VISIBLE,
  INDEX `fk_laptop_network_idx` (`attr_network_id` ASC) VISIBLE,
  INDEX `fk_laptop_graphics_idx` (`attr_graphics_id` ASC) VISIBLE,
  INDEX `fk_laptop_ports_idx` (`attr_ports_id` ASC) VISIBLE,
  INDEX `fk_laptop_display_idx` (`attr_display_id` ASC) VISIBLE,
  INDEX `fk_laptop_security_idx` (`attr_security_id` ASC) VISIBLE,
  INDEX `fk_laptop_energy_idx` (`attr_energy_id` ASC) VISIBLE,
  INDEX `fk_laptop_ssd_idx` (`attr_ssd_storage_id` ASC) VISIBLE,
  CONSTRAINT `fk_laptop_enforcer`
    FOREIGN KEY (`product_type`)
    REFERENCES `laptop_enforcer` (`product_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_laptop_poduct_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `product_common` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_laptop_physical`
    FOREIGN KEY (`attr_physical_id`)
    REFERENCES `attr_physical` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_laptop_cpu`
    FOREIGN KEY (`attr_cpu_id`)
    REFERENCES `attr_cpu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_laptop_ram`
    FOREIGN KEY (`attr_ram_id`)
    REFERENCES `attr_ram` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_laptop_thin_client_software`
    FOREIGN KEY (`attr_thin_client_software_id`)
    REFERENCES `attr_thin_client_software` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_laptop_network`
    FOREIGN KEY (`attr_network_id`)
    REFERENCES `attr_network` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_laptop_graphics`
    FOREIGN KEY (`attr_graphics_id`)
    REFERENCES `attr_graphics` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_laptop_ports`
    FOREIGN KEY (`attr_ports_id`)
    REFERENCES `attr_ports` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_laptop_energy`
    FOREIGN KEY (`attr_energy_id`)
    REFERENCES `attr_energy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_laptop_security`
    FOREIGN KEY (`attr_security_id`)
    REFERENCES `attr_security` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_laptop_display`
    FOREIGN KEY (`attr_display_id`)
    REFERENCES `attr_display` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_laptop_ssd_storage`
    FOREIGN KEY (`attr_ssd_storage_id`)
    REFERENCES `attr_ssd_storage` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `product_type_enforcer`
-- -----------------------------------------------------
START TRANSACTION;
USE `products`;
INSERT INTO `product_type_enforcer` (`product_type`, `product_type_name`, `product_type_label`) VALUES ('thi', 'thin_client', 'Thin Client');
INSERT INTO `product_type_enforcer` (`product_type`, `product_type_name`, `product_type_label`) VALUES ('mon', 'monitor', 'Monitor');
INSERT INTO `product_type_enforcer` (`product_type`, `product_type_name`, `product_type_label`) VALUES ('lic', 'software_licence', 'Software Licence');
INSERT INTO `product_type_enforcer` (`product_type`, `product_type_name`, `product_type_label`) VALUES ('aio', 'all_in_one_thin_client', 'All-In-One Thin Client');
INSERT INTO `product_type_enforcer` (`product_type`, `product_type_name`, `product_type_label`) VALUES ('acc', 'accessory_peripheral', 'Accessory or Peripheral');
INSERT INTO `product_type_enforcer` (`product_type`, `product_type_name`, `product_type_label`) VALUES ('lap', 'laptop', 'Laptop');
INSERT INTO `product_type_enforcer` (`product_type`, `product_type_name`, `product_type_label`) VALUES ('zer', 'zero_client', 'Zero Client');
INSERT INTO `product_type_enforcer` (`product_type`, `product_type_name`, `product_type_label`) VALUES ('sub', 'software_subscription', 'Software Subscription');

COMMIT;


-- -----------------------------------------------------
-- Data for table `thin_client_enforcer`
-- -----------------------------------------------------
START TRANSACTION;
USE `products`;
INSERT INTO `thin_client_enforcer` (`product_type`) VALUES ('thi');

COMMIT;


-- -----------------------------------------------------
-- Data for table `monitor_enforcer`
-- -----------------------------------------------------
START TRANSACTION;
USE `products`;
INSERT INTO `monitor_enforcer` (`product_type`) VALUES ('mon');

COMMIT;


-- -----------------------------------------------------
-- Data for table `laptop_enforcer`
-- -----------------------------------------------------
START TRANSACTION;
USE `products`;
INSERT INTO `laptop_enforcer` (`product_type`) VALUES ('lap');

COMMIT;

