/*Q.1*/
create database company_sql_test;
use company_sql_test;

/* Q2*/
create table departments (
    department_id int primary key,
    department_name varchar(100) not null,
    location varchar(100) not null
);

CREATE TABLE employees (
    employee_id int primary key,
    employee_name varchar(100) not null,
    department_id int not null ,
    salary decimal(10,2) not null,
    hire_date date not null,
    foreign key (department_id) references departments(department_id)
);


insert into departments
(department_id, department_name, location) values
(1, 'Human Resources', 'Pune'),
(2, 'IT', 'Mumbai'),
(3, 'Finance', 'Pune'),
(4, 'Marketing', 'Bangalore'),
(5, 'Research and Development', 'Hyderabad');


insert into employees(employee_id, employee_name, department_id, salary, hire_date) values
(101, 'miniii', 1, 65000, '2022-01-15'),
(102, 'poorva', 1, 72000, '2021-06-20'),
(103, 'tanvii', 2, 85000, '2020-03-10'),
(104, 'athrava', 2, 90000, '2019-08-25'),
(105, 'parth', 2, 75000, '2023-02-14'),
(106, 'pritii', 3, 68000, '2022-09-05'),
(107, 'sanket', 3, 80000, '2021-11-18'),
(108, 'sujal', 4, 55000, '2023-05-12'),
(109, 'arun', 4, 60000, '2022-07-30'),
(110, 'rohan', 4, 60000, '2024-01-10');

select * from employees;
select * from departments;



/* Q.3*/
alter table employees
add column  email varchar(150);

update employees
set email = 'minii15@gmail.com'
where employee_id = 101;

update employees
set email = 'poorva13@gmail.com'
where employee_id = 102;

update employees
set email = 'tanvii20@gmail.com'
where employee_id = 103;

update employees
set email = 'athrava@gmail.com'
where employee_id = 104;

update employees
SET email = 'parth@gmail.com'
WHERE employee_id = 105;

update employees
SET email = 'priti@gmail.com'
WHERE employee_id = 106;

update employees
set email = 'sanket@gmail.com'
where employee_id = 107;

update employees
set email = 'sujal@gmail.com'
where employee_id = 108;

update employees
set email = 'ashwini@gmail.com'
where employee_id = 109;

update employees
set email = 'priyal@gmail.com'
where employee_id = 110;

/* Q.4*/
alter table employees
add column status varchar(20) not null default 'Active';

update employees
set status = 'Inactive'
where employee_id = 105;


/*Q.5*/
select
    employee_id,
    employee_name,
    salary
from employees
where salary between 50000 and 90000
order by salary desc;


/*Q.6*/

select
    employee_id,
    employee_name,
    salary
from employees
where employee_name like 'A%';

select
    employee_id,
    employee_name,
    salary
from employees
where employee_name like '%r%';


/*Q.7*/
select
    d.department_name,
    count(e.employee_id) as employee_count
from departments d
left join employees e
    on d.department_id = e.department_id
group by 
    d.department_id,
    d.department_name
order by d.department_id;



/*Q.8*/
select 
    d.department_name,
    avg(e.salary) as average_salary
from departments d
inner join employees e
    on d.department_id = e.department_id
group by
    d.department_id,
    d.department_name
having avg(e.salary) > 70000;


/*Q.9*/
select
    e.employee_name,
    d.department_name,
    d.location,
    e.salary
from employees e
inner join  departments d
    on e.department_id = d.department_id;


/*Q.10*/
select
    employee_id,
    employee_name,
    salary
from employees
where salary > (
    select avg(salary)
    from employees
);


/*Q.11*/
select
    e.employee_id,
    e.employee_name,
    e.department_id,
    e.salary
from employees e
where e.salary > (
    select avg(e2.salary)
    from employees e2
    where e2.department_id = e.department_id
);

/*Q.12*/

select
    d.department_id,
    d.department_name,
    d.location
from departments d
where exists (
    select 1
    from employees e
    where e.department_id = d.department_id
);
select
    d.department_id,
    d.department_name,
    d.location
from departments d
where not exists (
    select 1
    from employees e
    where e.department_id = d.department_id
);

/*Q.13*/
SELECT
    employee_id,
    employee_name,
    department_id,
    salary,
    DENSE_RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

/*Q.14*/
WITH ranked_employees AS (
    SELECT
        employee_id,
        employee_name,
        department_id,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
)

SELECT
    employee_id,
    employee_name,
    department_id,
    salary,
    salary_rank
FROM ranked_employees
WHERE salary_rank <= 2
ORDER BY department_id, salary DESC;


/*Q.15*/
WITH department_average AS (
    SELECT
        department_id,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department_id
)

SELECT
    e.employee_id,
    e.employee_name,
    e.department_id,
    e.salary,
    da.average_salary
FROM employees e
INNER JOIN department_average da
    ON e.department_id = da.department_id
WHERE e.salary > da.average_salary;


CREATE VIEW employee_department_report AS
SELECT
    e.employee_name,
    d.department_name,
    e.salary,
    d.location
FROM employees e
INNER JOIN departments d
    ON e.department_id = d.department_id;


SELECT *
FROM employee_department_report;



