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
    cusID        INTEGER      NOT NULL,
    CONSTRAINT pk_CORPORATION   PRIMARY KEY (cusID),
    CONSTRAINT corp_cus_fk  FOREIGN KEY (cusID) REFERENCES customers (cusID)  
);

CREATE TABLE ADDRESS(
    cusID        INTEGER      NOT NULL,
    address      VARCHAR(40)  NOT NULL,
    typeofAdd    VARCHAR(20)  NOT NULL,
    CONSTRAINT PK_address PRIMARY KEY (CUSID,ADDRESS),
    CONSTRAINT add_corp_fk FOREIGN KEY (CUSID) REFERENCES CORPORATION (CUSID)
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
    empID       INTEGER       NOT NULL,    
    orderID     INTEGER       NOT NULL,
    VIN         INTEGER       NOT NULL,
    orderDate   DATE          NOT NULL,
    CONSTRAINT pk_orders PRIMARY KEY (ORDERID),
    CONSTRAINT  orders_vehivle_fk FOREIGN KEY(VIN) REFERENCES vehicle (VIN),
    CONSTRAINT  orders_tech_fk FOREIGN KEY(empID) REFERENCES technician (empID)
);

CREATE TABLE notification(
    cusID       INTEGER       NOT NULL,
    VIN         INTEGER       NOT NULL,
    dateSent    DATE          NOT NULL,
    CONSTRAINT not_veh_fk FOREIGN KEY (VIN) REFERENCES VEHICLE (VIN),
    CONSTRAINT not_steady_fk FOREIGN KEY (CUSID) REFERENCES STEADY (CUSID)
);

CREATE TABLE orderLine(
    packageID   INTEGER       NOT NULL,
    orderID     INTEGER       NOT NULL,
    numRepItem  INTEGER       NOT NULL,
    CONSTRAINT oLine_order_fk FOREIGN KEY (orderID) REFERENCES ORDERS (orderID),
    CONSTRAINT oLine_repair_fk FOREIGN KEY (packageID) REFERENCES maitenancePack (packageID)
);

CREATE TABLE repairItems(
    namItem       VARCHAR(15)   NOT NULL,
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
    dateEnd     DATE                    ,
    CONSTRAINT pk_employee PRIMARY KEY (empID, fname, lname)
);

CREATE TABLE technician(
    empID       INTEGER         NOT NULL,
    FName       VARCHAR(20)     NOT NULL,
    lname       VARCHAR(20)     NOT NULL, 
    status      VARCHAR(10)             ,
    CONSTRAINT pk_technician PRIMARY KEY (EMPID),
    CONSTRAINT tech_emp_fk FOREIGN KEY (EMPID,FNAME,LNAME) REFERENCES employee(EMPID,FNAME,LNAME)
);
    
CREATE TABLE mechanic(
    empID       INTEGER         NOT NULL,
    FName       VARCHAR(20)     NOT NULL,
    lname       VARCHAR(20)     NOT NULL, 
    CONSTRAINT pk_mechanic PRIMARY KEY (empID),
    CONSTRAINT mech_emp_fk FOREIGN KEY (EMPID,FNAME,LNAME) REFERENCES employee(EMPID,FNAME,LNAME)
);

CREATE TABLE mentorship(
    empID       INTEGER         NOT NULL,
    mentorID    INTEGER         NOT NULL,
    startDate   DATE            NOT NULL,
    endDate     DATE            NOT NULL,
    skillMent   VARCHAR(20)     NOT NULL,
    CONSTRAINT  pk_mentorship   PRIMARY KEY (empID, MentorID),
    CONSTRAINT  ment_mech_fk    FOREIGN KEY (empID) REFERENCES mechanic (empID),
    CONSTRAINT  ment1_mech_fk   FOREIGN KEY (mentorID) REFERENCES MECHANIC (EMPID)
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
    packageID   INTEGER         NOT NULL,
    CONSTRAINT skillrep_repair_fk FOREIGN KEY (packageID) REFERENCES maitenancePack (packageID),
    CONSTRAINT skillrep_skill_fk  FOREIGN KEY (skillID) REFERENCES skill (skillID)
);

CREATE TABLE CERTIFICATION (
    empID          INTEGER         NOT NULL,
    dateRecived    DATE            NOT NULL,
    expireDate     DATE            NOT NULL,
    CONSTRAINT  cert_mech_fk    FOREIGN KEY (empID) REFERENCES mechanic
);

CREATE TABLE maitenancePack(
    packageID    INTEGER          NOT NULL,
    packageName  VARCHAR(20)      NOT NULL,
    numOfItems   INTEGER          NOT NULL,
    make         VARCHAR(10)      NOT NUll,
    model        VARCHAR(10)      NOT NULL,
    milage       INTEGER          NOT NULL,
    CONSTRAINT  PK_MAITNENCEPACK PRIMARY KEY (packageID)
);

CREATE TABLE repairInstance(
    price        DOUBLE           NOT NULL,
    namItem      VARCHAR(15)      NOT NUlL,
    packageID    INTEGER          NOT NULL,
    CONSTRAINT repInst_repItem_fk FOREIGN KEY (namItem) REFERENCES repairItems,
    CONSTRAINT repInst_maitnence_fk FOREIGN KEY (packageID) REFERENCES maitenancePack
);

