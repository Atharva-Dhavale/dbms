CREATE TABLE Stud_Marks (
    Roll INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50),
    Total_Marks INT
);

CREATE TABLE Result (
    Roll INT,
    Name VARCHAR(50),
    Class VARCHAR(30)
);


INSERT INTO Stud_Marks (Name, Total_Marks) VALUES
('Amit', 1450),
('Sneha', 950),
('Rohit', 880),
('Kiran', 830),
('Meena', 810);


DELIMITER $$

-- create function fngrade(marks int) 


CREATE FUNCTION fn_Grade(marks INT)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(30);

    IF marks BETWEEN 990 AND 1500 THEN
        SET category = 'Distinction';
    ELSEIF marks BETWEEN 900 AND 989 THEN
        SET category = 'First Class';
    ELSEIF marks BETWEEN 825 AND 899 THEN
        SET category = 'Higher Second Class';
    ELSE
        SET category = 'Fail';
    END IF;

    RETURN category;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE proc_Grade()
BEGIN
    -- Remove old results (optional)
    DELETE FROM Result;

    -- Insert categorized results using function
    INSERT INTO Result (Roll, Name, Class)
    SELECT Roll, Name, fn_Grade(Total_Marks)
    FROM Stud_Marks;
END $$

DELIMITER ;







assign 5
-- Step 1️⃣: Create Tables
CREATE TABLE student_score(
  student_name VARCHAR(30),
  total_score INT
);

CREATE TABLE final_result(
  id INT AUTO_INCREMENT PRIMARY KEY,
  student_name VARCHAR(30),
  grade_category VARCHAR(30)
);

-- Step 2️⃣: Insert Sample Data
INSERT INTO student_score (student_name, total_score) VALUES 
('Anita', 1200),
('Bhavesh', 950),
('Chirag', 1350),
('Divya', 1100),
('Esha', 800),
('Farhan', 1450),
('Gaurav', 1275),
('Harini', 1380),
('Irfan', 890),
('Juhi', 1500);

-- Step 3️⃣: Create Procedure with Validation, Exception Handling & Table Insert
DELIMITER //

CREATE PROCEDURE assign_Grade(
    IN stu_name VARCHAR(50),
    IN stu_score INT
)
BEGIN
    DECLARE grade_type VARCHAR(30);
    DECLARE invalid_score CONDITION FOR SQLSTATE '45000';

    -- Custom error handler for invalid marks
    DECLARE EXIT HANDLER FOR invalid_score
    BEGIN
        SELECT CONCAT('⚠ Error: Invalid score for student ', stu_name) AS message;
    END;

    -- SQL exception handler (runtime errors)
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT CONCAT('⚠ Error: Failed to insert record for ', stu_name) AS message;
    END;

    -- Validate score
    IF stu_score IS NULL OR stu_score < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Score cannot be negative or null';
    END IF;

    -- Grade classification logic
    IF stu_score BETWEEN 990 AND 1500 THEN
        SET grade_type = 'Distinction';
    ELSEIF stu_score BETWEEN 900 AND 989 THEN
        SET grade_type = 'First Class';
    ELSEIF stu_score BETWEEN 825 AND 899 THEN
        SET grade_type = 'Higher Second Class';
    ELSE
        SET grade_type = 'Fail';
    END IF;

    -- Insert the computed grade into result table
    INSERT INTO final_result (student_name, grade_category)
    VALUES (stu_name, grade_type);

    -- Display confirmation message
    SELECT CONCAT('✅ Record added for ', stu_name, ' with grade: ', grade_type) AS message;
END;
//

DELIMITER ;

-- Step 4️⃣: Create Equivalent Function (for evaluation purposes)
DELIMITER //

CREATE FUNCTION get_Grade(stu_score INT)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    DECLARE grade_type VARCHAR(30);

    IF stu_score IS NULL OR stu_score < 0 THEN
        SET grade_type = 'Error: Invalid Score';
    ELSEIF stu_score BETWEEN 990 AND 1500 THEN
        SET grade_type = 'Distinction';
    ELSEIF stu_score BETWEEN 900 AND 989 THEN
        SET grade_type = 'First Class';
    ELSEIF stu_score BETWEEN 825 AND 899 THEN
        SET grade_type = 'Higher Second Class';
    ELSE
        SET grade_type = 'Fail';
    END IF;

    RETURN grade_type;
END;
//

DELIMITER ;

-- Step 5️⃣: Execute Procedure Examples
CALL assign_Grade('Anita', 1200);    -- Valid
CALL assign_Grade('Bhavesh', -20);   -- Invalid marks
CALL assign_Grade('Esha', 800);      -- Fail case

-- Step 6️⃣: Check Result Table
SELECT * FROM final_result;

-- Step 7️⃣: Using Function for Direct Query Output
SELECT student_name, total_score, get_Grade(total_score) AS Grade
FROM student_score;