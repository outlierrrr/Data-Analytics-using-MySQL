show databases;
use data_new;
show tables;
select * from salaries;

-- 1. Show all columns and rows in the table
select * from salaries;

-- 2. Show only EmployeeName and JobTitle columns
select EmployeeName,JobTitle from salaries;

-- 3. Show the number of employees in the table
select count(*) from salaries;

-- 4. Show the unique job titles in the table
select distinct JobTitle from salaries;

-- 5. Show the number of unique job titles in the table
select count(distinct JobTitle) from salaries;

-- 6. Show the job title and overtime pay for all employee with 
-- overtime pay greater than 50000
select JobTitle,OvertimePay from salaries
where OvertimePay>50000;

-- 7. Show the average basepay for all the employees
select avg(BasePay) as "Avg BasePay" from salaries; 
#Here 'as' command is used as aliasing to give some meaningful name to the output

-- 8. Show the top 10 highest paid employees
select EmployeeName,TotalPay from salaries
order by TotalPay
limit 10;
#This throws output in ascending order of TotalPay
#For descending order, we shall use
select EmployeeName,TotalPay from salaries
order by TotalPay desc
limit 10;

-- 9. Show the average of BasePay, OvertimePay and OtherPay for each employee
select EmployeeName, (BasePay+OvertimePay+OtherPay)/3 as avg_bp_ovtp_otp from salaries;

-- 10. Show all employees having Job Title as 'Manager'
select EmployeeName,JobTitle from salaries
where JobTitle like '%Manager%';
#'like' command/operator is used to perform a partial match on the 'JobTitle' column
#'%' sign is called 'char' character, which matches any sequence of characters 

-- 11. Show all employees with a job title not equal to 'manager'
select EmployeeName,JobTitle from salaries
where JobTitle <>'Manager';
#Here, '!=' and '<>' stands for 'not equal to'

-- 12. Show all employees with a total pay between 50,000 and 75,000
select * from salaries
where TotalPay between 50000 and 75000;
#or you may use
select * from salaries
where TotalPay>=50000 and TotalPay<=75000;

-- 13. Show all employees with a basepay less than 50000 or a total pay greater than 100000
select * from salaries
where BasePay<50000 or TotalPay>100000;

-- 14. Show all employees with a total pay benefits values between 125000 and 150000
-- and a job title containing the word 'Director'
select * from salaries 
where TotalPayBenefits between 125000 and 150000
and JobTitle like '%Director';

-- 15. Show all employees ordered by their total pay benefits in descencing order
select * from salaries
order by TotalPayBenefits desc;

-- 16. Show all Job titles with an average basepay of at least 100000 and order them by the average
-- base pay in descending order
select JobTitle, avg(BasePay) as avg_bp from salaries
group by JobTitle
having avg_bp>=100000
order by avg_bp desc;

-- 17. Delete a column from the table
alter table salaries
drop column Notes;
select * from salaries;

-- 18. Update the basepay of all employees with the job title containing 'Manager' by increasing it by 10%
update salaries
set BasePay = BasePay*1.1
where JobTitle like '%Manager%';

-- 19. Delete all employees having no OverTimePay. (Note:- this command makes permanent changes)
select count(*) from salaries
where OvertimePay=0;
delete from salaries
where OvertimePay=0;
