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

---------------------------------------------------------------

-- uc-8
-- To go to the database created
USE payroll_service

-- To extend the current table with default address
ALTER TABLE employee_payroll
ADD 
PhoneNumber VARCHAR(50),
Address VARCHAR(50) CONSTRAINT df_payroll_service_Address DEFAULT 'TBD',
Department VARCHAR(50);

---------------------------------------------------------------

-- uc-9
-- To go to the database created
USE payroll_service

-- To rename salary column to basicPay
EXEC sp_rename 'employee_payroll.Salary' , 'BasicPay';

-- To extend the current table with default address
ALTER TABLE employee_payroll
ADD
Deduction DECIMAL,
TaxablePay DECIMAL,
IncomeTax DECIMAL,
NetPay DECIMAL;

---------------------------------------------------------------

-- uc-10
-- To go to the database created
USE payroll_service

-- To update existing record with department
UPDATE employee_payroll SET Department = 'Sales', BasicPay = 3000000.00  WHERE EmployeeName = 'Terisha';

-- To insert new record
INSERT INTO employee_payroll VALUES
('Terisha',3000000.00,'2020-08-14','F','1234567890','India','Marketing',1000000.00,2000000.00,500000.00,1500000.00);

---------------------------------------------------------------

-- uc-11
-- To go to the database created
USE payroll_service

-- To create a table - department
CREATE TABLE department(
	DepartmentID INT IDENTITY(1, 1) PRIMARY KEY,
	DepartmentName VARCHAR(255)  NOT NULL
);

-- To create a table - company
CREATE TABLE company(
	CompanytID INT IDENTITY(1, 1) PRIMARY KEY,
	CompanyName VARCHAR(255)  NOT NULL
);

-- To create a table - employee
CREATE TABLE employee(
	EmployeeID INT IDENTITY(1, 1) PRIMARY KEY,
	EmployeeName VARCHAR(255)  NOT NULL,
	PhoneNumber VARCHAR(50),
	Address VARCHAR(50) CONSTRAINT df_payroll_service_Address DEFAULT 'TBD', 
	Gender VARCHAR(1),
	CompanyID INT NOT NULL FOREIGN KEY REFERENCES company(CompanytID),
	StartDate DATE  NOT NULL
);

-- To create a table - payroll
CREATE TABLE payroll(
	EmployeeID INT FOREIGN KEY REFERENCES employee(EmployeeID),
	Deduction DECIMAL,
	TaxablePay DECIMAL,
	IncomeTax DECIMAL,
	NetPay DECIMAL
);

-- To create a table - employee_department
CREATE TABLE employee_department(
	EmployeeID INT NOT NULL FOREIGN KEY REFERENCES employee(EmployeeID),
	DepartmentID INT NOT NULL FOREIGN KEY REFERENCES department(DepartmentID),
);

---------------------------------------------------------------

-- uc-12
-- To go to the database created
USE payroll_service


-- To alter table
ALTER TABLE payroll
ADD BasicPay DECIMAL NOT NULL;

-- uc-4 
SELECT  p.BasicPay, e.EmployeeName FROM payroll p INNER JOIN Employee e on p.EmployeeId=e.EmployeeId WHERE e.EmployeeName='Bill';
-- uc-5
SELECT SUM(p.BasicPay) AS "sum",e.Gender FROM payroll p INNER JOIN Employee e on p.EmployeeId=e.EmployeeId GROUP BY Gender;
SELECT MAX(p.BasicPay) AS "maxSalary",e.Gender FROM payroll p INNER JOIN Employee e on p.EmployeeId=e.EmployeeId GROUP BY Gender;
SELECT MIN(p.BasicPay) AS "minSalary",e.Gender FROM payroll p INNER JOIN Employee e on p.EmployeeId=e.EmployeeId GROUP BY Gender;
SELECT AVG(p.BasicPay) AS "averageSalry",e.Gender FROM payroll p INNER JOIN Employee e on p.EmployeeId=e.EmployeeId GROUP BY Gender;
SELECT COUNT(p.BasicPay) AS "count",e.Gender FROM payroll p INNER JOIN Employee e on p.EmployeeId=e.EmployeeId GROUP BY Gender;
-- uc-7
SELECT e.EmployeeName, e.StartDate, e.Gender, e.PhoneNumber, e.Address, c.CompanyName, s.BasicPay FROM employee as e  INNER JOIN company AS c ON CompanyID=c.CompanytID
INNER JOIN payroll AS s ON e.EmployeeID=s.EmployeeID INNER JOIN department AS d on d.DepartmentID=e.EmployeeID INNER JOIN employee_department as ed on ed.DepartmentID=d.DepartmentID;