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