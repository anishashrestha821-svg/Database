#TRANSACTION 
#1 Create a database named BankDB 
#and create a table accounts with the fields: account_id,
#account_holder, balance
create database BankDB;
use BankDB;
Create Table accounts(
account_id int primary key,
account_holder varchar(100),
balance decimal(10,2)
);
insert into accounts values
(1, 'Ram', 50000),
(2, 'Shyam', 30000),
(3, 'Sita', 20000);
#Write a transaction that transfers Rs. 5000 from 
#Ram's account to Shyam's account.
start transaction;
update accounts 
set balance = balance -5000
where account_holder = 'Ram';

update accounts 
set balance = balance +5000
where account_holder = 'Shyam';

commit;

select * from accounts;

start transaction;
update accounts 
set balance = balance -10000
where account_holder = 'Ram';

update accounts 
set balance = balance +10000
where account_holder = 'Shyam';

rollback;
#Write a transaction that demonstrates the use of 
#SAVEPOINT while updating account balances.
start transaction;
update accounts 
set balance = balance -2000
where account_holder = 'Ram';

SAVEPOINT sp1;
update accounts set balance = balance + 2000
where account_id = 2;
rollback to sp1;
commit;
#TRIGGERS 
#1 Create a table employees (
create table employees(
emp_id int primary key,
name varchar(100),
salary decimal(10, 2));

#2 Create another table salary_log to record employee 
#salary changes with fields: log_id, emp_id,
create table salary_log(
log_id INT PRIMARY KEY AUTO_INCREMENT,
emp_id INT,
old_salary DECIMAL(10, 2),
new_salary DECIMAL(10, 2),
change_date DATETIME
);

#create a BEFORE INSERT trigger on employees that prevents inserting employees whose salary is less than 10000.
Delimiter $$
create trigger check_salary 
before insert on employees
for each row
begin
if new.salary <10000 then
signal sqlstate '45000'
set message_text= "salary must be atleast 10000";

end if;
end $$

Delimiter ;

# Stored Procedure 
# Create a stored procedure getEmployees()

Delimiter $$
create procedure getEmployees()
begin
select * from employees ;
end $$
Delimiter ;

call getEmployees();

#Create a stored procedure that inserts 
#a new employee into the employees table using paramaters 

Delimiter $$
create procedure addEmployee(
IN p_id int,
IN p_name varchar(100),
IN p_salary decimal(10, 2))
begin 
insert into employees values(p_id, p_name, p_salary);
end $$
Delimiter ;
call addEmployee(5, 'Hari', 20000);

#Create a stored procedure that updates the salary of an employee based on employee ID
Delimiter $$
create procedure updateSalary(
in p_id int, in new_salary decimal(10, 2))
begin
update employees 
set salary = new_salary
where emp_id = p_id;
end $$

Delimiter ;
# Create a stored procedure that transfers koney between two accounts using a transactions
Delimiter $$
create procedure transferMoney(
in from_acc int, in to_account int,
in amount decimal)
begin
start transaction;
update accounts 
set balance = balance - amount 
where account_id = to_account;
commit;
end $$
Delimiter ;
call transferMoney(1, 2, 5000);





