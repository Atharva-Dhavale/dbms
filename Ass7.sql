-- Step 1️⃣: Create main table
CREATE TABLE viv (
    Book_ID INT PRIMARY KEY,
    Book_Name VARCHAR(50),
    Author VARCHAR(50),
    Price DECIMAL(8,2)
);

-- Step 2️⃣: Create audit table
CREATE TABLE audit_viv (
    Audit_ID INT AUTO_INCREMENT PRIMARY KEY,
    Book_ID INT,
    Book_Name VARCHAR(50),
    Author VARCHAR(50),
    Price DECIMAL(8,2),
    Action_Type VARCHAR(30),
    Action_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table audit_vi (

    audit_id int auto_increment primary key,
    book_id int ,
    book_namr varchar(50),
    author varchar(50),
    price decimal(8,2),
    action_type varchar(30),
    action_date timestamp default CURRENT_TIMESTAMP
)
-- Step 3️⃣: BEFORE INSERT Trigger
DELIMITER //
CREATE TRIGGER before_insert_viv
BEFORE INSERT ON viv
FOR EACH ROW
BEGIN
    INSERT INTO audit_viv (Book_ID, Book_Name, Author, Price, Action_Type)
    VALUES (NEW.Book_ID, NEW.Book_Name, NEW.Author, NEW.Price, 'BEFORE INSERT');
END;
//
DELIMITER ;

-- Step 4️⃣: AFTER INSERT Trigger
DELIMITER //
CREATE TRIGGER after_insert_viv
AFTER INSERT ON viv
FOR EACH ROW
BEGIN
    INSERT INTO audit_viv (Book_ID, Book_Name, Author, Price, Action_Type)
    VALUES (NEW.Book_ID, NEW.Book_Name, NEW.Author, NEW.Price, 'AFTER INSERT');
END;
//
DELIMITER ;

-- Step 5️⃣: BEFORE UPDATE Trigger
DELIMITER //
CREATE TRIGGER before_update_viv
BEFORE UPDATE ON viv
FOR EACH ROW
BEGIN
    INSERT INTO audit_viv (Book_ID, Book_Name, Author, Price, Action_Type)
    VALUES (OLD.Book_ID, OLD.Book_Name, OLD.Author, OLD.Price, 'BEFORE UPDATE');
END;
//
DELIMITER ;

-- Step 6️⃣: AFTER UPDATE Trigger
DELIMITER //
CREATE TRIGGER after_update_viv
AFTER UPDATE ON viv
FOR EACH ROW
BEGIN
    INSERT INTO audit_viv (Book_ID, Book_Name, Author, Price, Action_Type)
    VALUES (NEW.Book_ID, NEW.Book_Name, NEW.Author, NEW.Price, 'AFTER UPDATE');
END;
//
DELIMITER ;

-- Step 7️⃣: BEFORE DELETE Trigger
DELIMITER //
CREATE TRIGGER before_delete_viv
BEFORE DELETE ON viv
FOR EACH ROW
BEGIN
    INSERT INTO audit_viv (Book_ID, Book_Name, Author, Price, Action_Type)
    VALUES (OLD.Book_ID, OLD.Book_Name, OLD.Author, OLD.Price, 'BEFORE DELETE');
END;
//
DELIMITER ;

-- Step 8️⃣: AFTER DELETE Trigger
DELIMITER //
CREATE TRIGGER after_delete_viv
AFTER DELETE ON viv
FOR EACH ROW
BEGIN
    INSERT INTO audit_viv (Book_ID, Book_Name, Author, Price, Action_Type)
    VALUES (OLD.Book_ID, OLD.Book_Name, OLD.Author, OLD.Price, 'AFTER DELETE');
END;
//
DELIMITER ;


INSERT INTO viv VALUES (1, 'DBMS', 'Korth', 500.00);
UPDATE viv SET Price = 600.00 WHERE Book_ID = 1;

DELETE FROM viv WHERE Book_ID = 1;

SELECT * FROM audit_viv;

