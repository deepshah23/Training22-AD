#### 01-Feb-22
Agenda
4.Restriction : WHERE
5. WHERE OPERATORS
    COMPARISON OPERATOR >,<.>=,<=,<>,!=
    IN , NOT IN, BETWEEN, NOT BETWEEN, LIKE, NOT LIKE
    IS NULL, NOT NULL
6. NULL -> INSTEAD OF NULL SOME value=> nvl()
7. AGGREGATE FUNCTIONS
8. GROUP BY
9. Restriction on Group by using Having
================================================================
-- ################################################################
-- 12. WHERE CLAUSE
-- Where caluse with in,not in, is null, is not null, between, not between
-- Where caluse with Comparison Operator (<,>,<=,>=,=,<>,!=)
-- Where caluse with Logical Operator (AND,OR,NOT)
-- ################################################################
-- ################################################################
-- 12.1 Display all emp working in deptno 10
-- ################################################################
SELECT
    empno,ename,deptno
FROM
    emp
WHERE 
    deptno=10;
-- ################################################################
-- 12.3 Display all employees working in department no 10 or 20
-- using OR
-- using IN
-- ################################################################
SELECT
    empno,ename,job,mgr,hiredate,sal,comm,deptno,branchno
FROM 
    emp
WHERE 
    deptno=10 or deptno=20;
--    using IN
SELECT
    empno,ename,job,mgr,hiredate,sal,comm,deptno,branchno
FROM 
    emp
WHERE 
    deptno IN (10,20);


-- ################################################################
-- 12.3 Display all employees not working in department no 10 or 20
-- using OR
-- using IN
-- ################################################################
SELECT
    empno,ename,deptno
FROM
    emp
WHERE 
    deptno!=10 AND deptno!=20;
    
--    using IN
SELECT
    empno,ename,deptno
FROM
    emp
WHERE 
    deptno NOT in (10,20);

 -- ################################################################
-- 12.4 Display all employees not working in any department 
-- ################################################################
-- Below query will not give any records as we are comparing values from list 10,20,30
SELECT
    empno,ename,deptno
FROM
    emp
WHERE 
    deptno NOT IN (10,20,30)
ORDER BY
    deptno;
   
-- NO DEPTNO INDICATES NULL VALUE HENCE WE USE IS NULL
SELECT
    empno,ename,deptno
FROM
    emp
WHERE 
    deptno IS NULL
ORDER BY
    deptno;
-- ################################################################
-- 12.7 Display employee no,name,comm working department no 30 and earning some commission
-- ################################################################
SELECT
    empno,ename,comm,deptno
FROM 
    emp
WHERE
    deptno=30 AND comm IS NOT NULL AND comm>0
ORDER BY 
    comm;


-- ################################################################
-- 12.8 Display all employees not earning any commission
-- ################################################################
SELECT
    empno,ename,comm,deptno
FROM 
    emp
WHERE
    comm IS NULL OR comm=0
ORDER BY 
    comm;

-- ################################################################
-- 12.9 Display all employees earning salary in range 1000 to 3000 including boundry values
-- ################################################################
SELECT
    empno,ename,sal
FROM 
    emp
WHERE
    sal>=1000 and sal<=3000
ORDER BY 
    sal ;
-- using BETWEEN
SELECT
    empno,ename,sal
FROM 
    emp
WHERE
    sal BETWEEN 1000 AND 3000
ORDER BY 
    sal ;
  
-- ################################################################
-- 12.11 Display all employees earning salary not in range 1000 to 3000
-- ################################################################
    
SELECT
    empno,ename,sal
FROM 
    emp
WHERE
    sal NOT BETWEEN 1000 AND 3000
ORDER BY 
    sal ;
    
-- USING > AND <
SELECT
    empno,ename,sal
FROM 
    emp
WHERE
    sal<1000 OR sal>3000
ORDER BY 
    sal ;

-- ################################################################
-- 12.12 Display all employees earning 5000salary 
-- ################################################################
SELECT
    empno,ename,sal
FROM 
    emp
WHERE
    sal=5000
ORDER BY 
    sal ;


-- ################################################################
-- 12.13 Display all employees not earning 5000 salary 
-- ################################################################
SELECT
    empno,ename,sal
FROM 
    emp
WHERE
    sal!=5000
ORDER BY 
    sal ;
    
 -- USING <>
 SELECT
    empno,ename,sal
FROM 
    emp
WHERE
    sal<>5000
ORDER BY 
    sal ;

-- ################################################################
-- 13. Where caluse with like
--     WHERE WITH ESCAPE Clause
-- ################################################################
-- ################################################################
-- 13.1 Display all details of SMITH
-- ################################################################
SELECT
    empno,ename
FROM
    emp
WHERE 
    ename='SMITH'; 
-- in oracle data is case sensitive
SELECT
    empno,ename
FROM
    emp
WHERE 
    ename='Smith'; 

