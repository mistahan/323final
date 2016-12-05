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
    CREATE VIEW Customer_v AS SELECT * From customers;
--2
    CREATE VIEW Customer_addresses_v AS SELECT * From customers;
--3
    CREATE VIEW Mechanic_mentor_v  AS SELECT * From customers;
--4
    CREATE VIEW Premier_profits_v  AS SELECT * From customers;
--5
    CREATE VIEW Prospective_resurrection_v  AS SELECT * From customers;

/*quierries*/
--1

--2

--3

--4

--5

--6

--7

--8

--9

--10

--11

--12

--13

--14

--15
SELECT empID, fname, lname from employee natural join technician natural join 
        mechanic;


/*team querries*/
--1

--2

--3

--4

