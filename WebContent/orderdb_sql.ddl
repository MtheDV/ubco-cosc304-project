DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);


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


CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    customerId          INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (customerId, productId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);


INSERT INTO product VALUES
    (85600.00,'img/1.jpg',N'Audi',N'bev',N'89c2668c-0c50-4344-9386-93e4000f7673',N'e-tron 55',2019,N'22kW-AC',86.5,3,N'type2',22,11.1,16.2,22,22,2,2.3,3.7,7.4,N'ccs',155,0,137,70,155,72,150,N'false',23.4),
    (74000.00,'img/2.jpg',N'Audi',N'bev',N'89c2668c-0c50-4344-9386-93e4000f7673',N'e-tron 50',2019,N'22kW-AC',65,3,N'type2',22,11.1,16.2,22,22,2,2.3,3.7,7.4,N'ccs',125,0,118,75,125,100,22,N'true',22.7),
    (40475.00,'img/3.jpg',N'Audi',N'phev',N'89c2668c-0c50-4344-9386-93e4000f7673',N'A3 Sportback 40 e-tron',2020,NULL,8.8,1,N'type2',3.7,3.7,3.7,3.7,3.7,2,2.3,3.7,3.7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,12.4),
    (74900.00,'img/4.jpg',N'BMW',N'phev',N'0742668c-bf59-4191-890e-2b0883508808',N'X5',2020,N'PHEV',21,1,N'type2',3.7,3.7,3.7,3.7,3.7,2,2.3,3.7,3.7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,21.3),
    (33210.00,'img/5.jpg',N'Fiat',N'bev',N'3291e5ba-862c-49fa-8437-71105743875e',N'500e',2020,NULL,42,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',85,0,80,75,85,100,11,N'true',16.8),
    (31998.00,'img/6.jpg',N'Ford',N'bev',N'6cf9e9b6-28aa-44c7-b6c3-438d518ac12f',N'Focus electric',2017,NULL,33.5,1,N'type2',6.6,3.7,5.4,6.6,6.6,2,2.3,3.7,6.6,N'ccs',50,0,47,75,50,100,6.6,N'true',16.4),
    (41499.00,'img/7.jpg',N'Hyundai',N'bev',N'9771afb8-9e25-4ae6-a5b3-b2a5b9f363f0',N'Ioniq',2019,NULL,38.3,1,N'type2',7.2,3.7,5.4,7.2,7.2,2,2.3,3.7,7.2,N'ccs',47,0,44,75,47,100,7.2,N'true',15.3),
    (44998.00,'img/8.jpg',N'Hyundai',N'bev',N'9771afb8-9e25-4ae6-a5b3-b2a5b9f363f0',N'Kona',2020,N'64 kWh',64,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',77,0,70,40,77,42,70,N'false',15.8),
    (21195.00,'img/9.jpg',N'Kia',N'bev',N'3337d5f0-39de-4ded-831b-843dfec1ebbd',N'Soul',2019,N'30 kWh',30,1,N'type2',6.6,3.7,5.4,6.6,6.6,2,2.3,3.7,6.6,N'chademo',50,0,47,75,50,100,6.6,N'true',17.6),
    (39090.00,'img/10.jpg',N'Kia',N'bev',N'3337d5f0-39de-4ded-831b-843dfec1ebbd',N'e-Niro',2020,N'64 kWh',64,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',77,0,70,40,77,42,70,N'false',17.3),
    (42895.00,'img/11.jpg',N'Kia',N'bev',N'3337d5f0-39de-4ded-831b-843dfec1ebbd',N'e-Soul',2020,N'64 kWh 11 kW-AC',64,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',77,0,73,75,77,100,11,N'true',17.5),
    (68895.00,'img/12.jpg',N'Mercedes Benz',N'bev',N'b2282fbe-f5d9-48d9-943f-a9b66ec51423',N'EQC',2019,NULL,80,2,N'type2',7.4,7.4,7.4,7.4,7.4,2,2.3,3.7,7.4,N'ccs',125,0,105,39,125,70,87,N'false',21.6),
    (43998.00,'img/13.jpg',N'Mitsubishi',N'phev',N'3cf8cf51-60ac-4cac-9f25-131c21eda12e',N'Outlander PHEV',2018,NULL,11,1,N'type1',3.7,3.7,3.7,3.7,3.7,2,2.3,3.7,3.7,N'chademo',22,0,20,75,22,100,3.7,N'true',15.2),
    (45670.00,'img/14.jpg',N'Nissan',N'bev',N'dab5a47a-e8ce-4d34-9139-0701499205b1',N'e-NV 200',2020,N'24 kWh',24,1,N'type1',3.6,3.6,3.6,3.6,3.6,2,2.3,3.6,3.6,N'chademo',46,0,43,75,46,100,3.6,N'true',20),
    (41898.00,'img/15.jpg',N'Nissan',N'bev',N'dab5a47a-e8ce-4d34-9139-0701499205b1',N'Leaf',2019,N'e+ 62 kWh',62,1,N'type2',6.6,3.7,5.4,6.6,6.6,2,2.3,3.7,6.6,N'chademo',100,0,95,75,100,100,6.6,N'true',17.2),
    (27250.00,'img/16.jpg',N'Renault',N'bev',N'c0d8a60c-34b8-44fe-8af7-9eeb62eedb4b',N'Zoe',2019,N'R110 ZE 40',41,3,N'type2',22,11.1,16.2,22,22,2,2.3,3.7,7.4,N'ccs',45,0,42,75,45,100,22,N'true',16.1),
    (51600.00,'img/17.jpg',N'Tesla',N'bev',N'f37896c3-6bc5-45e1-b442-b9cbc38e3a7c',N'Model 3',2019,N'SR+',50,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',149,0,130,52,149,60,110,N'false',15.3),
    (100600.00,'img/18.jpg',N'Tesla',N'bev',N'f37896c3-6bc5-45e1-b442-b9cbc38e3a7c',N'Model S',2020,N'85',76,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',140,0,125,43,140,80,37,N'false',19.1),
    (111600.00,'img/19.jpg',N'Tesla',N'bev',N'f37896c3-6bc5-45e1-b442-b9cbc38e3a7c',N'Model X',2019,N'Standard Range',75,3,N'type2',16.5,11.1,16.2,16.5,16.5,2,2.3,3.7,7.4,N'ccs',140,0,125,43,140,80,37,N'false',20),
    (45000.00,'img/20.jpg',N'Volkswagen',N'bev',N'481793f5-c8b0-4dc9-b3d4-cc615085ac07',N'e-up',2020,N'CCS',32.3,2,N'type2',7.2,7.2,7.2,7.2,7.2,2,2.3,3.7,7.2,N'ccs',34,0,32,27,34,80,14,N'false',16.6),
    (46998.00,'img/21.jpg',N'Volkswagen',N'bev',N'481793f5-c8b0-4dc9-b3d4-cc615085ac07',N'ID.3',2020,N'Standard Range',45,2,N'type2',7.2,7.2,7.2,7.2,7.2,2,2.3,3.7,7.2,N'ccs',50,0,47,75,50,100,7.2,N'true',16.4),
    (62926.00,'img/22.jpg',N'Volkswagen',N'phev',N'481793f5-c8b0-4dc9-b3d4-cc615085ac07',N'Passat GTE',2019,NULL,13.1,1,N'type2',3.7,3.7,3.7,3.7,3.7,2,2.3,3.7,3.7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16.2),
    (119400.00,'img/23.jpg',N'Porsche',N'bev',N'68e11a25-d316-4d22-9444-45c7306c8ab7',N'Taycan',2020,N'4S',71,3,N'type2',11,11,11,11,11,2,2.3,3.7,7.4,N'ccs',225,0,213,75,225,100,11,N'true',19.5),
    (43990.00,'img/24.jpg',N'MG',N'bev',N'5663b87a-d940-4bab-9846-d74c8c0ae260',N'ZS EV',2020,NULL,44.5,1,N'type2',6.6,3.7,5.4,6.6,6.6,2,2.3,3.7,6.6,N'ccs',55,0,52,75,55,100,6.6,N'true',19.8),
    (74400.00,'img/25.jpg',N'Maxus',N'bev',N'171a1e6d-8cbc-41a9-a8bb-e05b7ee98889',N'EV80',2018,NULL,56,2,N'type2',6.6,6.6,6.6,6.6,6.6,2,2.3,3.7,6.6,N'ccs',28,0,26,75,28,100,6.6,N'true',35),
    (72200.00,'img/26.jpg',N'Volvo',N'phev',N'2e55ea02-c829-4256-94fd-ffc971a1dd8e',N'XC60 T8',2018,NULL,10.4,1,N'type2',3.7,3.7,3.7,3.7,3.7,2,2.3,3.7,3.7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,24.5),
    (41500.00,'img/27.jpg',N'Ford',N'phev',N'6cf9e9b6-28aa-44c7-b6c3-438d518ac12f',N'Kuga',2020,N'PHEV',14.4,1,N'type2',3.7,3.7,3.7,3.7,3.7,2,2.3,3.7,3.7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,19),
    (38000.00,'img/28.jpg',N'Mazda',N'bev',N'9b829849-1219-48b8-964e-90ddc1a4fa85',N'MX-30',2020,NULL,32,1,N'type2',6.6,3.7,5.4,6.6,6.6,2,2.3,3.7,6.6,N'ccs',50,0,47,75,50,100,6.6,N'true',17.8),
    (38300.00,'img/29.jpg',N'Mercedes Benz',N'phev',N'b2282fbe-f5d9-48d9-943f-a9b66ec51423',N'A 250 e',2020,N'7,4 kW-AC',10.7,2,N'type2',7.4,7.4,7.4,7.4,7.4,2,2.3,3.7,7.4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,15),
    (52825.00,'img/30.jpg',N'Kia',N'phev',N'3337d5f0-39de-4ded-831b-843dfec1ebbd',N'Ceed SW',2020,N'PHEV',8.9,1,N'type2',3.3,3.3,3.3,3.3,3.3,2,2.3,3.3,3.3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,11.3),
    (35900.00,'img/31.jpg',N'Kia',N'phev',N'3337d5f0-39de-4ded-831b-843dfec1ebbd',N'XCeed',2020,N'PHEV',8.9,1,N'type2',3.3,3.3,3.3,3.3,3.3,2,2.3,3.3,3.3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,11.3),
    (26845.00,'img/32.jpg',N'Kia',N'phev',N'3337d5f0-39de-4ded-831b-843dfec1ebbd',N'Niro',2020,N'PHEV',8.9,1,N'type2',3.3,3.3,3.3,3.3,3.3,2,2.3,3.3,3.3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9.8),
    (49900.00,'img/33.jpg',N'Mercedes Benz',N'phev',N'b2282fbe-f5d9-48d9-943f-a9b66ec51423',N'GLC 300 de 4MATIC',2020,N'PHEV',13.5,1,N'type2',7.4,3.7,5.4,7.4,7.4,2,2.3,3.7,7.4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,18.2),
    (69900.00,'img/34.jpg',N'Mercedes Benz',N'phev',N'b2282fbe-f5d9-48d9-943f-a9b66ec51423',N'GLE',2020,N'350 de/e',31.2,1,N'type2',7.4,3.7,5.4,7.4,7.4,2,2.3,3.7,7.4,N'ccs',60,0,57,75,60,100,7.4,N'true',31.2);


INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO warehouse(warehouseName) VALUES ('Second warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity) VALUES (1, 2, 2);
INSERT INTO productInventory(productId, warehouseId, quantity) VALUES (2, 2, 2);
INSERT INTO productInventory(productId, warehouseId, quantity) VALUES (3, 2, 2);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);