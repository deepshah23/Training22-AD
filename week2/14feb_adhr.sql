REFCURSOR :SYS_REFCURSOR
SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION get_emp_by_deptno(p_deptno emp.deptno%type)
RETURN SYS_REFCURSOR
AS  
    EMP_REF_CURSOR SYS_REFCURSOR; -- DECLARATION OF SYS_REFCURSOR VARIABLE
BEGIN
    OPEN EMP_REF_CURSOR FOR  SELECT EMPNO,ENAME,JOB,SAL,COMM  FROM emp    WHERE deptno=p_deptno;
    RETURN EMP_REF_CURSOR;
END;


DECLARE 
    EMP_REF_CURSOR SYS_REFCURSOR;
    v_EMPNO emp.empno%type;
    v_ENAME emp.ename%type;
    v_JOB   emp.job%type;
    v_SAL   emp.sal%type;
    v_COMM  emp.comm%type;
    v_deptno emp.deptno%type:=&deptno;
BEGIN
    --   call the function
    EMP_REF_CURSOR:=get_emp_by_deptno(v_deptno);
    --   READ THE RECORDS FROM THE REF CURSOR    
        LOOP
            FETCH EMP_REF_CURSOR INTO v_EMPNO, v_ENAME,v_JOB,v_SAL,v_COMM;
            EXIT WHEN EMP_REF_CURSOR%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(
                v_EMPNO ||', '||
                v_ENAME ||', '||
                v_JOB   ||', '||
                v_SAL   ||', '||
                v_COMM 
                );
        END LOOP;  
END;
        
===================== cREATE A FUNCTION RETURNING A  NUMERI C VALUE
CREATE OR REPLACE FUNCTION TOTAL_SAL(SAL emp.sal%type,COMM emp.comm%type)
RETURN  emp.sal%type
AS
    v_total_sal emp.sal%type;
BEGIN
        IF COMM IS NULL THEN v_total_sal:=SAL+0;
        ELSE
            v_total_sal:=SAL+COMM;
        END IF;
        RETURN v_total_sal;
END;
-- CALLING USER DEFINED FUNCTION ON SELECT QUERY
SELECT ENAME,SAL,COMM, TOTAL_SAL(SAL,COMM) TOTAL_SAL FROM EMP;


--######################################################################        
-- cREATE A PROCEDURE TO RETURN SAL COMM OF EMPNO ENTERED BY USER
--######################################################################        
CREATE OR REPLACE PROCEDURE prc_get_salcomm_byempno( p_empno IN emp.empno%type,
                              p_sal OUT emp.sal%type,
                              p_comm OUT emp.comm%type)
AS 
BEGIN
    
    SELECT SAL,COMM INTO p_sal,p_comm FROM emp WHERE empno=p_empno;
    
END;


declare 
p_empno emp.empno%type:=&empno;
p_sal  emp.sal%type;
p_comm  emp.comm%type;
Begin
    prc_get_salcomm_byempno( p_empno, p_sal , p_comm);
    DBMS_OUTPUT.PUT_LINE(p_empno||' has '|| p_sal|| ' and '|| p_comm);
End;

CREATE OR REPLACE PROCEDURE prc_get_ename_byempno(p_empno emp.empno%type)
As
    v_ename emp.ename%type;
begin
     select ename into v_ename from emp where empno=p_empno;
     DBMS_OUTPUT.PUT_LINE('ename of empno '||p_empno ||' is '||v_ename);   
end;       
        
execute prc_get_ename_byempno(7499);      
        
--######################################################################        
-- Use procedure to display all details of employee using empno-> single record
--######################################################################                


--######################################################################        
-- Use procedure to display all details of employee using deptno-> mutliple  record *cursor + for loop