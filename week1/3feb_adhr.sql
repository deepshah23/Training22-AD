#### 03-Feb-02
--Agenda
--1. Decode
--2. Subqueries
--3. copying the data to tables 
-- ################################################################
-- Function called DECODE
-- ################################################################
CREATE TABLE COLOR(
ID INT,
COLORCODE VARCHAR2(7)
);

INSERT INTO COLOR VALUES(1,'#FF0000');
INSERT INTO COLOR VALUES(2,'#00FF00');
INSERT INTO COLOR VALUES(3,'#0000FF');
INSERT INTO COLOR VALUES(4,NULL);

SELECT ID,COLORCODE FROM COLOR;

SELECT
    ID,COLORCODE,
    DECODE(COLORCODE,
    '#FF0000','RED',
    '#00FF00','GREEN',
    '#0000FF','BLUE',
    'NO COLOR') AS COLOR_NAME
FROM
    COLOR;


INSERT INTO COLOR VALUES(5,'#0000FF');
INSERT INTO COLOR VALUES(6,'#00FFFF');


SELECT
    ID,COLORCODE,
    DECODE(COLORCODE,
    '#FF0000','RED',
    '#00FF00','GREEN',
    '#0000FF','BLUE',
    'COLOR CODE NOT LABELED') AS COLOR_NAME
FROM
    COLOR;


-- ################################################################
-- Function called RANK,DENSE_RANK, ROW_NUMBER
-- ################################################################
-- USING ROW_NUMBER OVER( ORDER BY SAL)
-- ################################################################
SELECT EMPNO,ENAME,DEPTNO,SAL FROM EMP ORDER BY SAL;

SELECT
    EMPNO,ENAME,DEPTNO,SAL, 
    ROW_NUMBER() OVER (ORDER BY SAL)
    FROM EMP ORDER BY SAL;




-- ################################################################
-- USING ROW_NUMBER OVER( ORDER BY SAL) - FOR EVER DEPT
-- ################################################################

SELECT
    EMPNO,ENAME,DEPTNO,SAL, 
    ROW_NUMBER() OVER (PARTITION BY DEPTNO ORDER BY SAL)
FROM EMP ORDER BY DEPTNO,SAL;


