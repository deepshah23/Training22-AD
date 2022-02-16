
-- View:
--    Temparary table
 --   Virtual table lost when lost connection
--    What you want to see from data emp->employee data
--    part of the table not complete data
    
    
--    Window1 House which opens in garden view -> Garden
--    Window2 House with opens in montain view -> Mountains
--    Window3 House with opens in river view -> river
--    Window4 -> garden river mountains view
    
    
--    Table=> What to share with the user based on roles
--    sysdba=>all access all privilages on every object oracle instance
--    dba =>access to role specific objects and privilages on oracle instance
--    user =>grant permission on the userole you can access objects on the oracle instance
--    Like in case of user based on roles we have privilages on objecs in oracle instance
--    same way we can create different windows/Views on tables for sharing the differnt informations
--    from single or multiple underline tables.
--    Some Windows to be created on Tables so that we will share only the information
 /*   required.
    Windows are nothing but VIRTUAL TABLE (View (Virtual Table)) which represents
    Projection + Restrictions on specific underline tables
    a. View can be created on single table
    b. view can be created on multiple table
     like 18
*/

--########################################################################
-- Display the employee details (empno,ename,dname,job,sal,location).
-- emp (empno,ename,job,sal)
-- dept(dname)
-- branch(location)
--########################################################################
SELECT
e.empno,e.ename,e.job,e.sal,d.dname,b.location
FROM
emp e join dept d
on
e.deptno=d.deptno
join branch b
on b.branchno=d.branchno
Order by d.deptno;


--########################################################################
-- View
--########################################################################
CREATE VIEW vw_empdetails
AS
SELECT
e.empno,e.ename,e.job,e.sal,d.dname,b.location
FROM
emp e join dept d
on
e.deptno=d.deptno
join branch b
on b.branchno=d.branchno
Order by d.deptno;


--VW_EMPDETAILS CREATED 
-- like 4


SELECT * FROM VW_EMPDETAILS



SELECT
DEPTNO,EMPNO,ENAME,JOB,SAL,COMM
FROM
EMP
ORDER BY DEPTNO,EMPNO;








-- get employees in first 5 rows
-- 1 getting empdetails(deptno,empno,ename,job,sal) sorted on deptno,sal
SELECT
deptno,empno,ename,job,sal
FROM
emp
ORDER BY deptno,sal;
-- 2. create an inline view to show first 5 records
-- getting top 5 records based on sal in desceding order
SELECT
*
FROM
( SELECT
deptno,empno,ename,job,sal
FROM
emp
ORDER BY sal desc
)
WHERE
ROWNUM <= 5;


-- branch(branchname), dept(dname)
-- Using Lateral keyword on inline view
SELECT
DNAME,
BRANCHNAME
From
dept d,
Lateral( select * from branch b where b.branchno=d.branchno)
order by
dname;






#### 7-FEB-22
AGENDA:
1. vIEW
--########################################################################
-- Display the employee details (empno,ename,dname,job,sal,location).
--	emp (empno,ename,job,sal)
--	dept(dname)
--	branch(location)
--########################################################################
SELECT
    e.empno,e.ename,e.job,e.sal,d.dname,b.location
FROM
    emp e join dept d 
    on
        e.deptno=d.deptno
    join branch b
        on b.branchno=d.branchno
    Order by d.deptno;
    
 
--########################################################################
-- View
--########################################################################
CREATE VIEW vw_empdetails 
AS 
    SELECT
        e.empno,e.ename,e.job,e.sal,d.dname,b.location
    FROM
        emp e join dept d 
        on
            e.deptno=d.deptno
        join branch b
            on b.branchno=d.branchno
        Order by d.deptno;    

SELECT     *     FROM        vw_empdetails;
SELECT     *     FROM        vw_empdetails where dname='ACCOUNTING';
SELECT empno,ename,dname from vw_empdetails;
SELECT empno,ename,dname from vw_empdetails where dname='ACCOUNTING';


--########################################################################
-- VIEW IS CREATED ON SINGLE TABLE 
-- WE CAN USE DML OPERATION ON IT SUCH AS INSERT/UPDAE/DELETE
-- INCASE OF INSERT MUST HANDLE THE NULL/NOT NULL VALUES
--########################################################################
-- DISPLAY EMPNO,ENAME,JOB,SAL,COMM,DEPTNO FOR AN EMPLOYEE
-- DEPARTMENT WISE EMPLOYEE COMPLETE DETAILS RELATED TO JOB,SAL COMM ALONG WITH 
-- EMPNO AND ENAME
SELECT 
    DEPTNO,EMPNO,ENAME,J OB,SAL,COMM
    FROM
        EMP
    ORDER BY DEPTNO,EMPNO;
    
CREATE VIEW vw_dept_wise_emp_details
(DEPTNO,EMPNO,ENAME,JOB,SAL,COMM)
AS
SELECT 
    DEPTNO,EMPNO,ENAME,JOB,SAL,COMM
    FROM
        EMP
    ORDER BY DEPTNO,EMPNO;

SELECT * FROM VW_DEPT_WISE_EMP_DETAILS;
SELECT * FROM VW_DEPT_WISE_EMP_DETAILS WHERE DEPTNO=30;
SELECT * FROM VW_DEPT_WISE_EMP_DETAILS WHERE DEPTNO=10;
UPDATE vw_dept_wise_emp_details
    SET COMM=0
    WHERE DEPTNO=10;

SELECT * FROM VW_DEPT_WISE_EMP_DETAILS WHERE DEPTNO=10;

INSERT INTO VW_DEPT_WISE_EMP_DETAILS VALUES(10,2345,'JASMIN','CLERK',1300,0);

