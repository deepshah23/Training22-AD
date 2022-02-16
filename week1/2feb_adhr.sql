### 2Feb2022
Agenda : 
1. Join
2. to_char(),to_date(),rank(),coalesce,timestamp
===============================================================
SELECT * FROM BRANCH;
SELECT * FROM DEPT;
SELECT * FROM EMP;

ALTER TABLE emp
DROP COLUMN branchno;
-- ################################################################ 
-- JOIN 
-- THERE ARE TWO WAYS TO FETCH DATA FROM ORACLE DATABASE 
-- EITHER USING (+) OR USING ANSI LEFT/OUTER/INNER/RIGHT QURIES
-- Oracle syntax dont have full outer join but Ansi version has it
-- ################################################################ 


-- ################################################################
-- 18.0 Display employee details such that ename,deptname and location of work is printed by the query
-- ################################################################
SELECT
    emp.ename,dept.dname,branch.location
FROM 
    emp,dept,branch
where 
    emp.deptno=dept.deptno and dept.branchno=branch.branchno;

SELECT
    emp.ename,dept.dname,branch.location
FROM 
    emp JOIN dept 
    ON emp.deptno=dept.deptno
    JOIN branch
    ON dept.branchno=branch.branchno;






-- ################################################################ 
-- LIST All employees details suhc as  EMPNAME, JOB, MGR, HIGREDATE, SAL,DNAME
-- left join to dept table 
-- All employee details along with dname even if some employee has null value in deptno.
--    EMP [ EMPNAME, JOB, MGR, HIGREDATE, SAL]
--    DEPT[ DNAME]
--   EMP.DEPTNO=DEPT.DEPTNO
-- ################################################################ 
SELECT 
    ENAME,JOB,MGR,HIREDATE,SAL,DNAME
FROM
EMP LEFT OUTER JOIN DEPT
ON
EMP.DEPTNO=DEPT.DEPTNO;
-- ################################################################ 
-- Display ename,job,mgr,sal,hiredate,dname from emp and dept 
-- such that all deptartment names are displayed in ouput
-- Display ename,job,mgr,sal,hiredate,dname from emp showing right join with dept 
 ################################################################ 
SELECT 
    ENAME,JOB,MGR,HIREDATE,SAL,DNAME
FROM
EMP RIGHT OUTER JOIN DEPT
ON
EMP.DEPTNO=DEPT.DEPTNO;

-- ################################################################ 
-- Display ename,job,mgr,sal,hiredate,dname from emp and dept 
-- EVEN FOR THE NULL VALUES IN BOTH TABLES
 -- ################################################################ 
 SELECT 
    ENAME,JOB,MGR,HIREDATE,SAL,DNAME
FROM
    EMP FULL OUTER JOIN DEPT
ON
    EMP.DEPTNO=DEPT.DEPTNO
ORDER BY DNAME ;

--
 SELECT 
    ENAME,JOB,MGR,HIREDATE,SAL,e.deptno,DNAME
FROM
    EMP e JOIN DEPT d
ON
    e.DEPTNO=d.DEPTNO
ORDER BY DNAME ;


SELECT ENAME, E.job, MGR,HIREDATE,SAL,D.DNAME
FROM EMP E , DEPT D
WHERE E.DEPTNO=D.DEPTNO(+)

SELECT ENAME, E.job, MGR,HIREDATE,SAL,D.DNAME
FROM EMP E , DEPT D
WHERE E.DEPTNO(+)=D.DEPTNO


-- ################################################################ 
-- list ename,job,sal,branchname
-- emp
-- branch
-- ################################################################ 
SELECT 
    ENAME,JOB,SAL,BRANCHNAME
FROM
        EMP e join Dept d
    on 
        e.deptno=d.deptno
    join
        branch b
    on
        d.branchno=b.branchno;

-- ################################################################ 
-- list empname, job,sal,branchname,dname
-- ################################################################ 
--aSSIGNMENT
-- ################################################################ 
-- LIST ALL DNAME AND EMP COUNT FOR EACH DEPT 
-- ################################################################ 
SELECT
    DNAME,COUNT(EMPNO)
FROM
    DEPT JOIN EMP
ON
    DEPT.DEPTNO=EMP.DEPTNO
GROUP BY 
    DNAME;
    
    

