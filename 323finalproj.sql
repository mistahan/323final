/*TABLES TO AND CONSTRAINTS FOR THE DATAT BASE*/


/* NOTES
 *   ORDERLINE TO MECHANIC RELATION IS GOIING TO BE INTERESTING TO DEAL WITH 
 *
 *   do we want to carry the cus id all the way down as far as the order line?
 *   
 *   MAITNENCE package ????? issues DOES IT REQUIRE A MANY TO MANY OF EACH ITEM 
 =
 *   
 */
CREATE TABLE customers (
    cusID       INTEGER         NOT NULL,
    Name        VARCHAR(20)     NOT NULL,
    PHONE       VARCHAR(12)     NOT NULL,
    email       VARCHAR(40)     NOT NULL,
    
    CONSTRAINT pk_customers PRIMARY KEY (cusID) 
);

CREATE TABLE existingCustomer(
    cusID       INTEGER     NOT NULL,
    dateVisit   DATE        NOT NULL,
    timeVisit   TIME        NOT NULL,
    CONSTRAINT pk_existing   PRIMARY KEY (cusID),
    CONSTRAINT excus_cus_fk  FOREIGN KEY (cusID) REFERENCES customers (cusID)  
);


CREATE TABLE prospective(
    cusID       INTEGER       NOT NULL,
    status      VARCHAR(20),
    CONSTRAINT pk_prospective   PRIMARY KEY (cusID),
    CONSTRAINT prosp_cus_fk  FOREIGN KEY (cusID) REFERENCES customers (cusID)
);


CREATE TABLE special(
    specialItem     VARCHAR(20)    NOT NULL,
    EXPERATIONDATE  DATE           NOT NULL,
    CONSTRAINT pk_special PRIMARY KEY (specialItem, EXPERATIONDATE)
);


CREATE TABLE specialInstance(
    cusID              INTEGER       NOT NULL,
    lastDateContacted  DATE          NOT NULL,
    specialItem        VARCHAR(20)   NOT NULL,
    EXPERATIONDATE     DATE          NOT NULL,
    CONSTRAINT prosp_SI_fk FOREIGN KEY (cusID) REFERENCES prospective (cusID),
    CONSTRAINT special_SI_fk FOREIGN KEY (specialItem, EXPERATIONDATE) 
        REFERENCES special (specialItem, EXPERATIONDATE)
);

CREATE TABLE referal(
    cusID      INTEGER    NOT NULL,
    prosID     INTEGER    NOT NULL,
    dateSent   DATE       NOT NULL,
    status     VARCHAR(20)        ,
    CONSTRAINT pk_referal   PRIMARY KEY (cusID, dateSent, prosID),
    CONSTRAINT ref_excus_fk FOREIGN KEY (cusID) REFERENCES existingCustomer (cusID),
    CONSTRAINT ref_pros_fk  FOREIGN KEY (prosID) REFERENCES PROSPECTIVE (cusID)
  
);

CREATE TABLE steady(
    cusID       INTEGER         NOT NULL,
    visitFreq   VARCHAR(10)     NOT NULL,
    loyalpoint  INTEGER,
    CONSTRAINT pk_steady   PRIMARY KEY (cusID),
    CONSTRAINT steady_ecus_fk  FOREIGN KEY (cusID) REFERENCES existingCustomer (cusID)
);

CREATE TABLE premier(
    cusID       INTEGER    NOT NULL,
    anualFee    DOUBLE     NOT NULL,
    CONSTRAINT pk_premeir   PRIMARY KEY (cusID),
    CONSTRAINT premier_ecus_fk  FOREIGN KEY (cusID) REFERENCES existingCustomer (cusID)
);


CREATE TABLE corporation(
    address      VARCHAR(40)  NOT NULL,
    typeofAdd    VARCHAR(10)  NOT NULL,
    cusID        INTEGER      NOT NULL,
    CONSTRAINT pk_CORPORATION   PRIMARY KEY (cusID),
    CONSTRAINT corp_cus_fk  FOREIGN KEY (cusID) REFERENCES customers (cusID)  
);

