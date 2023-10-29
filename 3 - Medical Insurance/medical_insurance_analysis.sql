show databases;
use insurance;
show tables;
select * from insurance_data;

-- 1. Select all columns for all patients
select * from insurance_data;

-- 2. Display the average charges for patients in each region
select region, avg(charges) as avg_charges from insurance_data group by region;

-- 3. Select the maximum and minimum BMI values in the table
select max(bmi) as max_bmi, min(bmi) as min_bmi from insurance_data;

-- 4. Select the patientID, age and BMI for patients with a BMI between 40 and 50 
select patientID, age, BMI from insurance_data where BMI>=40 and BMI<=50;

-- 5. Select the number of smokers in each region
select region,count(*) from insurance_data where smoker='Yes' group by region;

-- 6. What is the average charges for patients who are both male and smokers?
select avg(charges) from insurance_data where sex='male' and smoker='Yes';

 -- 7. Retrieve all patients who have a BMI greater that the average BMI of patients who are smokers
 select * from insurance_data where smoker='Yes' and BMI > (select avg(BMI) from insurance_data where smoker='Yes'); 
 
 -- 8. Select the average charges for patients in each age group
 -- Creating age groups
 select
	case when age<18 then 'Under 18'
    when age between 18 and 30 then '18-30'
    when age between 31 and 50 then '31-50'
    else 'Over 50'
end as age_group,
round(avg(charges),2) as avg_charges
from insurance_data
group by age_group;

-- 9. Retrieve the total charges for each patient along with the average charges across all patients
select patientID, sum(charges) over(partition by patientID) as total_charges,
avg(charges) over() as avg_charges from insurance_data; -- here over() is a window function

-- 10. Retrieve the top 3 patients with the highest charges, along with their respective charges and 
-- the total charges for all patients
select patientID, charges, sum(charges) over() as total_charges 
from insurance_data order by charges desc limit 3;

-- 11. Select the details of patients who have charges greater than the average charges for their region
-- Using correlated subqueries
select * from insurance_data t1 -- Here, t1 and t2 are like names for queries
where charges > (select avg(charges) from insurance_data t2 where t2.region = t1.region);

-- Using window function
select * from (select *, avg(charges) over(partition by region) as avg_charges from insurance_data) as subquery
where charges > avg_charges;

-- 12. Retrieve the rank of each patient based on their charges
select *, rank() over(order by charges desc) as rank_by_charges from insurance_data; 
	
-- 13. Select the details of patients along with their charges and their ranks based on their charges 
-- within their region
select *, rank() over(partition by region order by charges desc) as rank_by_charges from insurance_data; 