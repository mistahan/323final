/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  Alex Han
 * Created: Dec 4, 2016
 */



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
SELECT * FROM MECHANIC;
SELECT * FROM CERTIFICATION;
SELECT * FROM skill;
SELECT * FROM skillMechanic;
SELECT * FROM orders;
SELECT * FROM repairItems;
SELECT * FROM OrderLine;
SELECT * FROM maitenancePack;
SELECT * FROM repairInstance;
SELECT * FROM SKILLREPAIR;


/*views*/

-- these views are wrong just creating them to see how they work 
-- we will need to adjust them in the future

--1
    Select existingCustomer.CUSID, customers."NAME",customers.PHONE,customers.EMAIL From existingCustomer
INNER JOIN customers
On customers.cusID = existingCustomer.CUSID;
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
    CREATE VIEW Prospective_resurrection_v  AS SELECT * From customers;

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

--8
select customers."NAME", steady.LOYALPOINT from steady
inner join customers
on steady.CUSID = customers.CUSID
order by loyalpoint DESC;

--9

--10

--11

--12

--13

--14

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

--2

--3

--4