CREATE TABLE individual(
    cusID       INTEGER       NOT NULL,
    mailingAdd  VARCHAR(40)   NOT NULL,
    CONSTRAINT pk_individual   PRIMARY KEY (cusID),
    CONSTRAINT indi_cus_fk  FOREIGN KEY (cusID) REFERENCES customers (cusID)  
);


CREATE TABLE appointment(
    cusID       INTEGER       NOT NULL,
    dateSche    DATE          NOT NULL,
    CONSTRAINT pk_appointment PRIMARY KEY (cusID, dateSche),
    CONSTRAINT app_steady_fk  FOREIGN KEY (cusID) REFERENCES steady (cusID) 
);


CREATE TABLE VEHICLE(
    cusID       INTEGER       NOT NULL,
    VIN         INTEGER       NOT NULL,
    make        VARCHAR(10)   NOT NUll,
    model       VARCHAR(10)   NOT NULL,
    modYear     INTEGER       NOT NULL,
    milage      INTEGER       NOT NULL,
    CONSTRAINT pk_vehicle PRIMARY KEY (VIN),
    CONSTRAINT veh_cus_fk FOREIGN KEY (cusID )REFERENCES customers (cusID)
);


CREATE TABLE orders(
    VIN         INTEGER       NOT NULL,
    empID       INTEGER       NOT NULL,
    orderDate   DATE          NOT NULL,
    CONSTRAINT pk_orders PRIMARY KEY (VIN, orderDate),
    CONSTRAINT  orders_vehivle_fk FOREIGN KEY(VIN) REFERENCES vehicle (VIN),
    CONSTRAINT  orders_tech_fk FOREIGN KEY(empID) REFERENCES technician (empID)
);


CREATE TABLE notification(
    cusID       INTEGER       NOT NULL,
    VIN         INTEGER       NOT NULL,
    dateSent    DATE          NOT NULL,
    CONSTRAINT not_veh_fk FOREIGN KEY (VIN) REFERENCES VEHICLE
);


CREATE TABLE orderLine(
    namItem     VARCHAR(15)   NOT NULL,
    VIN         INTEGER       NOT NULL,
    orderDate   DATE          NOT NULL,
    numRepItem  INTEGER               ,
    CONSTRAINT oLine_order_fk FOREIGN KEY (VIN,orderDate) REFERENCES ORDERS (VIN, ORDERDATE),
    CONSTRAINT oLine_repair_fk FOREIGN KEY (namItem) REFERENCES repairItems (namItem)
);


CREATE TABLE repairItems(
    namItem       VARCHAR(15)   NOT NULL,
    pricePerItem  DOUBLE                ,
    manufacture   VARCHAR(20)           ,
    CONSTRAINT pk_repairItems PRIMARY KEY (namItem)
);


CREATE TABLE employee(
    empID       INTEGER         NOT NULL,
    FName       VARCHAR(20)     NOT NULL,
    lname       VARCHAR(20)     NOT NULL, 
    PHONE       VARCHAR(12)     NOT NULL,
    email       VARCHAR(40)     NOT NULL,
    address     VARCHAR(40)     NOT NULL,
    dateHire    DATE            NOT NULL,
    dateEnd     DATE            NOT NULL,
    CONSTRAINT pk_employee PRIMARY KEY (empID)
);

CREATE TABLE technician(
    empID       INTEGER         NOT NULL,
    status      VARCHAR(10)             ,
    CONSTRAINT pk_technician PRIMARY KEY (EMPID),
    CONSTRAINT tech_emp_fk FOREIGN KEY (EMPID) REFERENCES employee(empID)
);
    
