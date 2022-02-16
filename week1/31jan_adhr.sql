

CREATE TABLE BRANCH (
		BRANCHNO	INT CONSTRAINT PK_BRANCH_BRANCHNO PRIMARY KEY,
		BRANCHNAME  VARCHAR2(20) NOT NULL ,
		LOCATION    VARCHAR2(20) NOT NULL 
	);	
    
    
CREATE TABLE DEPT    (
		DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
		DNAME VARCHAR2(14),
		BRANCHNO	INT CONSTRAINT FK_DEPT_BRANCHNO REFERENCES BRANCH			
	) ;   
    
    
  ALTER TABLE DEPT
    MODIFY DNAME VARCHAR2(14) NOT NULL; 
    
    
  CREATE TABLE EMP(
		EMPNO 		NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
		ENAME 		VARCHAR2(10),
		JOB 		VARCHAR2(9),
		MGR 		NUMBER(4),
		HIREDATE 	DATE,
		SAL 		NUMBER(7,2),
		COMM 		NUMBER(7,2),
		DEPTNO 		NUMBER(2) CONSTRAINT FK_EMP_DEPTNO REFERENCES DEPT,
		BRANCHNO 	INT CONSTRAINT FK_EMP_BRANCHNO REFERENCES BRANCH
	);   
    
    
-- =======================================================================
-- WHAT IF WE HAVE NULL VALUES IN THE RECORD BEFORE WE ALTER THE COLUMN TO NOT NULL    
    DROP TABLE TAB1;
    
        CREATE TABLE TAB1( 
        ID INT,
        DATA VARCHAR2(10)
        );   
        
     INSERT INTO TAB1 VALUES( 1,NULL);
     INSERT INTO TAB1 VALUES( 2,NULL);
     INSERT INTO TAB1 VALUES( 3,'HAS DATA');

SELECT * FROM TAB1; 

-- BELOW QUERY GIVES ERROR AS NULL VALUE FOUND 
ALTER TABLE TAB1 MODIFY DATA VARCHAR2(10) NOT NULL;

-- UPDATE THE NULL VALUE TO 'SOME DATA' 
 TAB1 SET DATA='SOME VALUE' WHERE DATA IS NULL;

ALTER TABLE TAB1 
MODIFY DATA VARCHAR2(10) NOT NULL;

--- pk_branch_branchno is it a temporary name: NO those are object names they are fixed
Drop table tab1;
CREATE TABLE tab1( 
id int primary key,
data varchar(20)
);
--   ==================================================================
-- ################################################################
-- 5. Insert data into Table - DML insert into 
-- ################################################################
	INSERT INTO BRANCH VALUES 	(101,'Geneva','NEW YORK');
	INSERT INTO BRANCH VALUES 	(102,'Geneva','NEW YORK');
	INSERT INTO BRANCH VALUES 	(103,'CHICAGO','CHICAGO');
	INSERT INTO BRANCH VALUES 	(104,'CHICAGO','CHICAGO');
	INSERT INTO BRANCH VALUES 	(105,'Kingston','NEW YORK');
	INSERT INTO BRANCH VALUES 	(106,'Kingston','NEW YORK');
-- ################################################################
	INSERT INTO DEPT VALUES	(10,'ACCOUNTING',101);
	INSERT INTO DEPT VALUES (20,'RESEARCH',103);
	INSERT INTO DEPT VALUES	(30,'SALES',105);
	INSERT INTO DEPT VALUES	(40,'OPERATIONS',106);
-- ################################################################

    INSERT INTO EMP VALUES(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20,102);
    INSERT INTO EMP VALUES(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30,102);
    INSERT INTO EMP VALUES(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30,103);
    INSERT INTO EMP VALUES(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20,104);
    INSERT INTO EMP VALUES(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30,105);
    INSERT INTO EMP VALUES(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30,105);
    INSERT INTO EMP VALUES(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10,102);
    INSERT INTO EMP VALUES(7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87')-85,3000,NULL,20,103);
    INSERT INTO EMP VALUES(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,NULL,101);
    INSERT INTO EMP VALUES(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30,104);
    INSERT INTO EMP VALUES(7876,'ADAMS','CLERK',7788,to_date('13-JUL-87')-51,1100,NULL,20,105);
    INSERT INTO EMP VALUES(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30,103);
    INSERT INTO EMP VALUES(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20,105);
    INSERT INTO EMP VALUES(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10,104);
    INSERT INTO EMP VALUES(7901,'JOHN_SMITH','CLERK',7698,to_date('23-1-1982','dd-mm-yyyy'),3000,NULL,30,104);
-- ################################################################
COMMIT ;
-- ################################################################
select  * from dept;
1. FROM  ->WHICH RESOURCE YOU ARE LOOKING FOR THE DATA
		 ->ALL RECORDS FROM THAT RESOURCE IS LOADED 
2. SELECT->PROJECTION IT INDICATE WHAT YOU WANT TO PRESENT ON OUTPUT 
		 ->FROM TABLE WHICH ALL COLUMNS/FIELDS YOU WILL PRESENT ON OUTPUT
		 -> * INDICATES ALL
		 -> <COLUMN>...=> SPECIFIC COLUMNS ONLY
		 SELECT <COLUMN>=>PROJECTION-> SHOW SPECIFIC FIELDS
-- ################################################################
	-- 8. Display all records from dept
-- ################################################################
	select  * from dept;
    select deptno,dname,branchno from dept;
-- ################################################################
-- 9. Display all records from branch
-- ################################################################
	select * from branch;
    select BRANCHNO,	BRANCHNAME ,       LOCATION    from branch;
-- ################################################################
-- 10. Display all records from emp
-- ################################################################
	select * from emp;
    select EMPNO ,ENAME ,JOB,MGR ,HIREDATE ,SAL  ,COMM ,DEPTNO ,BRANCHNO  from emp
-- ################################################################
-- 11. Sort recrods using order by clause
-- ################################################################
-- 11.1 Sort the all employees details on empno
-- ################################################################

SELECT 
    empno,ename,job,mgr,hiredate,sal,comm,deptno,branchno
FROM
    emp
ORDER BY
    empno;

-- ################################################################
-- 11.2 Sort the all employees details on department wise
-- ################################################################

SELECT 
    deptno,empno,ename,job,mgr,hiredate,sal,comm,branchno
FROM
    emp
ORDER BY
    deptno;
    
-- ################################################################
-- 11.3 Sort the all employees details as per department by emp no and dept no
-- ################################################################
SELECT 
    deptno,empno,ename,job,mgr,hiredate,sal,comm,branchno
FROM
    emp
ORDER BY
    deptno,empno;
-- ################################################################
-- 11.4 Sort the all employees details as per department in ascending by emp no descending
-- ################################################################    
SELECT 
    deptno,empno,ename,job,mgr,hiredate,sal,comm,branchno
FROM
    emp
ORDER BY
    deptno,empno desc;    
    
-- ################################################################
-- 11.5 Sort the all employees details as per department no, salary
-- ################################################################
SELECT 
    deptno,empno,ename,sal
FROM
    emp
ORDER BY
    deptno,sal;
-- ################################################################
-- 11.6 Sort the all employees details as per salary
-- ################################################################
SELECT 
    deptno,empno,ename,sal
FROM
    emp
ORDER BY
   sal;
-- ################################################################
-- 11.7 Sort the all employees details as per salary desc
-- ################################################################
SELECT 
    deptno,empno,ename,sal
FROM
    emp
ORDER BY
   sal desc;
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
1. DQL
2. Select
	Projection: column_name on the select
3. sorting 
	Order by col1,col2,col3 ASC/DESC   
        
        