-- ################################################################
-- USING RANK ()
--A. RANK(CONSTANT_VALUES,CONSTANT_VALUES,....) WITHIN GROUP (ORDER BY COL1, COL2)
--B. RANK() OVER (PARTITION BY department_id
-- ################################################################
--A. RANK(3000) WITHIN GROUP (ORDER BY sal)
-- WE GET SINGLE RECORD 
-- IN EMP.SAL THE FIRST 3000 RANK IS RETURN BY THE RANK(3000) WITHIN GROUP(ORDER BY SAL)
--RANK(3000) WITHIN GROUP (ORDER BY sal) WITH THIS WE CAN'T PRESENT OTHER COLUMNS
--RANK(3000) WITHIN GROUP (ORDER BY sal) WE CAN PASS COLUMN VALUES AS IT EXPECT ONLY CONSTANT VALUES
-- ################################################################
SELECT    
    RANK(3000) WITHIN GROUP(ORDER BY SAL)
FROM EMP ORDER BY SAL;
-- ################################################################
--RANK(3000)WITHINGROUP(ORDERBYSAL)
-----------------------------------
--                               12
-- ################################################################
-- ################################################################	 	
-- The following example returns, within each department of the sample table hr.employees, 
-- the minimum salary among the employees who make the lowest commission and the maximum 
-- salary among the employees who make the highest commission:
-- ################################################################	 
SELECT department_id,
MIN(salary) KEEP (DENSE_RANK FIRST ORDER BY commission_pct) "LOW",
MAX(salary) KEEP (DENSE_RANK LAST ORDER BY commission_pct) "MAX"
   FROM employees
   GROUP BY department_id;

-- ################################################################	  
-- TO_CHAR() : 'MM' OR 'MM:YY'
--List all employees join in dec 81 and working for dept 30 as CLERK as 
--per the highest to lowest salary
-- ################################################################	 
SELECT
    empno,ename,deptno,hiredate
FROM
    EMP
    WHERE 
        TO_CHAR(HIREDATE,'MM')='12'
        AND
            TO_CHAR(HIREDATE,'YY')='81'
        AND
            DEPTNO=30 
            AND 
                JOB='CLERK';
    

SELECT
    empno,ename,deptno,hiredate
FROM
    EMP
    WHERE 
        HIREDATE LIKE '%-DEC-81'
        AND
            DEPTNO=30 
            AND 
                JOB='CLERK';
    
-- ################################################################	 
-- List all emp who have joined in same month and year with martin 
-- ################################################################	 
SELECT * FROM EMP 
    WHERE 
    TO_CHAR(HIREDATE,'MM:YY')=(SELECT TO_CHAR(HIREDATE,'MM:YY') FROM EMP WHERE ename='MARTIN')


-- ################################################################	 
-- SUBQUERY
-- ################################################################	 
-- ################################################################	 		
-- Module 4 Displaying Data from Multiple Tables
--   A. SUBQUERY ->
--            1. PROJECTION TAKES ALL COLUMN FROM ONE TABLE WE USE SUBQUERY
--            2. QUERY WITHIN QUERY NESTED QUERIES 
--            3. INNER QUERY AND OUTER QUERY WHERE OUTER QUERY DEPENDS ON RESULTS OF INNER QUERY
--            4. INNER QUERY IS EXECUED FIRST THEN THE OUTER QUERY
--            5. = it indicates we are matching exactly one record from the inner query
--            6. IN it indicates we are matching values with list of records given by inner query
--   B. JOIN->PROJECTION TAKES COLUMNS FROM MORE THAN ONE TABLE WE USE JOINS
-- ################################################################	 	
-- List all emp who are working in same dept of martin
-- To solve above requirement we are using inner query or subquery
-- ################################################################	 	
-- 1. GET DEPTNO FOR MARTIN
SELECT DEPTNO FROM EMP WHERE ENAME='MARTIN';
-- 2. ALL EMPLOYEES WORKING WITH MARTIN 
SELECT EMPNO,ENAME,DEPTNO FROM EMP WHERE DEPTNO=30;
-- 3. FINAL 
SELECT EMPNO,ENAME,DEPTNO FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM EMP WHERE ENAME='MARTIN');
-- ################################################################	 
-- List detail of Max earning employee
-- ################################################################	  
-- 1. get max(sal)
SELECT MAX(SAL) FROM EMP;
-- 2. get employees who has max sal
SELECT EMPNO,ENAME,DEPTNO,JOB,MGR,HIREDATE,SAL,COMM FROM EMP
WHERE SAL=5000
--3. 
SELECT EMPNO,ENAME,DEPTNO,JOB,MGR,HIREDATE,SAL,COMM FROM EMP
WHERE SAL=(SELECT MAX(SAL) FROM EMP);
-- ################################################################	 
-- List all emp who have joined in same month and year with martin and working in turner department
-- ################################################################	 
--1.working in turner department->GET DEPTNO OF TURNER
   SELECT DEPTNO FROM EMP WHERE ENAME='TURNER' 
--2.HIRE DATE OF MARTIN
   SELECT HIREDATE FROM EMP WHERE ename='MARTIN';
--3.who have joined in same month with martin
   SELECT ENAME,HIREDATE FROM EMP 
   WHERE TO_CHAR(HIREDATE,'MM')=TO_CHAR((SELECT HIREDATE FROM EMP WHERE ENAME='MARTIN'),'MM')
--4.who have joined in same  year with martin
SELECT ENAME,HIREDATE FROM EMP 
   WHERE TO_CHAR(HIREDATE,'YY')=TO_CHAR((SELECT HIREDATE FROM EMP WHERE ENAME='MARTIN'),'YY')
--5. fINAL   List all emp who have joined in same month and year with martin and working in turner department
SELECT ENAME,DEPTNO,HIREDATE FROM EMP 
WHERE 
    TO_CHAR(HIREDATE,'MM')=TO_CHAR((SELECT HIREDATE FROM EMP WHERE ENAME='MARTIN'),'MM')   
    AND
     TO_CHAR(HIREDATE,'YY')=TO_CHAR((SELECT HIREDATE FROM EMP WHERE ENAME='MARTIN'),'YY')
    AND
    DEPTNO=(SELECT DEPTNO FROM EMP WHERE ENAME='TURNER' );
    
select * from emp where hiredate=(select hiredate from emp where ename='MARTIN')
and deptno=(select deptno from emp where ename='TURNER')

SELECT ENAME,DEPTNO,HIREDATE FROM EMP 
WHERE 
TO_CHAR(HIREDATE,'MM:YY')=(SELECT TO_CHAR(HIREDATE,'MM:YY') FROM EMP WHERE ename='MARTIN')
AND
deptno=(SELECT DEPTNO FROM EMP WHERE ENAME='TURNER')