-- ################################################################ 
-- LIST ALL BRANCHNAME AND EMP COUNT FOR EACH BRANCH
-- ################################################################ 
SELECT 
    BRANCHNAME,COUNT(EMPNO)
FROM
    BRANCH JOIN DEPT
    ON BRANCH.BRANCHNO=DEPT.BRANCHNO
    JOIN EMP
    ON DEPT.DEPTNO=EMP.DEPTNO
GROUP BY
    branchname;
-- ################################################################ 
--LIST BRANCHNAME,DNAME,SUM OF SAL FOR THOSE BRANCH AND DEPT WHERE THE SUM IS >5000
-- ################################################################ 

- ################################################################
-- 18. SUB QUERY
-- ################################################################
-- ################################################################
-- 18. display the employees details such as empno,ename and sal, who are earning more than avg salary
-- ################################################################
-- ################################################################
-- 18. SUB QUERY
-- Query within query
-- Inner Query
-- outer Query depends on result of INNER query
-- ################################################################
-- ################################################################
-- 18. display the employees details such as empno,ename and sal, who are earning more than avg salary
-- ################################################################
-- 1. display empno,ename,sal
SELECT 
    empno,ename,sal
FROM 
    emp;
-- 2. avg(sal)
SELECT 
    AVG(sal)
FROM 
    emp;

-- 3. sal>avg(sal) final solution

SELECT 
    empno,ename,sal
FROM 
    emp
WHERE
    sal>(
    SELECT 
        AVG(sal)
    FROM 
    emp
    );



-- ################################################################
-- 18.2. Display empno,ename,deptno for all employees working in 'ACCOUNTING'
-- ################################################################
-- 1.
    SELECT 
        empno,ename,deptno
    from 
        emp;
-- 2. 
    SELECT 
        deptno
    FROM
        dept
    WHERE
        dname='ACCOUNTING';

-- 3. Final Query
    SELECT 
        empno,ename,deptno
    FROM
        emp
    WHERE
        deptno=(
        SELECT 
        deptno
    FROM
        dept
    WHERE
        dname='ACCOUNTING'
        );



-- ################################################################
-- 18.3. Display empno,ename,deptno for all employees from department having employee earning salary > avg(salary)
-- ################################################################
-- 1. department having employee earning max salary
    SELECT 
        deptno
    FROM 
        emp
    WHERE
        sal>(SELECT avg(sal) FROM emp)
    ORDER BY
    deptno;
        
    
-- 2. Display empno,ename,deptno for all employees
    SELECT 
        empno,ename,deptno
    FROM
        emp;
    
-- 3. Final
SELECT 
        empno,ename,deptno
    FROM
        emp
    WHERE
    deptno IN (SELECT       deptno     FROM         emp
            WHERE         sal>(SELECT avg(sal) FROM emp))
    ORDER BY
    deptno;

-- ################################################################
-- 18.3. Display empno,ename,deptno for all employees from department having employee earning salary > avg(salary)
-- ################################################################
-- 1. department having employee earning max salary
    SELECT 
        deptno
    FROM 
        emp
    WHERE
        sal>(SELECT avg(sal) FROM emp)
    ORDER BY
    deptno;
        
    
-- 2. Display empno,ename,deptno for all employees
    SELECT 
        empno,ename,deptno
    FROM
        emp;
    
-- 3. Final
SELECT 
        empno,ename,deptno
    FROM
        emp
    WHERE
    deptno IN (SELECT       deptno     FROM         emp
            WHERE         sal>(SELECT avg(sal) FROM emp))
    and
    sal>(SELECT avg(sal) FROM emp)
    ORDER BY
    deptno;
-- ################################################################
-- 18.4. Display empno,ename,deptno for employee earning greater than any from employees of dept 30
-- ################################################################
SELECT sal FROM emp WHERE deptno=30 order by sal;
SELECT      empno,ename,deptno,sal FROM         emp where deptno!=30



SELECT 
        empno,ename,deptno,sal
FROM
        emp
WHERE
        sal > ANY(SELECT sal FROM emp WHERE deptno=30)
        and
        deptno!=30 
order by sal;


SELECT 
        empno,ename,deptno,sal
FROM
        emp
WHERE
        sal > All(SELECT sal FROM emp WHERE deptno=30)
        
order by sal;





