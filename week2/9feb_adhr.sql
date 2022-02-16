#### 09-feb-22
AGENDA
1. CREATE SYNONYM
2. CREATE SEQUENCE
==============================================================================
--######################################################
--Oracle synonyms
--create aliases for schema objects such as tables, views, 
--materialized views, sequences, procedures, and stored function.
--######################################################
select * from c##erpuser.colors;
select * from c##aduser.color;

CREATE PUBLIC SYNONYM colors for c##erpuser.colors;
SELECT * FROM COLORS;

--######################################################
--    CREATE [OR REPLACE] [PUBLIC] SYNONYM schema.synonym_name
--    FOR schema.object;
--    CREATE PUBLIC SYNONYM colors 
--    FOR c##erpuser.colors;

--######################################################
CREATE TABLE DEMO(
ID NUMBER GENERATED AS IDENTITY,
DATA VARCHAR2(10)
);

INSERT INTO DEMO (DATA) VALUES ('RECORD1');
INSERT INTO DEMO (DATA) VALUES ('RECORD2');
INSERT INTO DEMO (DATA) VALUES ('RECORD3');
INSERT INTO DEMO (DATA) VALUES ('RECORD4');
INSERT INTO DEMO (DATA) VALUES ('RECORD5');
COMMIT;
SELECT  * FROM DEMO;

CREATE SYNONYM SYN_DEMO FOR C##ADUSER.DEMO;

SELECT * FROM SYN_DEMO;

SELECT * FROM c##aduser.syn_demo;
SELECT * FROM c##erpuser.syn_demo;


--#################################################################
--DROP SYNONYM schema.synonym_name FORCE;
--#################################################################
DROP SYNONYM SYN_DEMO FORCE;
--#################################################################
--generating identity  values based on
-- increment by 1 or 10 or 100...
-- min 1
-- max 9999999999999999999999999999
--CREATE SEQUENCE <<seqname>> 
--INCREMENT BY 1 
--MAXVALUE 9999999999999999999999999999 
--MINVALUE 1 
--CACHE 20

--#################################################################
CREATE SEQUENCE productid
INCREMENT BY 1
MAXVALUE 1000
MINVALUE 1
CACHE 20;

CREATE TABLE PRODUCT(
pid number primary key,
pname varchar(50) not null
)

insert into product values(productid.nextval,'pepsi 500ml');  
insert into product values(productid.nextval,'pepsi 500ml');
insert into product values(productid.nextval,'pepsi 500ml');
insert into product values(productid.nextval,'pepsi 500ml');
insert into product values(productid.nextval,'pepsi 500ml');

select * from product;

--######################################################
--alter sequence
--######################################################
ALTER SEQUENCE PRODUCTID MAXVALUE 10000;
--######################################################
-- DROP SEQUENCE
--######################################################
DROP SEQUENCE PRODUCTID;




--######################################################
--Introduction to Oracle CREATE ROLE statement
-- Why to create Role?
--  Whenver we create a user we need to assign privileges to user
--  Instead of granting individual privileges to users,
--  you can group related privileges into a role and grant this role to users.
-- What is a Role?
-- A role is a group of privileges. 
-- How to create Role?
--  Part I create role with or without password  
    --CREATE ROLE role_name
    --[IDENTIFIED BY password]
    --[NOT IDENTIFIED]
--  Part II Grant privileges Role
--    GRANT {system_privileges | object_privileges} TO role_name;
--  Part III Sometime you may like to assign one role previleges to another 
--    GRANT role_name TO another_role_name;
--   sys can be default user or sys can be sysdba
--######################################################
-- PART I master data management ROLE CALLED C##MDM
CREATE ROLE C##MDM; -- WITHOUT PASSWORD 
-- PART II
GRANT SELECT,INSERT,UPDATE,DELETE ON EMP TO C##MDM;
GRANT SELECT,INSERT,UPDATE,DELETE ON DEPT TO C##MDM;
GRANT SELECT,INSERT,UPDATE,DELETE ON BRANCH TO C##MDM;

CREATE USER c##alice identified by alice;
--Part III assign the role to the user
GRANT C##MDM TO c##alice;
Grant create session to c##alice;
commit;
--######################################################
open sqlplus
connect: c##alice
password:alice
SET ROLE C#MDM
select * from c##aduser.color;
select * from c##aduser.emp;
-- TRY TO CREATE SYNONYM FOR C##ADUSER.EMP AS EMP
CREATE SYNONYM EMP FOR C##ADUSER.EMP
-- ERROR: INSUFFICIENT PRIVILAGES
--CHECK THE ROLES ASSIGNED TO C##aLICE
SELECT * FROM SESSION_ROLES;

--######################################################
--######################################################
-- Create role with password , grant the permission and drop the role
--######################################################
--PART I ROLE WITH PASSWORD
CREATE ROLE C##JASMINE IDENTIFIED BY jasmine;
--PART II Grant select,insert,update,delete prviligest to c##jasmine on emp,dept,branch
GRANT SELECT,INSERT,UPDATE,DELETE ON EMP TO C##jasmine;
GRANT SELECT,INSERT,UPDATE,DELETE ON DEPT TO C##jasmine;
GRANT SELECT,INSERT,UPDATE,DELETE ON BRANCH TO C##jasmine;
--Part II drop the role c##jasmine
drop role c##jasmine;
--######################################################
-- Create a role with password to give select access 
-- let the role be reader
--######################################################
-- part I create role with password
CREATE ROLE C##READER IDENTIFIED BY reader;
-- Part II grant select on emp,dept,branch
GRANT SELECT ON EMP TO C##READER;
GRANT SELECT ON DEPT TO C##READER;
GRANT SELECT ON BRANCH TO C##READER;
--PART iii GRANT THIS ROLE TO C##USER
CREATE USER C##USER identified BY user;
Grant c##reader to c##user;
Grant create session to c##user;
connect c##user/user
set role c##reader identified by reader
GRANT C##READER TO C##ALICE;
Grant c##MDM to c##user;