-- ################################################################	 
-- LIST ALL EMPLOYEES WHOES MANAGER IS KING
-- ################################################################	 
-- 1. GET EMPNO OF KING
    SELECT EMPNO FROM EMP 
    WHERE
        ENAME='KING';
-- 2. COMPARE IT WITH MGR OF OTHER EMPLOYEES
    SELECT EMPNO,ENAME,MGR FROM EMP
    WHERE 
        MGR=7839;
--3. fINAL LIST ALL EMPLOYEES WHOES MANAGER IS KING
    SELECT EMPNO,ENAME,MGR FROM EMP
    WHERE 
        MGR=(SELECT EMPNO FROM EMP     WHERE        ENAME='KING');

-- ################################################################	 
-- LIST ALL EMP WHO ARE WORKING IN RESEARCH DEPARTMENT
-- ################################################################	 
--1. DEPTNO FOR RESEARCH
    SELECT DEPTNO FROM DEPT WHERE DNAME='RESEARCH';
--2. DEPTNO == COMMPARED WITH RESEARCH DEPTNO
    SELECT EMPNO,ENAME,DEPTNO FROM EMP
    WHERE DEPTNO=20;
--3. LIST ALL EMP WHO ARE WORKING IN RESEARCH DEPARTMENT    
SELECT EMPNO,ENAME,DEPTNO FROM EMP
    WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='RESEARCH');
    
    
-- ################################################################	 
-- LIST TOTAL EMPLOYEE WORKING IN SALES DEPARTMENT
-- ################################################################	 
--    TOTAL=> COUNT
SELECT COUNT(*) FROM EMP
-- WORKING IN SALES =>
SELECT DEPTNO FROM DEPT WHERE dname='SALES';
-- LIST TOTAL EMPLOYEE WORKING IN SALES DEPARTMENT
SELECT COUNT(EMPNO) FROM EMP
    WHERE 
        DEPTNO=(SELECT DEPTNO FROM DEPT WHERE dname='SALES');
        
-- ################################################################	 
-- LIST ALL EMPLOYEE WHO ARE WORKING IN SALES DEPARTMENT IN NEW YORK
-- ################################################################	 
-- BRANCHNO FROM BRANCH TABLE
    SELECT BRANCHNO FROM BRANCH
    WHERE LOCATION='NEW YORK';
-- WORKING IN SALES DEPARTMENT
    SELECT DEPTNO FROM DEPT
    WHERE DNAME='SALES';
    
SELECT ENAME,DEPTNO FROM EMP
WHERE DEPTNO=(SELECT DEPTNO FROM DEPT 
                WHERE DNAME='SALES'
                AND BRANCHNO IN (SELECT BRANCHNO FROM BRANCH     WHERE LOCATION='NEW YORK')
              );  
-- ################################################################
-- LIST ALL EMP WHO HAVE JOINED IN THE INCEPTION YEAR OF COMPANY
-- ################################################################
SELECT HIREDATE FROM EMP ORDER BY HIREDATE;
SELECT MIN(HIREDATE) FROM EMP 
-- SELECT * FROM EMP
SELECT * FROM EMP
    WHERE
        HIREDATE =(SELECT MIN(HIREDATE) FROM EMP) ;
        
---- LIST ALL EMP WHO HAVE JOINED IN THE INCEPTION YEAR OF COMPANY        
SELECT * FROM EMP
    WHERE
        TO_CHAR(HIREDATE,'YY') =(SELECT TO_CHAR(MIN(HIREDATE),'YY') FROM EMP) ;

-- ################################################################
-- COPY OF A TABLE: COLUMNS AND DATA_TYPES ARE SAME AS ORGINAL TABLE HOWEVER NO CONSTRAINTS ARE APPLIED
-- CREATE TABLE EMP1 WHICH IS REPLICA OF EMP WITHOUT DATA
-- ################################################################
SELECT * FROM emp WHERE EMPNO=0

-- CREATE COPY OF EMP TABLE STRUCTURE WITHOUT ANY DATA
    CREATE TABLE 
                EMP_DUMMY 
            AS 
                SELECT * FROM emp WHERE EMPNO=0
