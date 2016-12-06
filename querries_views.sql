/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Alex Han
 * Created: Dec 4, 2016
 */


/*
SELECT * From customers;
SELECT * From INDIVIDUAL;
SELECT * From CORPORATION;
SELECT * From ADDRESS;
SELECT * From existingCustomer;
SELECT * From prospective;
SELECT * From SPECIAL;
SELECT * From specialInstance;
SELECT * FROM referal;
SELECT * FROM STEADY;
SELECT * FROM APPOINTMENT;
SELECT * FROM APPOINTMENT;
SELECT * FROM PREMIER;
SELECT * FROM VEHICLE;
SELECT * FROM notification;
SELECT * FROM EMPLOYEE;
SELECT * FROM technician;

SELECT * FROM CERTIFICATION;


SELECT * FROM orders;
SELECT * FROM repairItems;
SELECT * FROM OrderLine;

SELECT * FROM repairInstance;



/*views*/
SELECT * FROM skill;
SELECT * FROM maitenancePack;
SELECT * FROM MECHANIC;
SELECT * FROM skillMechanic;
SELECT * FROM SKILLREPAIR;

select mechanic.EMPID, skill.SKILLNAME  from mechanic
    natural join skillmechanic
    natural join skill
except
select  map.PACKAGEID, skill.SKILLNAME from maitenancePack map
    natural join skillRepair
    natural join skill;



-- these views are wrong just creating them to see how they work 
-- we will need to adjust them in the future

--1

--2

--3
    CREATE VIEW Mechanic_mentor_v  AS 
        SELECT E.FNAME as"fmento", E.lName AS "mento",M.FNAME AS "fmente",
        M.lName AS "mente"
        FROM mechanic E LEFT OUTER JOIN 
          (mentorship S INNER JOIN mechanic M 
            ON S.mentorID = M.empID)
          ON E.empID = S.empID
        ORDER BY E.lName;
--4

   
--5
  
--=======================================================================================================
--=======================================================================================================
/*quierries*/
--1
SELECT Name, phone, email, mailingAdd AS "ADDRESS",'Home' AS "Type of Address", 'Individual' AS "Type of Customer"  FROM customers NATURAL JOIN individual
UNION
SELECT Name, phone, email, address AS "ADDRESS", typeOfAdd AS "Type of Address",'Corporation' AS "Type of Customer" FROM customers NATURAL JOIN corporation NATURAL JOIN ADDRESS;
--2
select customers."NAME", sum(repairInstance.PRICE) from customers
natural join (vehicle
natural join orders
natural join orderline
natural join repairItems
natural join repairInstance)
group by customers."NAME";
--3
SELECT   SUM(repI.PRICE), CUS."NAME" FROM CUSTOMERS CUS 
    NATURAL JOIN VEHICLE
    NATURAL JOIN ORDERS ord
    inner join orderline oli on(ord.ORDERID = oli.ORDERID)
    inner join maitenancePack map on(oli.PACKAGEID = map.PACKAGEID)
    inner join repairinstance repI on (map.PACKAGEID = repI.PACKAGEID)
    where ord.ORDERDATE between '2016-01-01' and '2016-12-31'
    group by CUS."NAME" order by CUS."NAME" desc FETCH FIRST 3 ROWS ONLY;
    
--4
SELECT DISTINCT fname, lname, COUNT(skillName)
From (employee NATURAL JOIN mechanic 
               NATURAL JOIN skillMechanic 
               NATURAL JOIN skill)
GROUP BY fname, lname
HAVING COUNT(skillName) > 2;

--5

--6
SELECT t1.packageName, "Price per Package",namItem,"Price per Item"
FROM(
(SELECT packageName, namItem, price AS "Price per Item"
FROM repairItems natural join (maitenancePack left outer join repairInstance using (packageID))) t1
LEFT OUTER JOIN
(SELECT packageName, SUM(price) AS "Price per Package" FROM ((maitenancePack left outer join repairInstance using (packageID)))
GROUP BY packageName) t2
ON t1.packageName = t2.packageName);

--7
select mechanic.EMPID, skill.SKILLNAME  from mechanic
    natural join skillmechanic
    natural join skill
