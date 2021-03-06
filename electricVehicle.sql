DROP TABLE product;

CREATE TABLE product (
    productId INT IDENTITY,
    productPrice DECIMAL(10,2),
    productImageURL VARCHAR(100),
    productBrand NVARCHAR(13),
    productEVType NVARCHAR(4),
    productBrandId NVARCHAR(36),
    productModel NVARCHAR(22),
    productReleaseYear INT,
    productVariant NVARCHAR(15),
    productBatterySize NUMERIC(3, 1),
    ac_charger_usable_phases INT,
    ac_charger_ports_0 NVARCHAR(5),
    ac_charger_max_power NUMERIC(3, 1),
    ac_charger_power_per_charging_point_11 NUMERIC(3, 1),
    ac_charger_power_per_charging_point_16 NUMERIC(3, 1),
    ac_charger_power_per_charging_point_22 NUMERIC(3, 1),
    ac_charger_power_per_charging_point_43 NUMERIC(3, 1),
    ac_charger_power_per_charging_point_2_0 INT,
    ac_charger_power_per_charging_point_2_3 NUMERIC(2, 1),
    ac_charger_power_per_charging_point_3_7 NUMERIC(2, 1),
    ac_charger_power_per_charging_point_7_4 NUMERIC(2, 1),
    dc_charger_ports_0 NVARCHAR(7),
    dc_charger_max_power INT,
    dc_charger_charging_curve_0_percentage INT,
    dc_charger_charging_curve_0_power INT,
    dc_charger_charging_curve_1_percentage INT,
    dc_charger_charging_curve_1_power INT,
    dc_charger_charging_curve_2_percentage INT,
    dc_charger_charging_curve_2_power NUMERIC(4, 1),
    dc_charger_is_default_charging_curve NVARCHAR(5),
    energy_consumption_average_consumption NUMERIC(3, 1),
    PRIMARY KEY (productId)
);

