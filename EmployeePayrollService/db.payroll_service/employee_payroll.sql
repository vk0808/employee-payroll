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
-- To create a table
CREATE TABLE employee_payroll(
	EmployeeID INT IDENTITY(1, 1) PRIMARY KEY,
	EmployeeName VARCHAR(255)  NOT NULL,
	Salary DECIMAL NOT NULL,
	StartDate DATE  NOT NULL
);
