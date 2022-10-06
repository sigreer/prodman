```
-- Active: 1663278430108@@127.0.0.1@3306@products

-- ---------------------
-- insert product_common values
-- ---------------------
use products;

INSERT INTO product_common
(
    id,
    sku,
    cost_price,
    sale_price,
    product_type
) 
VALUES
(
    DEFAULT,
    @pSku,
    @pCostPrice,
    @pSalePrice,
    @ProductType
)
ON DUPLICATE KEY UPDATE
    sku = @pSku,
    cost_price = @pCostPrice,
    sale_price = @pSalePrice,
    product_type = @pProductType
    ;

SET @currentProductId = LAST_INSERT_ID();



-- ---------------------
-- physical attribute entry
-- ---------------------
INSERT INTO attr_physical (
    weight,
    height,
    width,
    depth,
    colour
)
VALUES (
    @phyWeight,
    @phyHeight,
    @phyWidth,
    @phyDepth,
    @phyColour
);
SET @attrPhysicalId = LAST_INSERT_ID();

-- ---------------------
-- thin_client_software attribute entry
-- ---------------------
INSERT INTO attr_thin_client_software (
    os_name,
    os_type,
    supported_platforms,
    management
)
VALUES (
    @osName,
    @osType,
    @supportedPlatforms,
    @tcsManagement
);
SET @attrThinClientSoftwareId = LAST_INSERT_ID();


-- ---------------------
-- cpu attribute entry
-- ---------------------
INSERT INTO attr_cpu (
    cpu_name,
    cpu_clock_speed,
    cpu_max_clock_speed,
    cpu_core_count,
    cpu_threads,
    cooling,
    chipset_architecture
)
VALUES (
    @cpuName,
    @cpuClockSpeed,
    @cpuMaxClockSpeed,
    @cpuCoreCount,
    @cpuThreads,
    @cpuCooling,
    @chipsetArchitecture
);

SET @attrCpuId = LAST_INSERT_ID();
-- =====================


-- ---------------------
-- ram attribute entry
-- ---------------------
INSERT INTO attr_ram (
    capacity,
    transfer_rate,
    ram_type
)
VALUES (
    @ramCapacity,
    @ramTransferRate,
    @ramType
);

SET @attrRamId = LAST_INSERT_ID();
-- =====================

-- ---------------------
-- ssd attribute entry
-- ---------------------
INSERT INTO attr_ssd_storage (
    capacity,
    write_speed,
    ssd_type,
    interface,
    read_speed,
    throughput,
    iops,
    endurance,
    ssd_class,
    response_time,
    cache_type    
)
VALUES (
    @ssdCapacity,
    @ssdWriteSpeed,
    @ssdType,
    @ssdInterface,
    @ssdReadSpeed,
    @ssdThroughput,
    @ssdIops,
    @ssdEndurance,
    @ssdClass,
    @ssdResponseTime,
    @ssdCacheType
);
SET @attrSddStorageId = LAST_INSERT_ID();
-- ---------------------
-- Network attribute entry
-- ---------------------
INSERT INTO attr_network (
    ethernet_standard,
    wifi,
    wifi_bands,
    wifi_certification,
    bluetooth,
    bluetooth_version,
    wwan,
    nfc
)
VALUES (
    @networkEthernetStandard,
    @networkWifi,
    @networkWifiBands,
    @networkWifiCertification,
    @networkBluetooth,
    @networkBluetothVersion,
    @networkWwan,
    @networkNfc
);
SET @attrNetworkId = LAST_INSERT_ID();
-- ---------------------
-- Graphics attribute entry
-- ---------------------
INSERT INTO attr_graphics (
    max_resolution,
    graphics_name,
    graphics_memory,
    max_total_displays
    )
VALUES (
    @graphicsMaxResolution,
    @graphicsName,
    @graphicsMemory,
    @graphicsMaxTotalDisplays
);
SET @attrGraphicsId = LAST_INSERT_ID();
-- ---------------------
-- Ports attribute entry
-- ---------------------
INSERT INTO attr_ports (
    connectivity_ports,
    display_ports,
    network_ports,
    audio_ports,
    serial_com_ports,
    power_ports,
    misc_ports
)
VALUES (
    @connectivityPorts,
    @displayPorts,
    @networkPorts,
    @audioPorts,
    @serialComPorts,
    @powerPorts,
    @miscPorts
);
SET @attrPortsId = LAST_INSERT_ID();
-- ---------------------
-- Energy attribute entry
-- ---------------------
INSERT INTO attr_energy (
    energy_star_rating,
    typical_power_usage,
    max_power_usage,
    idle_power_usage
)
VALUES (
    @energyStarRating,
    @typicalPowerUsage,
    @maxPowerUsage,
    @idlePowerUsage
);
SET @attrEnergyId = LAST_INSERT_ID();

-- ---------------------
-- Security attribute entry
-- ---------------------
INSERT INTO attr_security (
    tpm,
    smartcard_reader,
    tpm_version,
    kensington_lock
)
VALUES (
    @securityTpm,
    @securitySmartcardReader,
    @securityTpmVersion,
    @securityKensingtonLock
);
SET @attrSecurityId = LAST_INSERT_ID();

-- List of Attribute IDs associated to current product
select @currentProductId, @attrPhysicalId, @attrThinClientSoftwareId, @attrCpuId, @attrRamId, @attrNetworkId, @attrGraphicsId, @attrPortsId, @attrEnergyId, @attrSecurityId;
-- =====================

-- Insert Attribute Values into thin_client joining table
INSERT INTO thin_client (
    product_id,
    product_type,
    attr_physical_id,
    attr_cpu_id,
    attr_ram_id,
    attr_graphics_id,
    attr_thin_client_software_id,
    attr_network_id,
    attr_ports_id,
    attr_energy_id,
    attr_security_id,
    attr_ssd_storage_id
)
VALUES (
    @currentProductId,
    @productType,
    @attrPhysicalId,
    @attrCpuId,
    @attrRamId,
    @attrGraphicsId,
    @attrThinClientSoftwareId,
    @attrNetworkId,
    @attrPortsId,
    @attrEnergyId,
    @attrSecurityId,
    @attrSsdStorageId
)
ON DUPLICATE KEY UPDATE 
    product_id=LAST_INSERT_ID(product_id),
    attr_physical_id = @attrPhysicalId,
    attr_cpu_id = @attrCpuId,
    attr_ram_id = @attrRamId,
    attr_graphics_id = @attrGraphicsId,
    attr_thin_client_software_id = @attrThinClientSoftwareId,
    attr_network_id = @attrNetworkId,
    attr_ports_id = @attrPortsId,
    attr_energy_id = @attrEnergyId,
    attr_security_id = @attrSecurityId,
    attr_ssd_storage_id = @attrSsdStorageId
    ;
-- =====================
```