CREATE TABLE mechanic(
    empID       INTEGER         NOT NULL,
    CONSTRAINT pk_mechanic PRIMARY KEY (empID),
    CONSTRAINT mech_emp_fk FOREIGN KEY (EMPID) REFERENCES employee(empID)
);
CREATE TABLE mentorship(
    empID       INTEGER         NOT NULL,
    mentorID    INTEGER         NOT NULL,
    startDate   DATE            NOT NULL,
    endDate     DATE            NOT NULL,
    skillMent   VARCHAR(20)     NOT NULL,
    CONSTRAINT  pk_mentorship   PRIMARY KEY (empID, MentorID),
    CONSTRAINT  ment_mech_fk    FOREIGN KEY (empID) REFERENCES mechanic
);


CREATE TABLE skillMechanic(
    empID       INTEGER         NOT NULL,
    skillID     INTEGER         NOT NULL,
    dateLearn   DATE                    ,
    CONSTRAINT skillmech_skill_fk FOREIGN KEY (skillID) REFERENCES SKILL, 
    CONSTRAINT skillmech_mech_fk  FOREIGN KEY (empID)   REFERENCES mechanic
);


CREATE TABLE skill(
    skillID     INTEGER         NOT NULL,
    skillName   VARCHAR(30)     NOT NULL,
    CONSTRAINT  pk_skill  PRIMARY KEY (skillID) 
);

CREATE TABLE skillRepair(
    skillID     INTEGER         NOT NULL,
    namItem     VARCHAR(15)     NOT NULL,
    CONSTRAINT skillrep_repair_fk FOREIGN KEY (namItem) REFERENCES repairItems (namItem),
    CONSTRAINT skillrep_skill_fk  FOREIGN KEY (skillID) REFERENCES skill (skillID)
);

CREATE TABLE CERTIFICATION (
    empID          INTEGER         NOT NULL,
    FName          VARCHAR(20)     NOT NULL,
    lname          VARCHAR(20)     NOT NULL,
    dateRecived    DATE            NOT NULL,
    expireDate     DATE            NOT NULL,
    CONSTRAINT  cert_mech_fk    FOREIGN KEY (empID) REFERENCES mechanic
);
CREATE TABLE maitenancePack(
    packageID    INTEGER          NOT NULL,
    packageName  VARCHAR(20)      NOT NULL,
    numOfItems   INTEGER          NOT NULL,
    CONSTRAINT  PK_MAITNENCEPACK PRIMARY KEY (packageID)
);
    
    

CREATE TABLE repairInstance(
    price        DOUBLE           NOT NULL,
    namItem      VARCHAR(15)      NOT NUlL,
    packageID    INTEGER          NOT NULL,
    CONSTRAINT repInst_repItem_fk FOREIGN KEY (namItem) REFERENCES repairItems,
    CONSTRAINT repInst_maitnence_fk FOREIGN KEY (packageID) REFERENCES maitenancePack
);

/*

/*INSERT VALUES FOR DATA*/
INSERT INTO CUSTOMERS VALUES(001,'Alex Han', '714-444-3211', 'han@alex.com');
INSERT INTO CUSTOMERS VALUES(002,'blex Han', '714-628-2619', 'han@blex.com');
INSERT INTO CUSTOMERS VALUES(003,'Tyren Han', '714-996-3321', 'han@tyren.com');
INSERT INTO CUSTOMERS VALUES(004,'Brian Han', '714-831-3211', 'han@brian.com');
INSERT INTO CUSTOMERS VALUES(005,'Alex Riddle', '714-210-5515', 'riddle@alex.com');
INSERT INTO CUSTOMERS VALUES(006,'CARS CORP', '562-444-9880', 'employee@cars.corp');

INSERT INTO INDIVIDUAL VALUES(001,'1312 Travel lane');
INSERT INTO INDIVIDUAL VALUES(002,'906 sycamore street lane');
INSERT INTO INDIVIDUAL VALUES(003,'132 BIG WORM ave');
INSERT INTO INDIVIDUAL VALUES(004,'4456 crenshaw blvd');
INSERT INTO INDIVIDUAL VALUES(005,'2368 Crippling Dr');

