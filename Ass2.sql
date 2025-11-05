CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);


CREATE TABLE Professors (
    prof_id INT PRIMARY KEY,
    prof_fname VARCHAR(50),
    prof_lname VARCHAR(50),
    dept_id INT,
    designation VARCHAR(50),
    salary DECIMAL(10,2),
    doj DATE,
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50),       
    foreign key (dept_id) references Departments(dept_id)
    on delete cascade
);   



CREATE TABLE Works (
    prof_id INT,
    dept_id INT,
    duration INT,
    foreifn key (prof_id) references Professors(prof_id)
    on delete cascade
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
    ON DELETE CASCADE
)


