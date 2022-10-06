-- thin_client variable set
-- product_common
    SET @pSku = 'NEWNEW1';
    SET @pCostPrice = 11.56;
    SET @pSalePrice = 13.99;
    SET @ProductType = 'thi';
-- physical
    SET @phyWeight = 1000;
    SET @phyHeight = 122;
    SET @phyWidth = 244;
    SET @phyDepth = 160;
    SET @phyColour = 'black';
-- thin_client_software
    SET @osName = 'Windows 10 IoT Enterprise';
    SET @osType = 'win';
    SET @supportedPlatforms = 'RDP';
    SET @tcsManagement = 'mic';
-- cpu
    SET @cpuName = 'Intel Skylake';
    SET @cpuClockSpeed = 2.00;
    SET @cpuMaxClockSpeed = 2.80;
    SET @cpuCoreCount = 8;
    SET @cpuThreads = 16;
    SET @cpuCooling = 'fan';
    SET @chipsetArchitecture = 'x86';
-- ram
    SET @ramCapacity = 4;
    SET @ramTransferRate = 2400;
    SET @ramType = 'ddr4';
-- ssd
    SET @ssdCapacity = 32;
    SET @ssdWriteSpeed = 5200;
    SET @ssdType = 'NVMe';
    SET @ssdInterface = 'm2';
    SET @ssdReadSpeed = 5400;
    SET @ssdThroughput = 6000;
    SET @ssdIops = 3200;
    SET @ssdEndurance = 4000;
    SET @ssdClass = 'Enterprise Read Intensive';
    SET @ssdResponseTime = 5;
    SET @ssdCacheType = 'slug';
--network
    SET @networkEthernetStandard = '10/100/1000';
    SET @networkWifi = 1;
    SET @networkWifiBands = '5GHz, 2.4GHz';
    SET @networkWifiCertification = '802.11ax';
    SET @networkBluetooth = 1;
    SET @networkBluetothVersion = 2.1;
    SET @networkWwan = 1;
    SET @networkNfc = 0;
-- graphics
    SET @graphicsMaxResolution = '1920 x 1080';
    SET @graphicsName = 'Matrox Mystique 720';
    SET @graphicsMemory = 8;
    SET @graphicsMaxTotalDisplays = 4;
-- ports
    SET @connectivityPorts = '5 x USB';
    SET @displayPorts = '1 x VGA';
    SET @networkPorts = '1 x RJ45 1GB Ethernet';
    SET @audioPorts = '1 x 2.5mm Audio Jack';
    SET @serialComPorts = '1 x DB9 Serial Interface';
    SET @powerPorts = '1 x DC-in';
    SET @miscPorts = '1 x Thunderbolt';
-- energy
    SET @energyStarRating = 'F';
    SET @typicalPowerUsage = 80;
    SET @maxPowerUsage = 400;
    SET @idlePowerUsage = 14;
-- security
    SET @securityTpm = 1;
    SET @securitySmartcardReader = 0;
    SET @securityTpmVersion = 2.1;
    SET @securityKensingtonLock = 1;