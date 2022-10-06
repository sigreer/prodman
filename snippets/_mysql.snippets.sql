-- Active: 1663278430108@@127.0.0.1@3306@products

SELECT product.*, product_hardware.* FROM product
RIGHT JOIN product_hardware ON product.id=product_hardware.product_hardware_id;

-- left join
SELECT product.id, product.sku, product_hardware.height, product_hardware.height, product_hardware.width FROM product
LEFT JOIN product_hardware ON product.id=product_hardware.product_hardware_id;

-- inner join
SELECT product.id, product.sku, product_hardware.height, product_hardware.height, product_hardware.width FROM product
INNER JOIN product_hardware ON product.id=product_hardware.product_hardware_id;

-- quick selects
SELECT * FROM product_hardware;
SELECT * FROM product_software;

SELECT * FROM product;
SELECT * FROM product_type;


DELETE FROM product;
DELETE FROM product_hardware;
DELETE FROM product_type;


ALTER TABLE product MODIFY id INT NOT NULL AUTO_INCREMENT;

SELECT product.id, product.sku, product_hardware.height, product_hardware.height, product_hardware.width FROM product
RIGHT JOIN product_hardware ON product.id=product_hardware.product_hardware_id;

INSERT INTO attrgrp_tc_software VALUES
(DEFAULT,'Windows 10 IoT Enterprise',01,'Microsoft',02,'Windows',03,02);

INSERT INTO thin_client (product_id, product_type, hardware_type) VALUES (LAST_INSERT_ID(), 'hardware', 'thin_client' );

INSERT INTO attrgrp_tc_software_entry (product_id, attrgrp_tc_software_id) VALUES (LAST_INSERT_ID(), 1 );


SELECT
    product.sku, 
    product.name,
    attrgrp_tc_software.attrgrp_tc_software_id,
    product.price,
    product.description,
    product_hardware.width,
    product_hardware.height,
    product_hardware.depth,
    product_hardware.weight,
    product_hardware.hardware_type
FROM thin_client_listing thin_clent
LEFT JOIN 
    hardware_listing hardware 
    RIGHT JOIN 
        thin_client_listing thin_client
        RIGHT JOIN attrgrp_tc_software_entry
            ON attrgrp_tc_software_entry.product_id=thin_client.product_id
LEFT JOIN product ON thin_client.product_id=product.id;
RIGHT JOIN attrgrp_tc_software_entry thin_client.product_id=attrgrp_tc_software.product_id;

SELECT * --thin_client.hardware_type, attrgrp_tc_software.name, attrgrp_tc_software.manufacturer
FROM thin_client
    LEFT JOIN attrgrp_tc_software_entry
        LEFT JOIN attrgrp_tc_software
        ON attrgrp_tc_software_entry.attrgrp_tc_software_id=attrgrp_tc_software.id
    ON attrgrp_tc_software_entry.product_id=thin_client.product_id
    RIGHT JOIN hardware
        RIGHT JOIN product
        ON hardware.product_id=product.id
    ON hardware.product_id=thin_client.product_id;

EXEC sp_fkeys thin_client;


SELECT * FROM thin_client
    RIGHT JOIN product_common 
    ON thin_client.product_id=product_common.id
    LEFT JOIN attr_cpu
    ON thin_client.attr_cpu_id=attr_cpu.id
    LEFT JOIN attr_ram
    ON thin_client.attr_ram_id=attr_ram.id
    LEFT JOIN attr_energy
    ON thin_client.attr_energy_id=attr_energy.id
    LEFT JOIN attr_security
    ON thin_client.attr_security_id=attr_security.id
    LEFT JOIN attr_graphics
    ON thin_client.attr_graphics_id=attr_graphics.id
    LEFT JOIN attr_network
    ON thin_client.attr_network_id=attr_network.id
    LEFT JOIN attr_physical
    ON thin_client.attr_physical_id=attr_physical.id
    LEFT JOIN attr_ports
    ON thin_client.attr_ports_id=attr_ports.id
    LEFT JOIN attr_ssd_storage
    ON thin_client.attr_ssd_storage_id=attr_ssd_storage.id
    LEFT JOIN attr_thin_client_software
    ON thin_client.attr_thin_client_software_id=attr_thin_client_software.id;
    
--    LEFT JOIN attr_ram 
--    ON attr_ram.id=thin_client.attr_ram_id
--    RIGHT JOIN product_common
 --   ON thin_client.product_id=product_common.id;

drop database products;

INSERT INTO attr_display (
    display_size,
    aspect_ratio,
    display_max_res,
    display_standard,
    contrast_ratio,
    brightness,
    response_time,
    max_display_frequency,
    colour_depth,
    panel_type
)
VALUES (
    21.0,
    '16:9',
    '1920 x 1080',
    'fhd',
    '1000:1',
    500,
    5,
    56,
    '16m',
    'ips'
);
SET @AttrDisplayId = LAST_INSERT_ID();
-- =====================












    display_size,
    aspect_ratio,
    display_max_res,
    display_standard,
    contrast_ratio,
    brightness,
    response_time,
    max_display_frequency,
    colour_depth,
    panel_type

-- ---------------------
-- BLANK attribute entry
-- ---------------------
INSERT INTO attr_BLANK (
    BLANK,
    BLANK,
    BLANK,
    BLANK,
    BLANK,
    BLANK,
    BLANK
)
VALUES (
    BLANK,
    BLANK,
    BLANK,
    BLANK,
    BLANK,
    BLANK,
    BLANK
);

-- This sets a variable to the product type and then queries the product's 
-- joining table and returns a list of all FKs in that table, omitting the
-- FK for the parent (product_common). Can be used to generate a list of
-- attribute FKs for any product type so that they don't need to be hard-coded
-- into the frontend app.
SET @thisProductType = 'monitor';
SELECT
    REFERENCED_TABLE_NAME AS 'attrgroup'
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
	REFERENCED_TABLE_SCHEMA = 'products'
    AND TABLE_NAME = @thisProductType
    AND REFERENCED_COLUMN_NAME = 'id'
    AND NOT REFERENCED_TABLE_NAME = 'product_common';

    SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE REFERENCED_TABLE_SCHEMA = 'products' AND TABLE_NAME = 'monitor' AND REFERENCED_COLUMN_NAME = 'id' AND NOT REFERENCED_TABLE_NAME = 'product_common';
    SELECT product_type_name FROM product_type_enforcer;