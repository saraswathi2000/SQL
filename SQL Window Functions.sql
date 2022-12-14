CREATE OR REPLACE TABLE EMPLOYEE
(
   EMPID INTEGER NOT NULL PRIMARY KEY,
   EMP_NAME VARCHAR2(20),
   JOB_ROLE STRING,
   SALARY NUMBER(10,2)
);

INSERT INTO EMPLOYEE
VALUES('101','ANAND JHA','Analyst',50000);

INSERT INTO EMPLOYEE
VALUES(102,'ALex', 'Data Enginner',60000);

INSERT INTO EMPLOYEE
VALUES(103,'Ravi', 'Data Scientist',48000);

INSERT INTO EMPLOYEE
VALUES(104,'Peter', 'Analyst',98000);

INSERT INTO EMPLOYEE
VALUES(105,'Pulkit', 'Data Scientist',72000);

INSERT INTO EMPLOYEE
VALUES(106,'Robert','Analyst',100000);

INSERT INTO EMPLOYEE
VALUES(107,'Rishabh','Data Engineer',67000);

INSERT INTO EMPLOYEE
VALUES(108,'Subhash','Manager',148000);

INSERT INTO EMPLOYEE
VALUES(109,'Michaeal','Manager',213000);

INSERT INTO EMPLOYEE
VALUES(110,'Dhruv','Data Scientist',89000);

INSERT INTO EMPLOYEE
VALUES(111,'Amit Sharma','Analyst',72000);

DELETE FROM EMPLOYEE WHERE EMPID = 110;

SELECT * FROM EMPLOYEE;

update employee set job_role='Data Engineer'
where empid=102;

update employee set salary= 50000
where empid=104;
  
 
-------------------------------------------------------------WINDOW FUNCTIONS------------------------------------------------------------

-- SYNTAX : window_function_name(<exprsn>) OVER (<partition_by_clause> <order_clause>)

--- display total salary based on job profile
SELECT JOB_ROLE,SUM(SALARY) FROM EMPLOYEE 
GROUP BY JOB_ROLE;

-- display total salary along with all the records ()every row value 
SELECT * , SUM(SALARY) OVER() AS TOT_SALARY
FROM EMPLOYEE;

-- display the total salary per job category for all the rows 
SELECT *,MAX(SALARY) OVER(PARTITION BY JOB_ROLE) AS MAX_JOB_SAL
FROM EMPLOYEE;

select *,max(salary) over(partition by JOB_ROLE) as MAX_SAL , 
min(salary) over(partition by JOB_ROLE) as MIN_SAL,
SUM(salary) over(partition by JOB_ROLE) as TOT_SAL
from Employee;



--ARRANGING ROWS WITHIN EACH PARTITION BASED ON SALARY IN DESC ORDDER
select *,max(salary) over(partition by JOB_ROLE ORDER BY SALARY DESC) as MAX_SAL , 
min(salary) over(partition by JOB_ROLE ORDER BY SALARY DESC) as MIN_SAL,
SUM(salary) over(partition by JOB_ROLE ORDER BY SALARY DESC) as TOT_SAL
from Employee;

-- ROW_NUMBER() It assigns a unique sequential number to each row of the table ...
SELECT * FROM 
(
SELECT *,ROW_NUMBER() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY DESC) AS PART_ROW_NUM 
FROM EMPLOYEE 
)
WHERE PART_ROW_NUM <=2;

/* The RANK() window function, as the name suggests, ranks the rows within their partition based on the given condition.
   In the case of ROW_NUMBER(), we have a sequential number. 
   On the other hand, in the case of RANK(), we have the same rank for rows with the same value.
But there is a problem here. Although rows with the same value are assigned the same rank, the subsequent rank skips the missing rank. 
This wouldn’t give us the desired results if we had to return “top N distinct” values from a table. 
Therefore we have a different function to resolve this issue. */

SELECT *,ROW_NUMBER() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY DESC) AS ROW_NUM ,
RANK() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY DESC) AS RANK_ROW
FROM EMPLOYEE;

/* The DENSE_RANK() function is similar to the RANK() except for one difference, it doesn’t skip any ranks when ranking rows
Here, all the ranks are distinct and sequentially increasing within each partition. 
As compared to the RANK() function, it has not skipped any rank within a partition. */

SELECT * FROM 
(
SELECT *,ROW_NUMBER() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY) AS ROW_NUM ,
RANK() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY) AS RANK_ROW,
DENSE_RANK() OVER(PARTITION BY JOB_ROLE ORDER BY SALARY) AS DENSE_RANK_ROW 
FROM EMPLOYEE  
)
WHERE DENSE_RANK_ROW <=2;























