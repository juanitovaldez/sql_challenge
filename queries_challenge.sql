-- List of all columns in employees:
SELECT emp_no, birth_date, first_name, last_name, gender, hire_date
	FROM public.employees

--List the following details of each employee: employee number, 
    --last name, first name, gender, and salary.

CREATE OR REPLACE VIEW employee_profile AS	
    SELECT employees.emp_no
        , employees.first_name
        , employees.last_name
        , employees.gender
        , salaries.salary
    FROM salaries RIGHT JOIN employees 
        ON (salaries.emp_no=employees.emp_no)
        ORDER BY salaries.salary;

SELECT employees.emp_no
    , employees.first_name
    , employees.last_name
    , employees.gender
    , salaries.salary
FROM employees LEFT JOIN salaries 
	ON (salaries.emp_no=employees.emp_no)
	ORDER BY salaries.salary;

--List employees who were hired in 1986.
CREATE OR REPLACE VIEW hires_1986 AS
    SELECT employees.first_name, employees.last_name, employees.hire_date
    FROM employees 
        WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
        ORDER BY hire_date;

--List the manager of each department with the following information:
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
-- From employees we will take the name and number, from departments we'll take the name 
-- and department number. Since two of the columns in the dept_manager table appear
-- in employees and departments we wan use joins to tack our columns together around our list of managers
-- I read somewhere that for performance reasons, you want the table on the From side of things to be the smaller table.m
CREATE OR REPLACE VIEW dept_manager_profile AS
    SELECT employees.first_name, employees.last_name, employees.emp_no,
        departments.dept_no, departments.dept_name,
        dept_manager.from_date, dept_manager.to_date
-- dept_manager has an emp_no that should match up with the emp_no ;
-- likewise for departments and dept_no
    FROM dept_manager JOIN employees ON (dept_manager.emp_no = employees.emp_no)
                    JOIN departments ON (dept_manager.dept_no = departments.dept_no)
                    ORDER BY departments.dept_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.
-- Or put another way: List each employee with their fn, ln, emp_no, and dept_name. This is the same querry as above with different tables:
CREATE OR REPLACE VIEW employee_department AS
    SELECT  employees.emp_no, employees.first_name, employees.last_name,
            departments.dept_name,
            dept_emp.dept_no
    FROM dept_emp JOIN employees ON (dept_emp.emp_no = employees.emp_no)
                JOIN departments ON (dept_emp.dept_no = departments.dept_no)
        ORDER BY employees.emp_no;

--List all employees whose first name is "Hercules" and last names begin with "B."
CREATE OR REPLACE VIEW herucles_b AS
    SELECT employees.first_name, employees.last_name
        FROM employees
        WHERE employees.first_name = "Hercules" AND employees.last_name LIKE "B%";

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
CREATE OR REPLACE VIEW sales_team AS
    SELECT employees.emp_no, employees.last_name, employees.first_name,
           departments.dept_name,
           salaries.salary
    FROM dept_emp JOIN employees ON (dept_emp.emp_no = employees.emp_no)
				  JOIN departments ON (dept_emp.dept_no = departments.dept_no)
                  JOIN salaries ON (dept_emp.emp_no = salaries.emp_no)
				  WHERE departments.dept_name = 'Sales'
				  ORDER BY salaries.salary;

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
CREATE OR REPLACE VIEW sales_dev_team AS
    SELECT employees.emp_no, employees.last_name, employees.first_name,
           departments.dept_name,
           salaries.salary
    FROM dept_emp JOIN employees ON (dept_emp.emp_no = employees.emp_no)
				  JOIN departments ON (dept_emp.dept_no = departments.dept_no)
                  JOIN salaries ON (dept_emp.emp_no = salaries.emp_no)
				  WHERE departments.dept_name = 'Development' OR departments.dept_name='Sales'
				  ORDER BY salaries.salary;
                  
--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
CREATE OR REPLACE VIEW last_name_freq AS
    SELECT employees.last_name,
           COUNT(employees.last_name) AS ln_count
    FROM employees GROUP BY last_name
    ORDER BY ln_count ASC;
--Hey lookit that! April Fools :)

-- Bonus Salary
 SELECT employees.emp_no,
    employees.last_name,
    employees.first_name,
    departments.dept_name,
    salaries.salary
   FROM dept_emp
     JOIN employees ON dept_emp.emp_no = employees.emp_no
     JOIN departments ON dept_emp.dept_no::text = departments.dept_no::text
     JOIN salaries ON dept_emp.emp_no = salaries.emp_no
  WHERE departments.dept_name::text = 'Sales'::text
  ORDER BY salaries.salary;