INSERT INTO product VALUES
    (1,******,******,N'Audi',N'bev',N'89c2668c-0c50-4344-9386-93e4000f7673',N'e-tron 55',2019,N'22kW-AC',86.5,3,N'type2',22,11.1,16.2,22,22,2,2.3,3.7,7.4,N'ccs',155,0,137,70,155,72,150,N'false',23.4),
    (2,******,******,N'Audi',N'bev',N'89c2668c-0c50-4344-9386-93e4000f7673',N'e-tron 50',2019,N'22kW-AC',65,3,N'type2',22,11.1,16.2,22,22,2,2.3,3.7,7.4,N'ccs',125,0,118,75,125,100,22,N'true',22.7),
    (3,******,******,N'Audi',N'phev',N'89c2668c-0c50-4344-9386-93e4000f7673',N'A3 Sportback 40 e-tron',2020,NULL,8.8,1,N'type2',3.7,3.7,3.7,3.7,3.7,2,2.3,3.7,3.7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,12.4),
    (4,******,******,N'BMW',N'phev',N'0742668c-bf59-4191-890e-2b0883508808',N'X5',2020,N'PHEV',21,1,N'type2',3.7,3.7,3.7,3.7,3.7,2,2.3,3.7,3.7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,21.3),
    (5,******,******,N'Fiat',N'bev',N'3291e5ba-862c-49fa-8437-71105743875e',N'500e',2020,NULL,42,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',85,0,80,75,85,100,11,N'true',16.8),
    (6,******,******,N'Ford',N'bev',N'6cf9e9b6-28aa-44c7-b6c3-438d518ac12f',N'Focus electric',2017,NULL,33.5,1,N'type2',6.6,3.7,5.4,6.6,6.6,2,2.3,3.7,6.6,N'ccs',50,0,47,75,50,100,6.6,N'true',16.4),
    (7,******,******,N'Hyundai',N'bev',N'9771afb8-9e25-4ae6-a5b3-b2a5b9f363f0',N'Ioniq',2019,NULL,38.3,1,N'type2',7.2,3.7,5.4,7.2,7.2,2,2.3,3.7,7.2,N'ccs',47,0,44,75,47,100,7.2,N'true',15.3),
    (8,******,******,N'Hyundai',N'bev',N'9771afb8-9e25-4ae6-a5b3-b2a5b9f363f0',N'Kona',2020,N'64 kWh',64,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',77,0,70,40,77,42,70,N'false',15.8),
    (9,******,******,N'Kia',N'bev',N'3337d5f0-39de-4ded-831b-843dfec1ebbd',N'Soul',2019,N'30 kWh',30,1,N'type2',6.6,3.7,5.4,6.6,6.6,2,2.3,3.7,6.6,N'chademo',50,0,47,75,50,100,6.6,N'true',17.6),
    (10,******,******,N'Kia',N'bev',N'3337d5f0-39de-4ded-831b-843dfec1ebbd',N'e-Niro',2020,N'64 kWh',64,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',77,0,70,40,77,42,70,N'false',17.3),
    (11,******,******,N'Kia',N'bev',N'3337d5f0-39de-4ded-831b-843dfec1ebbd',N'e-Soul',2020,N'64 kWh 11 kW-AC',64,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',77,0,73,75,77,100,11,N'true',17.5),
    (12,******,******,N'Mercedes Benz',N'bev',N'b2282fbe-f5d9-48d9-943f-a9b66ec51423',N'EQC',2019,NULL,80,2,N'type2',7.4,7.4,7.4,7.4,7.4,2,2.3,3.7,7.4,N'ccs',125,0,105,39,125,70,87,N'false',21.6),
    (13,******,******,N'Mitsubishi',N'phev',N'3cf8cf51-60ac-4cac-9f25-131c21eda12e',N'Outlander PHEV',2018,NULL,11,1,N'type1',3.7,3.7,3.7,3.7,3.7,2,2.3,3.7,3.7,N'chademo',22,0,20,75,22,100,3.7,N'true',15.2),
    (14,******,******,N'Nissan',N'bev',N'dab5a47a-e8ce-4d34-9139-0701499205b1',N'e-NV 200',2020,N'24 kWh',24,1,N'type1',3.6,3.6,3.6,3.6,3.6,2,2.3,3.6,3.6,N'chademo',46,0,43,75,46,100,3.6,N'true',20),
    (15,******,******,N'Nissan',N'bev',N'dab5a47a-e8ce-4d34-9139-0701499205b1',N'Leaf',2019,N'e+ 62 kWh',62,1,N'type2',6.6,3.7,5.4,6.6,6.6,2,2.3,3.7,6.6,N'chademo',100,0,95,75,100,100,6.6,N'true',17.2),
    (16,******,******,N'Renault',N'bev',N'c0d8a60c-34b8-44fe-8af7-9eeb62eedb4b',N'Zoe',2019,N'R110 ZE 40',41,3,N'type2',22,11.1,16.2,22,22,2,2.3,3.7,7.4,N'ccs',45,0,42,75,45,100,22,N'true',16.1),
    (17,******,******,N'Tesla',N'bev',N'f37896c3-6bc5-45e1-b442-b9cbc38e3a7c',N'Model 3',2019,N'SR+',50,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',149,0,130,52,149,60,110,N'false',15.3),
    (18,******,******,N'Tesla',N'bev',N'f37896c3-6bc5-45e1-b442-b9cbc38e3a7c',N'Model S',2020,N'85',76,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',140,0,125,43,140,80,37,N'false',19.1),
    (19,******,******,N'Tesla',N'bev',N'f37896c3-6bc5-45e1-b442-b9cbc38e3a7c',N'Model X',2019,N'Standard Range',75,3,N'type2',16.5,11.1,16.2,16.5,16.5,2,2.3,3.7,7.4,N'ccs',140,0,125,43,140,80,37,N'false',20),
    (20,******,******,N'Volkswagen',N'bev',N'481793f5-c8b0-4dc9-b3d4-cc615085ac07',N'e-up',2020,N'CCS',32.3,2,N'type2',7.2,7.2,7.2,7.2,7.2,2,2.3,3.7,7.2,N'ccs',34,0,32,27,34,80,14,N'false',16.6),
    (21,******,******,N'Volkswagen',N'bev',N'481793f5-c8b0-4dc9-b3d4-cc615085ac07',N'ID.3',2020,N'Standard Range',45,2,N'type2',7.2,7.2,7.2,7.2,7.2,2,2.3,3.7,7.2,N'ccs',50,0,47,75,50,100,7.2,N'true',16.4),
    (22,******,******,N'Volkswagen',N'phev',N'481793f5-c8b0-4dc9-b3d4-cc615085ac07',N'Passat GTE',2019,NULL,13.1,1,N'type2',3.7,3.7,3.7,3.7,3.7,2,2.3,3.7,3.7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16.2),
    (23,******,******,N'Porsche',N'bev',N'68e11a25-d316-4d22-9444-45c7306c8ab7',N'Taycan',2020,N'Turbo S',83.7,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',270,0,256,75,270,100,11,N'true',22.3),
    (24,******,******,N'Porsche',N'bev',N'68e11a25-d316-4d22-9444-45c7306c8ab7',N'Taycan',2020,N'4S',71,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',225,0,213,75,225,100,11,N'true',19.5),
    (25,******,******,N'Porsche',N'bev',N'68e11a25-d316-4d22-9444-45c7306c8ab7',N'Taycan',2020,N'4S Plus',83.7,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',270,0,256,75,270,100,11,N'true',19.7),
    (26,******,******,N'Porsche',N'bev',N'68e11a25-d316-4d22-9444-45c7306c8ab7',N'Taycan',2020,N'Turbo ',83.7,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',270,0,256,75,270,100,11,N'true',21.5),
    (27,******,******,N'MG',N'bev',N'5663b87a-d940-4bab-9846-d74c8c0ae260',N'ZS EV',2020,NULL,44.5,1,N'type2',6.6,3.7,5.4,6.6,6.6,2,2.3,3.7,6.6,N'ccs',55,0,52,75,55,100,6.6,N'true',19.8),
    (28,******,******,N'Maxus',N'bev',N'171a1e6d-8cbc-41a9-a8bb-e05b7ee98889',N'EV80',2018,NULL,56,2,N'type2',6.6,6.6,6.6,6.6,6.6,2,2.3,3.7,6.6,N'ccs',28,0,26,75,28,100,6.6,N'true',35),
    (29,******,******,N'Volvo',N'phev',N'2e55ea02-c829-4256-94fd-ffc971a1dd8e',N'XC 60 T8',2018,NULL,10.4,1,N'type2',3.7,3.7,3.7,3.7,3.7,2,2.3,3.7,3.7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,24.5),
    (30,******,******,N'Ford',N'phev',N'6cf9e9b6-28aa-44c7-b6c3-438d518ac12f',N'Kuga',2020,N'PHEV',14.4,1,N'type2',3.7,3.7,3.7,3.7,3.7,2,2.3,3.7,3.7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,19),
    (31,******,******,N'Mazda',N'bev',N'9b829849-1219-48b8-964e-90ddc1a4fa85',N'MX-30',2020,NULL,32,1,N'type2',6.6,3.7,5.4,6.6,6.6,2,2.3,3.7,6.6,N'ccs',50,0,47,75,50,100,6.6,N'true',17.8),
    (32,******,******,N'Mercedes Benz',N'phev',N'b2282fbe-f5d9-48d9-943f-a9b66ec51423',N'A 250 e',2020,N'7,4 kW-AC',10.7,2,N'type2',7.4,7.4,7.4,7.4,7.4,2,2.3,3.7,7.4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,15),
    (33,******,******,N'Kia',N'phev',N'3337d5f0-39de-4ded-831b-843dfec1ebbd',N'Ceed SW',2020,N'PHEV',8.9,1,N'type2',3.3,3.3,3.3,3.3,3.3,2,2.3,3.3,3.3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,11.3),
    (34,******,******,N'Kia',N'phev',N'3337d5f0-39de-4ded-831b-843dfec1ebbd',N'XCeed',2020,N'PHEV',8.9,1,N'type2',3.3,3.3,3.3,3.3,3.3,2,2.3,3.3,3.3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,11.3),
    (35,******,******,N'Kia',N'phev',N'3337d5f0-39de-4ded-831b-843dfec1ebbd',N'Niro',2020,N'PHEV',8.9,1,N'type2',3.3,3.3,3.3,3.3,3.3,2,2.3,3.3,3.3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9.8),
    (36,******,******,N'Mercedes Benz',N'phev',N'b2282fbe-f5d9-48d9-943f-a9b66ec51423',N'GLC 300 de 4MATIC',2020,N'PHEV',13.5,1,N'type2',7.4,3.7,5.4,7.4,7.4,2,2.3,3.7,7.4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,18.2),
    (37,******,******,N'Mercedes Benz',N'phev',N'b2282fbe-f5d9-48d9-943f-a9b66ec51423',N'GLE',2020,N'350 de/e',31.2,1,N'type2',7.4,3.7,5.4,7.4,7.4,2,2.3,3.7,7.4,N'ccs',60,0,57,75,60,100,7.4,N'true',31.2);
