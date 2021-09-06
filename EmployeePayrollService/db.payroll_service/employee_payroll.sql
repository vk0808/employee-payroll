-- uc-1

-- To Create a database
CREATE DATABASE payroll_service

-- To see the DB created
EXEC sp_databases
--SELECT * FROM sys.databases;

-- To go to the database created
USE payroll_service

---------------------------------------------------------------

-- uc-2
-- To go to the database created
USE payroll_service

-- To create a table
CREATE TABLE employee_payroll(
	EmployeeID INT IDENTITY(1, 1) PRIMARY KEY,
	EmployeeName VARCHAR(255)  NOT NULL,
	Salary DECIMAL NOT NULL,
	StartDate DATE  NOT NULL
);


---------------------------------------------------------------

-- uc-3
-- To go to the database created
USE payroll_service

-- To insert into the table created
INSERT INTO employee_payroll(EmployeeName, Salary, StartDate) 
VALUES
('Bill', 1000000.00, '2021-09-02'),
('Terisha', 2000000.00, '2021-09-02'),
('Charlie', 3000000.00, '2021-09-02');

---------------------------------------------------------------

-- uc-4
-- To go to the database created
USE payroll_service

-- To select all records from table
SELECT * FROM employee_payroll;

---------------------------------------------------------------

-- uc-5
-- To go to the database created
USE payroll_service

-- To select particular records from table
SELECT Salary FROM employee_payroll WHERE EmployeeName = 'Bill';
SELECT Salary FROM employee_payroll WHERE StartDate BETWEEN CAST('2021-01-01' AS DATE) AND GETDATE();

---------------------------------------------------------------

-- uc-6
-- To go to the database created
USE payroll_service

-- To alter table by adding gender and then update records
ALTER TABLE employee_payroll ADD Gender VARCHAR(1);
UPDATE employee_payroll SET Gender = 'F' WHERE Name = 'Terisha';
UPDATE employee_payroll SET Gender = 'M' WHERE Name = 'Bill' OR Name = 'Charlie';

---------------------------------------------------------------

-- uc-7
-- To go to the database created
USE payroll_service

-- To perform sum, average, min, max operations on the table records
SELECT SUM(Salary) AS 'TotalSalary' FROM employee_payroll WHERE Gender='M' GROUP BY Gender;
SELECT SUM(Salary) AS 'TotalSalary'FROM employee_payroll GROUP BY Gender;
SELECT SUM(Salary) AS 'TotalSalary', Gender FROM employee_payroll GROUP BY Gender;
SELECT AVG(Salary) AS 'AverageSalary', Gender FROM employee_payroll GROUP BY Gender;
SELECT MIN(Salary) AS 'MinimumSalary', Gender FROM employee_payroll GROUP BY Gender;
SELECT MAX(Salary) AS 'MaximumSalary', Gender FROM employee_payroll GROUP BY Gender;

SELECT COUNT(Gender) AS 'Male', COUNT(Gender) AS 'Female' FROM employee_payroll WHERE Gender='M';