SELECT * fROM EMP_DUMMY ; 
-- WE REQUIRED SAMPLE DATA FROM EMPLOYE BASED ON CERTAIN CRITERIA
-- ################################################################
-- INSERT DATA INTO EMP1 FROM EMP WHERE DEPTNO=20
-- ################################################################
INSERT INTO EMP_DUMMY  (SELECT * FROM EMP WHERE DEPTNO=20)
SELECT * fROM EMP_DUMMY ; 
-- ################################################################
-- TRUNCATE EMP1 KEEPS THE TABLE STRUCTURE HOWEVER DELETES ALL RECORDS 
-- ################################################################
TRUNCATE TABLE EMP_DUMMY ; 
DROP TABLE EMP_DUMMY ;

-- ################################################################
--  EMP WHERE EMP ARE WORKING IN NEW YORK LOCATION
-- ################################################################
-- LOCATION -> BRANCH-> BRANCHNO
-- DEPT=>BRANCHNO=>DEPTNO
-- DEPTNO=> ALL EMPLOYEES WORKING IN THAT DEPT

    SELECT * FROM EMP
        WHERE 
            DEPTNO IN (SELECT DEPTNO FROM DEPT 
                            WHERE BRANCHNO IN (SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK'))

-- CREATE COPY OF EMP TABLE STRUCTURE WITHOUT ANY DATA
    CREATE TABLE 
                EMP_DUMMY 
            AS 
                SELECT * FROM emp WHERE EMPNO=0

--INSERT DATA INTO EMP1 FROM EMP WHERE EMP ARE WORKING IN NEW YORK LOCATION
    INSERT INTO
            EMP_DUMMY
            (
            
    SELECT * FROM EMP
        WHERE 
            DEPTNO IN (SELECT DEPTNO FROM DEPT 
                            WHERE BRANCHNO IN (SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK'))
            )

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- Subqueries in DML FOR THAT WE ARE CREATING A DUMMY TABLE EMP_DUMMY
SELECT * FROM EMP;
--DROP TABLE EMP_DUMMY;
-- CREATE A COPY OF EMP IN ADHR DB  CONNCECTION INSTANCE
--CREATE TABLE <TABLE_NAME>(COL_NAME <DATATYPE>,...)
-- BELOW QUERY ONLY coppies the data and column description i.e.
-- copy structure and data of the orginal table but skips the constraints
CREATE TABLE EMP_DUMMY 
AS
    SELECT * FROM EMP;

SELECT  * FROM EMP_DUMMY;
-- Lets do DML OPERATION
DELETE FROM EMP_DUMMY ; -- SIMPLE QUERY DELETING ALL RECORS FROM EMP_DUMMY
ROLLBACK;
SELECT  * FROM EMP_DUMMY;
--#################################################
-- INSERT
-- DELETE
-- UPDATE
--#################################################
--(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
--INSERT INTO EMP_DUMMY  VALUES (?,?,?,?,?,?,?,?)
-- USE SUBQUERY TO INSERT DATA INTO EMP_DUMMY
INSERT INTO EMP_DUMMY (SELECT * FROM EMP WHERE DEPTNO=30);
SELECT * FROM EMP_DUMMY 
WHERE DEPTNO=30
ORDER BY EMPNO
-- WHEN WE CREATE TABLE USING 'AS SELECT' ON CREATE STEATEMENT
-- TABLE ONLY HAS INFORMATION ABOUT COLUMN:DATATYPE OF THE COLUMN
-- WE CAN DUPLICATE VALUES IN THIS TABLE AS THERE ARE NO CONSTRAINTS ON THE COLUMN
-- WHY WE ARE CREATING THIS TABLE : ITS USED FOR rnd purpose
-- once work done drop these tables 
-- instead delete we also can use TRUNCATE ON TABLE WHICH KEEPS THE STRUCTURE
-- BUT DELETE ALL RECORDS
TRUNCATE TABLE emp_dummy;

SELECT * FROM EMP_DUMMY;
-- ################################################################
--  EMP WHERE EMP ARE WORKING IN NEW YORK LOCATION
-- ################################################################
-- SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK';
-- SELECT DEPTNO FROM DEPT WHERE BRANCHNO IN (SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK');
-- SELECT * FROM EMP WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE BRANCHNO IN (SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK'))
INSERT INTO EMP_DUMMY (
SELECT * FROM EMP WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE BRANCHNO IN (SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK'))
);
    
SELECT  * FROM EMP_DUMMY;

-- Subqueries in DML FOR THAT WE ARE CREATING A DUMMY TABLE EMP_DUMMY
SELECT * FROM EMP;
--DROP TABLE EMP_DUMMY;
-- CREATE A COPY OF EMP IN ADHR DB  CONNCECTION INSTANCE
--CREATE TABLE <TABLE_NAME>(COL_NAME <DATATYPE>,...)
-- BELOW QUERY ONLY coppies the data and column description i.e.
-- copy structure and data of the orginal table but skips the constraints
CREATE TABLE EMP_DUMMY 
AS
    SELECT * FROM EMP;

SELECT  * FROM EMP_DUMMY;
-- Lets do DML OPERATION
DELETE FROM EMP_DUMMY ; -- SIMPLE QUERY DELETING ALL RECORS FROM EMP_DUMMY
ROLLBACK;
SELECT  * FROM EMP_DUMMY;
--#################################################
-- INSERT
-- DELETE
-- UPDATE
--#################################################
--(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
--INSERT INTO EMP_DUMMY  VALUES (?,?,?,?,?,?,?,?)
-- USE SUBQUERY TO INSERT DATA INTO EMP_DUMMY
INSERT INTO EMP_DUMMY (SELECT * FROM EMP WHERE DEPTNO=30);
SELECT * FROM EMP_DUMMY 
WHERE DEPTNO=30
ORDER BY EMPNO
-- WHEN WE CREATE TABLE USING 'AS SELECT' ON CREATE STEATEMENT
-- TABLE ONLY HAS INFORMATION ABOUT COLUMN:DATATYPE OF THE COLUMN
-- WE CAN DUPLICATE VALUES IN THIS TABLE AS THERE ARE NO CONSTRAINTS ON THE COLUMN
-- WHY WE ARE CREATING THIS TABLE : ITS USED FOR rnd purpose
-- once work done drop these tables 
-- instead delete we also can use TRUNCATE ON TABLE WHICH KEEPS THE STRUCTURE
-- BUT DELETE ALL RECORDS
TRUNCATE TABLE emp_dummy;

SELECT * FROM EMP_DUMMY;
-- ################################################################
--  EMP WHERE EMP ARE WORKING IN NEW YORK LOCATION
-- ################################################################
-- SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK';
-- SELECT DEPTNO FROM DEPT WHERE BRANCHNO IN (SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK');
-- SELECT * FROM EMP WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE BRANCHNO IN (SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK'))
INSERT INTO EMP_DUMMY (
SELECT * FROM EMP WHERE DEPTNO IN (SELECT DEPTNO FROM DEPT WHERE BRANCHNO IN (SELECT BRANCHNO FROM BRANCH WHERE LOCATION='NEW YORK'))
);
COMMIT;    
SELECT  * FROM EMP_DUMMY ORDER BY COMM;
-- BELOW IS BASIC SYNTAX FOR UPDATING A SPECIFIC RECORD IN TABLE
UPDATE EMP_DUMMY
    SET COMM=0.1
    WHERE COMM IS NULL;
SELECT  * FROM EMP_DUMMY ORDER BY COMM;    
ROLLBACK;    
SELECT  * FROM EMP_DUMMY ORDER BY COMM;


-- HOW TO CREATE TABLE USING CREATE TABLE <TABLE_NAME> AS SELECT QUERY
-- HOW TO ADD DATA USING INSERT INTO <TABLE_NAME> (SELECT QUERY)
-- HOW TO UPDATE DATA USING UPDATE <TABLE_NAME> SET COL=VALUE WHERE COL=(SUBQUERY)
-- HOW TO DELETE DATA USING SUBQUERY
-- DELETE FROM <TABLE_NAME> WHERE EMPNO IN()
-- ################################################################
-- UPDATE SALARY BY 10% WHO ARE WORKING IN ACCOUNTING DEPARTMENT 
-- ################################################################
-- DEPTARTMENT NO OF ACCOUNTING
--SELECT DEPTNO FROM DEPT WHERE DNAME='ACCOUNTING';
--EMPLOYEES WORKING IN ACCOUNTING DEPARTMENT
SELECT * FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='ACCOUNTING');

SELECT * FROM EMP_DUMMY WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='ACCOUNTING');

UPDATE EMP_DUMMY
    SET SAL=SAL+SAL*0.10
    WHERE EMPNO IN (SELECT EMPNO FROM EMP_DUMMY WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='ACCOUNTING'));

SELECT * FROM EMP_DUMMY WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='ACCOUNTING');
COMMIT;

-- ################################################################
-- DELETE RECORDS OF EMPLOYEE WORKING IN ACCOUNTING DEPARTMENT
-- ################################################################
DELETE FROM EMP_DUMMY
WHERE EMPNO IN (SELECT EMPNO FROM EMP_DUMMY WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='ACCOUNTING'));

SELECT * FROM EMP_DUMMY;