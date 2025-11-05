CREATE TABLE Borrower (
    Roll_no INT PRIMARY KEY,
    Name VARCHAR(50),
    DateofIssue DATE,
    NameofBook VARCHAR(50),
    Status CHAR(1)
);

CREATE TABLE Fine (
    Roll_no INT,
    Date DATE,
    Amt DECIMAL(10,2),
    FOREIGN KEY (Roll_no) REFERENCES Borrower(Roll_no)
);

INSERT INTO Borrower VALUES
(1, 'Ravi', '2025-10-01', 'DBMS', 'I'),
(2, 'Sneha', '2025-09-25', 'CN', 'I'),
(3, 'Amit', '2025-09-10', 'OS', 'I');

DELIMITER $$

CREATE PROCEDURE ReturnBook(
    IN p_Roll_no INT,
    IN p_BookName VARCHAR(50),
    IN p_ReturnDate DATE
)
BEGIN
    DECLARE v_DateOfIssue DATE;
    DECLARE v_Days INT;
    DECLARE v_Fine DECIMAL(10,2) DEFAULT 0.0;
    DECLARE not_found CONDITION FOR SQLSTATE '02000';
    
    DECLARE EXIT HANDLER FOR not_found
    BEGIN
        SELECT 'Record not found for given Roll_no and Book Name' AS ErrorMessage;
    END;

    SELECT DateofIssue INTO v_DateOfIssue
    FROM Borrower
    WHERE Roll_no = p_Roll_no AND NameofBook = p_BookName;

    SET v_Days = DATEDIFF(p_ReturnDate, v_DateOfIssue);

    IF v_Days < 15 THEN
        SET v_Fine = 0;
    ELSEIF v_Days BETWEEN 15 AND 30 THEN
        SET v_Fine = (v_Days - 14) * 5;
    ELSEIF v_Days > 30 THEN
        SET v_Fine = (v_Days - 30) * 50 + (30 - 14) * 5;
    END IF;

    UPDATE Borrower
    SET Status = 'R'
    WHERE Roll_no = p_Roll_no AND NameofBook = p_BookName;

    IF v_Fine > 0 THEN
        INSERT INTO Fine (Roll_no, Date, Amt)
        VALUES (p_Roll_no, p_ReturnDate, v_Fine);
    END IF;

    SELECT CONCAT('Book Returned. Total days: ', v_Days, ', Fine: Rs ', v_Fine) AS Result;
END$$

DELIMITER ;

CALL ReturnBook(1, 'DBMS', '2025-10-20');





delimiter //
CREATE PROCEDURE ReturnBook(
    IN p_Roll_no INT,
    IN p_BookName VARCHAR(50),
    IN p_ReturnDate DATE
)
BEGIN
    DECLARE v_DateOfIssue DATE;
    DECLARE v_Days INT;
    DECLARE v_fine DECIMAL(10,2) DEFAULT 0.0;
    DECLARE not_found CONDITION FOR SQLSTATE '02000';


    DECLARE EXIT HANDLER FOR not_found
    BEGIN
        SELECT 'Record not found for given Roll_no and Book Name' AS ErrorMessage;
    END;

    
   
    

    SELECT DateofIssue INTO v_DateOfIssue
    FROM Borrower
    WHERE Roll_no = p_Roll_no AND NameofBook = p_BookName;

    set v_Days = DATEDIFF(p_ReturnDate , v_DateOfIssue);

    if v_days < 15 then         
        set v_fine  = 0;
    elseif v_days BETWEEN 15 and 30 then 
        set v_fine = (v_Days - 14) * 5;
    elseif v_Days > 30 then 
        set v_fine = (v_Days - 30) * 50 +(30 - 14) * 5;
    end if;

    update Borrower
    set Status = 'R'
    where Roll_no = p_Roll_no and NameofBook = p_BookName;
    if v_fine > 0 then 
        insert into Fine (Roll_no , Date , Amt) values (p_Roll_no, p_ReturnDate, v_fine);
    End if;

    end //
    DELIMITER ;

    call ReturnBook(1, 'DBMS' , '2025-10-20');