INSERT INTO existingCustomer VALUES (001,'2016-12-03', '03:22:00');
INSERT INTO existingCustomer VALUES (002,'2015-06-05', '06:06:00');
INSERT INTO existingCustomer VALUES (003,'2001-07-12', '15:09:00');
INSERT INTO existingCustomer VALUES (004,'2013-01-20', '12:13:00');
INSERT INTO existingCustomer VALUES (006,'1999-11-25', '09:10:00');

INSERT INTO prospective VALUES (005,'emailed');

INSERT INTO SPECIAL VALUES ('50% OFF SERVICE','2016-12-31');
INSERT INTO SPECIAL VALUES ('50% OFF PACKAGE','2016-12-31');
INSERT INTO SPECIAL VALUES ('30% OFF AIR FILTER','2016-12-31');
INSERT INTO SPECIAL VALUES ('12345678901234567890','2016-12-31');

INSERT INTO specialInstance VALUES (006,'2016-04-12','30% OFF AIR FILTER','2016-12-31'); 
/*VEWIS*/

/*QUERRIES*/
SELECT * From customers;
SELECT * From INDIVIDUAL;
SELECT * From existingCustomer;
SELECT * From prospective;


/*

ALTER TABLE existingCustomer
    DROP CONSTRAINT excus_cus_fk;
ALTER TABLE prospective
    DROP CONSTRAINT prosp_cus_fk;
ALTER TABLE specialInstance
    DROP CONSTRAINT prosp_SI_fk;
ALTER TABLE specialInstance
    DROP CONSTRAINT special_SI_fk;
ALTER TABLE referal
    DROP CONSTRAINT ref_excus_fk;
ALTER TABLE steady
    DROP CONSTRAINT steady_ecus_fk;
ALTER TABLE PREMIER
    DROP CONSTRAINT premier_ecus_fk;
ALTER TABLE corporation
    DROP CONSTRAINT corp_cus_fk;
ALTER TABle individual
    DROP CONSTRAINT indi_cus_fk;
ALTER TABLE APPOINTMENT
    DROP CONSTRAINT app_steady_fk;
ALTER TABLE VEHICLE
    DROP CONSTRAINT veh_cus_fk;
ALTER TABLE ORDERS
    DROP CONSTRAINT orders_vehivle_fk;
ALTER TABLE ORDERS
    DROP CONSTRAINT orders_tech_fk;
ALTER TABLE notification
    DROP CONSTRAINT not_veh_fk;
ALTER TABLE ORDERline
    DROP CONSTRAINTS oLine_order_fk, oLine_repair_fk;
--ALTER TABLE ORDERline
  --  DROP CONSTRAINT oLine_repair_fk;
ALTER TABLE technician
    DROP CONSTRAINT tech_emp_fk;
ALTER TABLE mechanic
    DROP CONSTRAINT mech_emp_fk;
ALTER TABLE skillMechanic
    DROP CONSTRAINT skillmech_skill_fk;
ALTER TABLE skillMechanic
    DROP CONSTRAINT skillmech_mech_fk;
ALTER TABLE CERTIFICATION
    DROP CONSTRAINT cert_mech_fk;

DROP Table Customers;
DROP Table existingCustomer;
DROP Table prospective;
DROP Table specialInstance;
DROP Table special;
DROP Table referal;
DROP TABLE STEADY;
DROP TABLE PREMIER;
DROP TABLE corporation;
DROP TABLE individual;
DROP TABLE APPOINTMENT;
DROP TABLE VEHICLE;
DROP TABLE ORDERS;
DROP TABLE notification;
DROP TABLE orderLine;
DROP TABLE repairItems;
DROP TABLE EMPLOYEE;
DROP TABLE technician;
DROP TABLE mechanic;
DROP TABLE mentorship;
DROP TABLE skillMechanic;
DROP TABLE SKILL;
DROP TABLE SKILLREPAIR;
DROP TABLE CERTIFICATION;

