CREATE TABLE "employees" (
  "emp_no" int PRIMARY KEY NOT NULL,
  "birth_date" date NOT NULL,
  "first_name" varchar NOT NULL,
  "last_name" varchar NOT NULL,
  "gender" varchar NOT NULL,
  "hire_date" date NOT NULL
);

CREATE TABLE "departments" (
  "dept_no" varchar PRIMARY KEY NOT NULL,
  "dept_name" varchar UNIQUE NOT NULL
);

CREATE TABLE "dept_emp" (
  "emp_no" int NOT NULL,
  "dept_no" varchar NOT NULL,
  "from_date" date NOT NULL,
  "to_date" date NOT NULL,
  PRIMARY KEY ("emp_no", "dept_no")
);

CREATE TABLE "dept_manager" (
  "dept_no" varchar PRIMARY KEY NOT NULL,
  "emp_no" int PRIMARY KEY NOT NULL,
  "from_date" date NOT NULL,
  "to_date" date NOT NULL
);

CREATE TABLE "titles" (
  "emp_no" int NOT NULL,
  "title" varchar NOT NULL,
  "from_date" date NOT NULL,
  "to_date" date NOT NULL,
  PRIMARY KEY ("emp_no", "from_date")
);

CREATE TABLE "salaries" (
  "emp_no" int PRIMARY KEY NOT NULL,
  "salary" int NOT NULL,
  "from_date" date NOT NULL,
  "to_date" date NOT NULL
);

ALTER TABLE "dept_emp" ADD FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD FOREIGN KEY ("dept_no") REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD FOREIGN KEY ("dept_no") REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no");