-- ################################################################
-- 13.2 Display all details of EMPLOYEE who's name starts with S
-- ################################################################
SELECT
    empno,ename
FROM
    emp
WHERE 
    ename LIKE 'S%'; 

SELECT
    empno,ename
FROM
    emp
WHERE 
    ename NOT LIKE 'S%'; 

-- ################################################################
-- 13.3 Display all details of EMPLOYEE who's name ends with S
-- ################################################################
SELECT
    empno,ename
FROM
    emp
WHERE 
    ename LIKE '%S'; 
-- ################################################################
-- 13.4 Display all details of EMPLOYEE who's name contains LL
-- ################################################################
SELECT
    empno,ename
FROM
    emp
WHERE 
    ename LIKE '%LL%'; 
    
SELECT
    empno,ename
FROM
    emp
WHERE 
    ename LIKE '_LL__'; 
        
-- ################################################################
-- 13.5 Display all details of EMPLOYEE who's name contains _
-- ################################################################
--    BELOW QUERY IS TO MUCH EXCITED TO GIVE ALL EMPLOYE AS IT % _ %
SELECT
    empno,ename
FROM
    emp
WHERE 
    ename LIKE '%_%'; 
--    BELOW QUERY IS AFRAID TO FIND ANY RECORD
SELECT
    empno,ename
FROM
    emp
WHERE 
    ename LIKE '%\_%'; 
--    USING ESCAPE : rEALIZATION WE NEED ENAME WITH "_"
SELECT
    empno,ename
FROM
    emp
WHERE 
    ename LIKE '%\_%' ESCAPE '\';
    
SELECT
    empno,ename
FROM
    emp
WHERE 
    ename LIKE '%@_%' ESCAPE '@';

-- ################################################################
-- 14. Aggregate Function max,min,sum,avg,count 
--     SUM
--     AVG
--     COUNT
--     MAX
--     MIN

-- ################################################################
-- 14.1 Display count of employees
-- count(*) including null values 
-- ################################################################
SELECT
    COUNT(*), COUNT(empno),count(deptno)
FROM 
    emp;
-- ################################################################
-- 14.2 Display count of employees WORKING IN SOME DEPT
-- count(deptno) excludes the null vlaue 
-- ################################################################
    select count(DEPTNO) from emp;

-- ################################################################
-- 14.3 Display max,min,sum,avg salary of employees
-- ################################################################
SELECT
    MIN(sal), MAX(sal),COUNT(sal),SUM(sal),AVG(sal)
FROM
    emp;
    
-- ################################################################
-- 15.1 Display department wise count of employees
-- ################################################################
SELECT
    deptno,count(empno)
FROM 
    emp
GROUP BY
    deptno
ORDER BY 
    deptno;
-- ################################################################
-- 15.1 Display job wise count of employees and order by job
-- ################################################################
    
SELECT
    job,COUNT(empno)
FROM 
    emp
GROUP BY
    job
ORDER BY 
    job;
    
SELECT
    job,COUNT(empno)
FROM 
    emp
GROUP BY
    job
ORDER BY 
    count(empno);
    
    -- ################################################################
-- 15.2 Display department wise max,min,avg salary
-- ################################################################
-- ################################################################
-- 15.2 Display department wise max,min,avg salary
-- ################################################################
SELECT 
       deptno,MAX(sal),MIN(sal),AVG(sal)
FROM 
    emp
GROUP BY
    deptno
ORDER BY
    deptno;
    
SELECT 
       deptno,MAX(sal),MIN(sal),round(AVG(sal),2)
FROM 
    emp
GROUP BY
    deptno
ORDER BY
    deptno;
        
    -- ################################################################
-- 15.3 Display department wise max,min,avg salary where avg(sal)<2500
-- ################################################################
SELECT 
       deptno,MAX(sal),MIN(sal),round(AVG(sal),2)
FROM 
    emp
GROUP BY
    deptno
Having 
    avg(sal)<2500
ORDER BY
    deptno;
-- ################################################################
-- 16. Special functions nvl() 
-- If comm is null display 0
-- Display empno,ename,sal,comm and total sal=sal+comm for all employees 
-- 0+1=1
-- null+1=null
-- for calculation purpose we can give some default value for null values in a column
-- nvl=>nullvalue replacement 
-- ################################################################
SELECT
    empno,ename,sal,comm,sal+comm,sal+nvl(comm,0)
FROM
    emp
ORDER BY comm;
-- if comm 0 or comm is null -> 100 -> case when expression then action end 
-- if com >0   comm
SELECT
    empno,ename,sal,comm,
    case
        when comm is null or comm=0
                then 100
        when comm >0
                then comm
    end as UPDATED_COMMISSION ,
    SAL+case
        when comm is null or comm=0
                then 100
        when comm >0
                then comm
    end as Total_salary
    
FROM 
    emp
ORDER BY
    comm;