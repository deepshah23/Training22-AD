### 10Feb2022
AGENDA:
1. PL/SQL
--###########################################################################
Section 1. Getting started with PL/SQL
--###########################################################################
LANGUAGE
0. KEYWORDS 
1. DATA TYPES 
2. VARIABLES, TYPE OF VARIABLE(CONST,VARYING VALUES),SCOPE(GLOBAL/LOCAL)
3. OPERATORS ARITHMATIC,ASSIGNMENT,CONDITIONAL,LOGICAL
4. CONDITIONAL STATEMENT IFELSE, CASE WHEN THEN
5. LOOPING STATEMENT 
(INFINITE)DO-WHILE (EXIT ,AT LEAST ONCE),(ENTRY-CONTROL)WHILE ,FOR(FIX)
6. REUSABLE-> FUNCTIONS, PROCEDURE 
7. OOP
====================================================
ALGORITHM
 WRITE A ALOGORITHM ADD TWO NUMBER: 
 STEP 1: DECLARE TWO VARIABLES NUM1,NUM2 WITH DEFAULT VALUE 0
 STEP 2: DECLARE ONE VARIABLE RESULT WITH DEFAULT VALUE 0
 STEP 3: RESULT=NUM1+NUM2
 STEP 4: DIPSLAY THE RESULT
 --PL/SQL Anonymous Block
--Anonymous BLOCK WITHOUT NAME
--NAMED BLOCKS ->CALL AGAIN AND AGAIN PROCEDURES OR FUNCTIONS
--BLOCK BEGIN ... END;
--SPACE BEFORE THE BEGIN KEYWORD WE CAN USE IT FOR DECLARATIONS OF VARIABLES 
--    
--    BEGIN
--    
--    --    INSTRUCTIONS TO BE EXECUTED 
--    --    ANYTHING GOES WRONG YOU WILL RAISE ERROR/EXCEPTION
--    --    IF EXCEPTIONS OCCURED WE NEED TO HANDLE THE EXCEPTIONS  
--        
--    END;
--###########################################################################
-- HELLO WORLD TO BE PRINTED BY ANONYMOUS BLOCK
SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.put_line ('Hello World!');
END;

--###########################################################################
-- PRINT MESSAGE='HELLO WORLD!' USING VARIABLE 
-- = is used for comparison operator for equality check 
-- n=10-> checking whether n has value as 10 if yes it returns true otherwise false
-- pl/sql we use ':=' as an assignment operator
--lhs:=rhs will have rhs value
--lhs=rhs indicates lhs is equal to rhs
--###########################################################################
DECLARE 
    v_message VARCHAR2(100):='HELLO WORLD!';
BEGIN
    DBMS_OUTPUT.put_line(v_message);
END;
--###########################################################################
 v_message   -> Naming convention
                    -> all variables must start with v_
                    -> must be meaningful names in camelcase if varying values
                    -> must be meaningful names in capitalcase if constant values
--###########################################################################    sto
--###########################################################################                        
--   EXCEPTION HANDLING 
--  NUMBER CAN'T BE DEVIDED BY ZERO =>ERROR DEVIDE BY ZERO
--###########################################################################                        
-- without handling exception
--###########################################################################                        
    DECLARE
        v_result number:=0;
    BEGIN
            v_result:=1/0;
            
    END;
--###########################################################################                        
-- with handling exception
--###########################################################################                        
    DECLARE
        v_result number:=0;
    BEGIN
            v_result:=1/0;
            EXCEPTION
                WHEN ZERO_DIVIDE THEN
                                DBMS_OUTPUT.put_line('zero devide error');
                                DBMS_OUTPUT.put_line(SQLERRM );
    END;
--###########################################################################                            
--    DBMS_OUTPUT.put_line(SQLERRM );
--    ORA-01476: divisor is equal to zero    
--    PL/SQL procedure successfully completed.
--###########################################################################                        
--    DBMS_OUTPUT.put_line('zero devide error');
--    zero devide error
--    PL/SQL procedure successfully completed.
--###########################################################################                        



--###########################################################################                        
-- LOCAL VARIABLE
--###########################################################################                        
DECLARE
    l_ename varchar2(50):='KING';
    l_mgr  number:=0;
BEGIN
    DBMS_OUTPUT.put_line(l_ename);
    DBMS_OUTPUT.put_line(l_mgr);
END;
--###########################################################################                        
-- anchored
-- get ename for empno 7788
--SELECT ENAME FROM EMP WHERE EMPNO=7788;
--###########################################################################                        
DECLARE
    v_ename  varchar2(50);
BEGIN
        SELECT ename into v_ename from emp where empno=7788;
        
        DBMS_OUTPUT.PUT_LINE(v_ename);
END;
--###########################################################################                        
--    SCOTT
--    PL/SQL procedure successfully completed.
--###########################################################################                        
DECLARE
    v_ename emp.ename%Type;
    v_sal   emp.sal%Type;
BEGIN
    SELECT
        ename,sal 
        INTO
        v_ename,v_sal
    FROM 
        emp
    WHERE 
        empno=7788;
    DBMS_OUTPUT.PUT_LINE(v_ename|| ':' || v_sal);
       
END;

