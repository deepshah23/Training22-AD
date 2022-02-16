#### 08-FEB-22
AGENDA
1. INDEX
A. Creating a new index 
EXPLAIN PLAN FOR
SELECT * FROM members
WHERE last_name = 'Harse';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
--#####################################################################################################################
--Plan hash value: 2030721806
-- 
------------------------------------------------------------------------------------------------------------
--| Id  | Operation                           | Name               | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT                    |                    |     1 |   258 |     2   (0)| 00:00:01 |
--|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| MEMBERS            |     1 |   258 |     2   (0)| 00:00:01 |
--|*  2 |   INDEX RANGE SCAN                  | I_MEMBERS_LASTNAME |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   2 - access("LAST_NAME"='Harse')
-- 
--Note
-------
--   - dynamic statistics used: dynamic sampling (level=2)
--#####################################################################################################################
EXPLAIN PLAN FOR
SELECT * FROM members
WHERE first_name = 'Delores';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
--#####################################################################################################################
--Plan hash value: 3682585452
-- 
-------------------------------------------------------------------------------
--| Id  | Operation         | Name    | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT  |         |     1 |   258 |     5   (0)| 00:00:01 |
--|*  1 |  TABLE ACCESS FULL| MEMBERS |     1 |   258 |     5   (0)| 00:00:01 |
-------------------------------------------------------------------------------
-- 
--Predicate Information (identified by operation id):
-----------------------------------------------------
-- 
--   1 - filter("FIRST_NAME"='Delores')
-- 
--Note
-------
--   - dynamic statistics used: dynamic sampling (level=2)
--#####################################################################################################################
EXPLAIN PLAN FOR
SELECT * FROM members
WHERE member_id=941;

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
--#####################################################################################################################
Plan hash value: 2912958626
 
-------------------------------------------------------------------------------------------
| Id  | Operation                   | Name        | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |             |     1 |   258 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| MEMBERS     |     1 |   258 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | SYS_C008361 |     1 |       |     1   (0)| 00:00:01 |
-------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("MEMBER_ID"=941)
--#####################################################################################################################
-- REMOVE INDEX
--#####################################################################################################################
DROP INDEX i_members_lastname;

--#####################################################################################################################
-- index on multiple column
--#####################################################################################################################
CREATE INDEX i_memebers_name --first_name+last_name=>name
ON members(last_name,first_name);

EXPLAIN PLAN FOR
SELECT * FROM members
WHERE first_name = 'Delores' and last_name='Pohlke';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());










--#############################################################################
--Oracle UNIQUE index on one column example
--#############################################################################
CREATE UNIQUE INDEX members_email_i
ON members(email);

select * from members 
where email='pelce0@trellian.com';

INSERT INTO members(first_name, last_name, gender, dob, email)
VALUES('Pegpa','Elce','F',DATE '1990-01-02','pelce0@trellian.com');
--#############################################################################
--Above insert query gives below error as wehave unique idex on members.email
--Error starting at line : 117 in command -
--INSERT INTO members(first_name, last_name, gender, dob, email)
--VALUES('Pegpa','Elce','F',DATE '1990-01-02','pelce0@trellian.com')
--Error report -
--ORA-00001: unique constraint (C##ADUSER.SYS_C008361) violated
--#############################################################################
-- Function_index
--#############################################################################

CREATE INDEX i_members_uppercase_lastname
ON members(upper(last_name));

EXPLAI PLAN FOR
SELECT * FROM members
WHERE UPPER(last_name) = 'SANS';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
--#############################################################################
--BITMAP
--#############################################################################
SELECT 
    *
FROM
    members
WHERE
    gender = 'F';

SELECT 
    *
FROM
    members
WHERE
    gender = 'M';
--#############################################################################    
-- Low cardinality columns
--SELECT column, COUNT(*)
--FROM table_name
--GROUP BY column;
--#############################################################################
SELECT ENAME,COUNT(*) FROM EMP GROUP BY ENAME;
SELECT MGR,COUNT(*) FROM EMP GROUP BY MGR;
SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO;

select gender,count(*) from members group by gender;

CREATE BITMAP INDEX members_gender_i
ON members(gender);
--##################
EXPLAIN PLAN FOR 
select * from emp where deptno=10;

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());


CREATE BITMAP INDEX i_emp_deptno
on emp(deptno);

EXPLAIN PLAN FOR 
select * from emp where deptno=30;

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());

--###########################################################################
-- coalesce(,,,)
--###########################################################################

SELECT 
    EMPNO,ENAME,SAL,COMM,COALESCE(COMM,0),NVL(COMM,0)
FROM
    EMP;
--###########################################################################    
-- SAL  |COMM  |COALESCE(SAL,COMM,100)
-- 500  | NULL |500
-- 600  | 500  |600
-- NULL | 500  |500
-- NULL | NULL |100
--###########################################################################
INSERT INTO EMP VALUES(8888,'DUMMY','CLERK',7839,TO_DATE('10-10-2010','DD-MM-YYYY'),NULL,NULL,10)
SELECT 
    EMPNO,ENAME,SAL,COMM,COALESCE(SAL,COMM,1000)
FROM
    EMP
WHERE DEPTNO=10
ORDER BY SAL,COMM;
--###########################################################################
--Section 7. Set Operators
--###########################################################################
SELECT ENAME,DEPTNO,'DEPT10' FROM EMP WHERE DEPTNO=10
UNION
SELECT ENAME,DEPTNO,'DEPT30'  FROM EMP WHERE DEPTNO=30;

SELECT ENAME,DEPTNO FROM EMP WHERE DEPTNO=10
UNION ALL
SELECT ENAME,DEPTNO FROM EMP WHERE DEPTNO=30;

--###########################################################################
--Query the two ENAME in EMP with the shortest and longest EMP names,
--as well as their respective lengths (i.e.: number of characters in the name). 
--If there is more than one smallest or largest ENAME, choose the one that comes 
--first when ordered alphabetically.
--  a.  ename shortest
--  b.  ename largest
--  ENAME       LENGTH(ENAME) 
--  FORD	    4           -> WHO WILL GET SHORTEST EMP NAME ORDER ASC ENAME WITH LENGTH
--JOHN_SMITH	10          -> WHO WILL GET LARGEST EMP NAME ORDER ASC ENAME WITH LENGTH

--###########################################################################
SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME);
SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME),ENAME;

--  a. city name which shortest => ename shortest
SELECT * 
    FROM 
        (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME),ENAME)
    WHERE rownum=1;
--  b. city name which longest  =. ename largest    
SELECT * 
    FROM 
        (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME) desc,ENAME)
    WHERE rownum=1;


SELECT *  FROM (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME),ENAME) WHERE rownum=1
UNION
SELECT * FROM (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME) desc,ENAME) WHERE rownum=1;

SELECT *  FROM (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME),ENAME) WHERE rownum<=2
UNION ALL
SELECT * FROM (SELECT ENAME,LENGTH(ENAME) FROM EMP ORDER BY LENGTH(ENAME) desc,ENAME) WHERE rownum<=2;
--###########################################################################