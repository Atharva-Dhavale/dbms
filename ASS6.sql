CREATE TABLE O_RollCall (
    RollNo INT PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE N_RollCall (
    RollNo INT,
    Name VARCHAR(50)
);



DELIMITER $$

CREATE PROCEDURE Merge_RollCall(IN roll_limit INT)
BEGIN
    -- Declare variables
    DECLARE v_RollNo INT;
    DECLARE v_Name VARCHAR(50);
    DECLARE done INT DEFAULT 0;

    -- Declare parameterized cursor
    DECLARE cur1 CURSOR FOR 
        SELECT RollNo, Name FROM N_RollCall WHERE RollNo <= roll_limit;

    -- Handler for end of cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open cursor
    OPEN cur1;

    read_loop: LOOP
        FETCH cur1 INTO v_RollNo, v_Name;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        -- Insert only if record not already present
        IF NOT EXISTS (SELECT 1 FROM O_RollCall WHERE RollNo = v_RollNo) THEN
            INSERT INTO O_RollCall (RollNo, Name)
            VALUES (v_RollNo, v_Name);
        END IF;
    END LOOP;

    CLOSE cur1;
END $$

DELIMITER ;





CALL Merge_rolca(100);


delimiter ;
create procedure Merge_rolca(in roll_limit int)
BEGIN declare v_rollno int;
declare v_name varchar(50);
declare done int default 1;

declare cur1 cursor for select RollNo , Name from N_RollCall WHERE RollNo <= roll_limit;

declare continue handler for not found set done= 1;
open cur1;

read_loop : loop 
fetch cur1 into v_rollno ,v_name ;
if done = 1

then leave read_loop;
end if;

if NOT EXISTS (select 1 from   O_RollCall WHERE RollNo = v_rollno)  then 
insert into  O_RollCall (RollNo, Name)
values (v_rollno , v_name );
end if;

end loop;

close cur1;
end  $$