--###########################################################################                            
-- In above examples we have focused on getting result for only single record
-- a. query returns more than one record[one or more columns] 
--  SELECT ENAME,SAL FROM EMP WHERE DEPTNO=30; -- 7 RECORDS ARE SHOWN
-- b. query returns exactly one record[one or more columns]
--SELECT ENAME,SAL FROM EMP WHERE EMPNO=7788;  -- 1 RECORD ARE SHOWN
--###########################################################################
DECLARE 
    v_ename emp.ename%type;
    v_sal emp.sal%type;
    v_comm emp.comm%type;
    v_incentive constant emp.comm%type:=0.10;
BEGIN
        SELECT ENAME,SAL,nvl(comm,0) INTO v_ename,v_sal,v_comm 
        from emp where empno=7788;
--        v_incentive:=0.2; expression 'V_INCENTIVE' cannot be used as an assignment target
        v_sal:=v_sal+v_comm+v_incentive;
        
        DBMS_OUTPUT.PUT_line('Total Salary is '||v_sal);
END;
--###########################################################################
--    Total Salary is 3000.1
--    PL/SQL procedure successfully completed.
--###########################################################################


--###########################################################################
--Section 2. Conditional control
-- conditional will work on expressions which returns true or false
-- if expression returns true there are set of instructions
-- if expression returns false there are another set of instructions
--IF statements – introduce you various IF statement to either execute or skip a sequence of statements based on a condition.
--CASE statements – learn how to choose one sequence of statements out of many possible sequences to execute.
--GOTO – explain the GOTO statement and shows how to use it to transfer control to a labeled block or statement.
--NULL statement – show you how to use the NULL statement to make the code more clear.
--###########################################################################
--        – IF THEN
--        – IF THEN ELSE
--        – IF THEN ELSIF

--            IF condition THEN
--                statements;
--            END IF;
--###########################################################################
-- max(sal)<6000 then print Salary revision is needed
--###########################################################################
DECLARE 
    v_maxsal emp.sal%type;
BEGIN
    select max(sal) into v_maxsal from emp;
    IF v_maxsal<6000 THEN 
        DBMS_OUTPUT.PUT_LINE('SALARY REVISION IS REQUIRED');
    END IF;
END;
--###########################################################################
--        SALARY REVISION IS REQUIRED
--        PL/SQL procedure successfully completed.
--###########################################################################
DECLARE 
    v_maxsal emp.sal%type;
BEGIN
    select max(sal) into v_maxsal from emp;
    IF v_maxsal<=4000 THEN 
        DBMS_OUTPUT.PUT_LINE('SALARY REVISION IS REQUIRED');
    ELSE  
        DBMS_OUTPUT.PUT_LINE('CAN CONSIDER IN NEXT YEAR');
    END IF;
END;

--###########################################################################
DECLARE 
    v_maxsal emp.sal%type;
BEGIN
    select max(sal) into v_maxsal from emp;
    IF v_maxsal<3000 THEN 
        DBMS_OUTPUT.PUT_LINE('MAX SALARY <3000');
    ELSIF   v_maxsal<4000 THEN 
        DBMS_OUTPUT.PUT_LINE('MAX SALARY <4000');
    ELSE
        DBMS_OUTPUT.PUT_LINE('MAX SALARY <=5000');
    END IF;
END;

--###########################################################################
--VARIABLE =(SET VALUES ) BASED ON VALUES OF THIS VARIABLE WE WANT TO MAKE DESCIONS 
--CASE STATEMENT IS USEFULL IN EQUALITY CHECK
--        CASE selector
--        WHEN selector_value_1 THEN
--            statements_1
--        WHEN selector_value_1 THEN 
--            statement_2
--        ...
--        ELSE
--            else_statements
--        END CASE;
--###########################################################################
DECLARE
        v_color color.colorcode%type;
BEGIN
    select colorcode into v_color from color where id=1;
    case v_color
        when '#FF0000' then dbms_output.put_line('RED');
        when '#00FF00' then dbms_output.put_line('GREEN');
        when '#0000FF' then dbms_output.put_line('BLUE')  ;  
        else  dbms_output.put_line('NO COLOR');
    end case;    
END;
--###########################################################################
-- PRINT 1 TO 10 NUMBER USING FOR
--###########################################################################
DECLARE
v_i number:=1;
BEGIN
FOR v_i IN 1..10
LOOP
DBMS_OUTPUT.PUT_LINE(v_i);
END LOOP;
END;


--###########################################################################
-- PRINT 1 TO 10 NUMBER USING FOR
--###########################################################################
DECLARE
    v_i number:=1;
BEGIN
--        FOR v_i IN 1..10
--            LOOP
--                DBMS_OUTPUT.PUT_LINE(v_i);
--            END LOOP;
            
        FOR COUNTER IN 1..10
            LOOP
                DBMS_OUTPUT.PUT_LINE(COUNTER);
            END LOOP;    
            
         FOR COUNTER IN  REVERSE 1..10
            LOOP
                DBMS_OUTPUT.PUT_LINE(COUNTER);
            END LOOP;       
END;
--###########################################################################
-- PRINT 1 TO 10 NUMBER USING WHILE LOOP
--###########################################################################
DECLARE 
    v_i number:=1;
BEGIN
    WHILE v_i<11
        LOOP
            DBMS_OUTPUT.PUT_LINE (v_i);
            v_i:=v_i+1;        
        END LOOP;
END;









--###########################################################################
-- PRINT FIRST 5 RECORDS[ENAME] FROM EMP
--###########################################################################
DECLARE
v_i number:=1;
v_ename emp.ename%type;
BEGIN
LOOP


END LOOP;



END;
