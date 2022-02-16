--1. Display all the information of the EMP table?
select * from emp;

--2. Display unique Jobs from EMP table?
select DISTINCT JOB from emp;

--3. List the emps in the asc order of their Salaries?
select  * from emp 
order by sal ;

--4. List the details of the emps in asc order of the Dptnos and desc of Jobs?
select * from emp 
order by deptno,job desc;

--5. Display all the unique job groups in the descending order?
select distinct job from emp 
order by job desc;

--6. Display all the details of all ‘Mgrs’
select * from emp 
where empno in(select mgr from emp);

--7. List the emps who joined before 1981
select * from emp 
where hiredate < '01-01-1981';

--8. List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal
select empno,ename,sal, sal/30 as dailysal from emp order by  sal;

--9.Display the Empno, Ename, job, Hiredate, Exp of all Mgrs
select empno,ename,job,hiredate,MONTHS_BETWEEN(SYSDATE,hiredate)
 as exp from emp where empno in (select mgr from emp);

--10 List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369
select empno,ename,sal,MONTHS_BETWEEN(SYSDATE,hiredate) 
as exp from emp where empno in (select mgr from emp where mgr=7369);

--11  Display all the details of the emps whose Comm  Is more than their Sal
select * from emp where comm> sal;

--13  List the emps along with their Exp and Daily Sal is more than Rs 100
select empno,ename,job,mgr,hiredate,sal,comm,
deptno,months_between(sysdate,hiredate) 
as exp ,sal/30 as daily_sal from emp 
where  sal/30>100.;

--14. List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order
select * from emp 
where job in ('CLERK','ANALYST') 
ORDER BY JOB DESC;

--15 List the emps who joined on 1-MAY-81,3-DEC-81,17-DEC-81,19-JAN-80 in asc order of seniority
select * from emp 
where hiredate in ('1-MAY-81','3-DEC-81','17-DEC-81','19-JAN-80')

--16 List the emp who are working for the Deptno 10 or20
select * from emp where deptno=10 or deptno=20;

--17  List the emps who are joined in the year 81
select * from emp where to_char(hiredate,'yy')='81';

--19  List the emps Who Annual sal ranging from 22000 and 45000
select * from emp where sal between 22000 and 45000;

--20.List the Enames those are having five characters in their Names
select ename from emp where ename like '_____';

-- 21.List the Enames those are starting with ‘S’ and with five characters
select ename from emp where ename like 'S____';

--22. List the emps those are having four chars and third character must be ‘r’
select ename from emp where ename like '__r_';

--23. List the Five character names starting with ‘S’ and ending with ‘H’
select ename from emp where ename like 'S___H';

--24. List the emps who joined in January
select * from emp where to_char(hiredate,'MON')= 'JAN';

--27. List the emps whose names having a character set ‘ll’ together
select * from emp where ename like '%ll%';

--29. List the emps who does not belong to Deptno 20
select * from emp where  deptno !=20;

--30 List all the emps except ‘PRESIDENT’ & ‘MGR” in asc order of Salaries
select * from emp where job not IN('PRESIDENT','MANAGER') order by sal;

--31. List the emps whose Empno not starting with digit78
select * from emp where empno not like '78%';

--33. List the emps who are working under ‘MGR’
select e.ename ||'works under '|| m.ename  from emp e , emp m where 
e.empno = m.mgr;

--34. List the emps who joined in any year but not belongs to the month of March
select * from emp where to_char(hiredate,'MON') !='MAR';

--35. List all the Clerks of Deptno 20
select * from emp where job like 'CLERK' and deptno=20;

--36. List the emps of Deptno 30 or 10 joined in the year 1981--
select * from emp where to_char(hiredate,'yy')='81' and deptno=30 or deptno=10;

--37. Display the details of SMITH
select * from emp where ename like 'SMITH';

--38. Display the location of SMITH
select location from branch where branchno in (select d.branchno from emp e , dept d where e.ename = 'SMITH' and e.deptno = d.deptno ); 