except
select  map.PACKAGEID, skill.SKILLNAME from maitenancePack map
    natural join skillRepair
    natural join skill;
--8
select customers."NAME", steady.LOYALPOINT from steady
inner join customers
on steady.CUSID = customers.CUSID
order by loyalpoint DESC;

--9??

--10
select CUS."NAME", sum(repI.price) as "price" from customers CUS
    NATURAL JOIN VEHICLE
    NATURAL JOIN ORDERS ord
    inner join orderline oli on(ord.ORDERID = oli.ORDERID)
    inner join maitenancePack map on(oli.PACKAGEID = map.PACKAGEID)
    inner join repairinstance repI on (map.PACKAGEID = repI.PACKAGEID)
    where ord.ORDERDATE between '2016-01-01' and '2016-12-31'
    group by CUS."NAME" order by CUS."NAME" desc;
    
--11
SELECT rep.NAMITEM, ord.ORDERDATE, count(rep.NAMITEM) as "number" from orders ord 
    inner join orderline oli on(ord.ORDERID = oli.ORDERID)
    inner join maitenancePack map on(oli.PACKAGEID = map.PACKAGEID)
    inner join repairinstance repI on (map.PACKAGEID = repI.PACKAGEID)
    inner join repairitems rep on(repI.NAMITEM = rep.NAMITEM)
    where ord.ORDERDATE between '2016-01-01' and '2016-12-31'
    group by rep.NAMITEM, ord.ORDERDATE order by "number" DESC FETCH FIRST 3 ROWS ONLY;
--12
SELECT rep.NAMITEM, SUM(repI.PRICE) as "revenue"  FROM orders ord 
    inner join orderline oli on(ord.ORDERID = oli.ORDERID)
    inner join maitenancePack map on(oli.PACKAGEID = map.PACKAGEID)
    inner join repairinstance repI on (map.PACKAGEID = repI.PACKAGEID)
    inner join repairitems rep on(repI.NAMITEM = rep.NAMITEM)
    where ord.ORDERDATE between '2016-01-01' and '2016-12-31'
    group by rep.NAMITEM  order by "revenue" DESC FETCH FIRST 3 ROWS ONLY;


--13
select FNAME, LNAME,mentorship.SKILLMENT from (employee
natural join mechanic
natural join mentorship)
group by  FNAME, LNAME,mentorship.SKILLMENT;


--14
SELECT SKILL.SKILLNAME, COUNT(MECH.FNAME) AS "MECHS" FROM MECHANIC MECH
    INNER JOIN SKILLMECHANIC SKIM ON (MECH.EMPID = SKIM.EMPID)
    INNER JOIN SKILL ON (SKIM.SKILLID = SKILL.SKILLID)
    GROUP BY SKILL.SKILLNAME ORDER BY "MECHS" ASC FETCH FIRST 3 ROWS ONLY;

--15
SELECT empID, fname, lname from employee natural join technician natural join 
        mechanic;
--or
SELECT employee.EMPID, employee.fname, employee.lname from employee 
inner join technician
on employee.EMPID = technician.EMPID
inner join mechanic
on technician.EMPID = mechanic.EMPID;


/*team querries*/
--1
SELECT a."NAME" as "recipient", b."NAME" as "sender" FROM CUSTOMERS a
    NATURAL JOIN PROSPECTIVE pr
    inner join referal re on( pr.CUSID = re.PROSID)
    inner join  existingcustomer ex on(re.CUSID = ex.CUSID)
    inner join customers b on (ex.CUSID = b.CUSID)
    group by a."NAME",b."NAME";

--2
SELECT NAME, APPOINTMENT.DATESCHE AS "Appointment date" FROM CUSTOMERS 
    NATURAL JOIN EXISTINGCUSTOMER
    NATURAL JOIN STEADY
    NATURAL JOIN APPOINTMENT;
--3
SELECT  DISTINCT NAME, NOTIFICATION.DATESENT AS "Notified Date", VEHICLE.MAKE AS "Vehicle Make", VEHICLE.MODEL AS "VEHICLE MODEL" FROM CUSTOMERS
NATURAL JOIN EXISTINGCUSTOMER
NATURAL JOIN STEADY
NATURAL JOIN NOTIFICATION
 NATURAL JOIN VEHICLE;

--4

