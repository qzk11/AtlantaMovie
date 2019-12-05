-- 1
DROP PROCEDURE IF EXISTS user_login;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_login`(IN i_username VARCHAR(45), IN i_password VARCHAR(45))
BEGIN
  DROP TABLE IF EXISTS UserLogin;
    CREATE TABLE UserLogin
        SELECT username, status,
        CASE WHEN (SELECT userType FROM user WHERE userName = i_username) = 'Customer' or (SELECT userType FROM user WHERE userName = i_username) = 'CustomerAdmin' or (SELECT userType FROM user WHERE userName = i_username) = 'CustomerManager' THEN '1'
        ELSE '0' END AS isCustomer,
        CASE WHEN (SELECT employeeType FROM employee WHERE userName = i_username) = 'Admin' THEN '1'
        ELSE '0' END AS isAdmin,
        CASE WHEN (SELECT employeeType FROM employee WHERE userName = i_username) = 'Manager' THEN '1'
        ELSE '0' END AS isManager
        FROM user
        WHERE (userName = i_username) AND 
        (password = MD5(i_password));
END$$
DELIMITER ;

-- 3
DROP PROCEDURE IF EXISTS user_register;
DELIMITER $$
CREATE PROCEDURE `user_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50))
BEGIN
		INSERT INTO user (username, password, firstname, lastname, userType) VALUES (i_username, MD5(i_password), i_firstname, i_lastname, "User");
END$$
DELIMITER ;

-- 4A
DROP PROCEDURE IF EXISTS customer_only_register;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_only_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50))
BEGIN
		INSERT INTO user (username, password, firstname, lastname, userType, status) VALUES (i_username, MD5(i_password), i_firstname, i_lastname, 'Customer', 'Pending');
END$$
DELIMITER ;

-- 4B
DROP PROCEDURE IF EXISTS customer_add_creditcard;
DELIMITER $$
CREATE PROCEDURE `customer_add_creditcard`(In i_username VARCHAR(45), In i_creditCardNum VARCHAR(16))
BEGIN
	IF (SELECT count(*) from customercreditcard WHERE i_username = username ) <5 THEN
    
	INSERT INTO customercreditcard (username, creditCardNum) VALUES( i_username, i_creditCardNum );
    END IF;

END$$
DELIMITER ;

-- 5
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_only_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50), IN i_comName VARCHAR(50), IN i_empStreet VARCHAR(50), IN i_empCity VARCHAR(50), IN i_empState CHAR(2), IN i_empZipcode CHAR(5))
BEGIN
    INSERT INTO user (username, password, firstname, lastname, userType) 
        VALUES (i_username, MD5(i_password), i_firstname, i_lastname, 'Manager');
        INSERT INTO employee (username, comName, manStreet, manCity, manState, manZipcode,thName)
        VALUES (i_username, i_comName, i_empStreet, i_empCity, i_empState, i_empZipcode,"");
        INSERT INTO manager (username, comName, manStreet, manCity, manState, manZipcode,thName)
        VALUES (i_username, i_comName, i_empStreet, i_empCity, i_empState, i_empZipcode,"");
END$$
DELIMITER ;

-- 6A
DROP PROCEDURE IF EXISTS manager_customer_register;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_customer_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50),
IN i_comName VARCHAR(45), IN i_empStreet VARCHAR(45), IN i_empCity VARCHAR(45), IN i_empState CHAR(2), IN i_empZipcode CHAR(5))
BEGIN
		INSERT INTO user(username, password, firstname, lastname, userType)
        VALUES (i_username, MD5(i_password), i_firstname, i_lastname, 'CustomerManager');
        INSERT INTO employee (username, comName, manStreet, manCity, manState, manZipcode, thName) 
        VALUES ( i_username, i_comName, i_empStreet, i_empCity, i_empState, i_empZipcode, "");
        INSERT INTO manager (username, comName, manStreet, manCity, manState, manZipcode, thName) 
        VALUES ( i_username, i_comName, i_empStreet, i_empCity, i_empState, i_empZipcode, "");
END$$
DELIMITER ;

-- 6B
DROP PROCEDURE IF EXISTS manager_customer_add_credictcard;
DELIMITER $$
CREATE PROCEDURE `manager_customer_add_credictcard`(IN i_username VARCHAR(50), IN i_creditCardNum CHAR(16))
BEGIN
	IF (SELECT count(*) from customercreditcard WHERE i_username = username ) <5 THEN
    
	INSERT INTO customercreditcard (username, creditCardNum) VALUES( i_username, i_creditCardNum );
    END IF;
END$$
DELIMITER ;

-- 13a
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_approve_user`(IN i_username VARCHAR(50))
BEGIN
		update user
        set status = 'Approved'
        where username = i_username;
END$$
DELIMITER ;

-- 13b
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_decline_user`(IN i_username VARCHAR(50))
BEGIN
		IF(SELECT status FROM user WHERE username = i_username) <> 'Approved' THEN
        update user
        set status = 'Declined'
        where username = i_username;
        END IF;
END$$
DELIMITER ;

-- 13c
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_filter_user`(IN i_username VARCHAR(50), IN i_status ENUM('Approved','Pending','Declined', 'ALL'), 
IN i_sortBy ENUM('username','creditCardCount','userType','status', ''), IN i_sortDirection ENUM('ASC','DESC',''))
BEGIN
	IF (i_username <> '') THEN 
		DROP TABLE IF EXISTS AdFilterUser;
		CREATE TABLE AdFilterUser
		SELECT user.username, count(creditCardNum) as creditCardCount, userType, status
		FROM customercreditcard right join user on user.username = customercreditcard.username
		WHERE user.username = i_username AND (status = i_status OR i_status = 'ALL');
	ELSEIF ((i_sortBy = 'username' or i_sortBy = '') and i_sortDirection <> 'ASC' ) then
		DROP TABLE IF EXISTS AdFilterUser;
		CREATE TABLE AdFilterUser
		SELECT user.username, count(creditCardNum) as creditCardCount, userType, status
		FROM customercreditcard right join user on user.username = customercreditcard.username
		WHERE status = i_status OR i_status = 'ALL'
		group by username
		order by username DESC;
    ELSEIF (i_sortBy = 'creditCardCount' and i_sortDirection <> 'ASC') THEN
		DROP TABLE IF EXISTS AdFilterUser;
		CREATE TABLE AdFilterUser
		SELECT user.username, count(creditCardNum) as creditCardCount, userType, status
		FROM customercreditcard right join user on user.username = customercreditcard.username
		WHERE status = i_status OR i_status = 'ALL'
		group by username
		order by creditCardCOunt DESC;
	 ELSEIF (i_sortBy = 'userType' and i_sortDirection <> 'ASC') THEN
		DROP TABLE IF EXISTS AdFilterUser;
		CREATE TABLE AdFilterUser
		SELECT user.username, count(creditCardNum) as creditCardCount, userType, status
		FROM customercreditcard right join user on user.username = customercreditcard.username
		WHERE status = i_status OR i_status = 'ALL'
		group by username
		order by userType DESC;
	ELSEIF (i_sortBy = 'status' and i_sortDirection <> 'ASC') THEN
		DROP TABLE IF EXISTS AdFilterUser;
		CREATE TABLE AdFilterUser
		SELECT user.username, count(creditCardNum) as creditCardCount, userType, status
		FROM customercreditcard right join user on user.username = customercreditcard.username
		WHERE status = i_status OR i_status = 'ALL'
		group by username
		order by status DESC;
	 ELSEIF ((i_sortBy = 'username' or i_sortBy = '')  and i_sortDirection = 'ASC') then
		DROP TABLE IF EXISTS AdFilterUser;
		CREATE TABLE AdFilterUser
		SELECT user.username, count(creditCardNum) as creditCardCount, userType, status
		FROM customercreditcard right join user on user.username = customercreditcard.username
		WHERE status = i_status OR i_status = 'ALL'
		group by username
		order by username ASC;
    ELSEIF (i_sortBy = 'creditCardCount' and i_sortDirection = 'ASC') THEN
		DROP TABLE IF EXISTS AdFilterUser;
		CREATE TABLE AdFilterUser
		SELECT user.username, count(creditCardNum) as creditCardCount, userType, status
		FROM customercreditcard right join user on user.username = customercreditcard.username
		WHERE status = i_status OR i_status = 'ALL'
		group by username
		order by creditCardCOunt ASC;
	 ELSEIF (i_sortBy = 'userType' and i_sortDirection = 'ASC') THEN
		DROP TABLE IF EXISTS AdFilterUser;
		CREATE TABLE AdFilterUser
		SELECT user.username, count(creditCardNum) as creditCardCount, userType, status
		FROM customercreditcard right join user on user.username = customercreditcard.username
		WHERE status = i_status OR i_status = 'ALL'
		group by username
		order by userType ASC;
	ELSEIF (i_sortBy = 'status' and i_sortDirection = 'ASC') THEN
		DROP TABLE IF EXISTS AdFilterUser;
		CREATE TABLE AdFilterUser
		SELECT user.username, count(creditCardNum) as creditCardCount, userType, status
		FROM customercreditcard right join user on user.username = customercreditcard.username
		WHERE status = i_status OR i_status = 'ALL'
		group by username
		order by status ASC;
    END IF;
    
END$$
DELIMITER ;

-- 14 
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_filter_company`(IN i_comName VARCHAR(50), IN i_minCity INT(10), IN i_maxCity INT(10), IN i_minTheater INT(10), IN i_maxTheater INT(10), IN i_minEmployee INT(10), IN i_maxEmployee INT(10), IN i_sortBy VARCHAR(20), IN i_sortDirection VARCHAR(10))
BEGIN
    DROP TABLE IF EXISTS AdFilterCom;
    IF i_sortBy = '' THEN SET i_sortBy = 'comName'; END IF;
    IF i_sortDirection = '' THEN SET i_sortDirection = 'DESC'; END IF;
    IF i_minCity is null THEN SET i_minCity = 0; END IF;
    IF i_maxCity is null THEN SET i_maxCity = 99; END IF;
    IF i_minTheater is null THEN SET i_minTheater = 0; END IF;
    IF i_maxTheater is null THEN SET i_maxTheater =  99; END IF;
    IF i_minEmployee is null THEN SET i_minEmployee  = 0; END IF;
    IF i_maxEmployee is null THEN SET i_maxEmployee = 99; END IF;
    
    CREATE TABLE AdFilterCom
    SELECT comName, numCityCover, numTheater, numEmployee
 FROM (
 SELECT theater.comName, count(DISTINCT theater.thCity) AS numCityCover, count(DISTINCT theater.thName) as numTheater, count(DISTINCT username) as numEmployee
 FROM theater
 LEFT JOIN manager
 ON theater.comName = manager.comName 
 GROUP BY theater.comName ) as A
 WHERE 
    (i_comName = 'ALL' or i_comName = '' or comName = i_comName) AND
    (numCityCover >= i_minCity) AND 
 (numCityCover <= i_maxCity) AND
 (numTheater >= i_minTheater) AND
 (numTheater <= i_maxTheater) AND
 (numEmployee >= i_minEmployee) AND
 (numEmployee <= i_maxEmployee) ;
    
 SET @a = CONCAT('
    ALTER TABLE AdFilterCom
 ORDER BY ', i_sortBy,' ', i_sortDirection);
    
    PREPARE stmt1 FROM @a;
 EXECUTE stmt1;
 DEALLOCATE PREPARE stmt1;

END$$
DELIMITER ;

-- 15
DROP PROCEDURE IF EXISTS admin_create_theater;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_create_theater`(IN i_thName VARCHAR(50), IN i_comName VARCHAR(50), IN i_thStreet VARCHAR(50), IN i_thCity VARCHAR(50), 
IN i_thState CHAR(2), IN i_thZipcode CHAR(5), IN i_capacity INT, IN i_managerUsername VARCHAR(50))
BEGIN
IF(((select comName from manager where username = i_managerUsername) = i_comName) AND
 ((select thName from manager where username = i_managerUsername) = '')) THEN
INSERT INTO theater (thName, comName, thStreet, thCity,thState,thZipcode,capacity,manUsername) 
VALUES (i_thName, i_comName, i_thStreet, i_thCity, i_thState,i_thZipcode, i_capacity, i_managerUsername);
UPDATE employee
SET thName = i_thName
WHERE username = i_managerUsername;
UPDATE manager
SET thName = i_thName
WHERE username = i_managerUsername;
END IF;
END$$
DELIMITER ;
-- 16A
DROP PROCEDURE IF EXISTS admin_view_comDetail_emp;
DELIMITER $$
CREATE PROCEDURE `admin_view_comDetail_emp`(IN i_comName VARCHAR(45))
BEGIN
DROP TABLE IF EXISTS AdComDetailEmp;
CREATE TABLE AdComDetailEmp
SELECT u.firstname as empFirstname, u.lastname as empLastname
FROM user u
JOIN employee e
ON u.username = e.username
WHERE e.comName = i_comName;
END$$
DELIMITER ;

-- 16B
DROP PROCEDURE IF EXISTS admin_view_comDetail_th;
DELIMITER $$
CREATE PROCEDURE `admin_view_comDetail_th`(IN i_comName VARCHAR(45))
BEGIN
DROP TABLE IF EXISTS AdComDetailTh;
CREATE TABLE AdComDetailTh
SELECT t.thName,e.username as thManagerUsername,t.thCity,t.thState,t.Capacity as thCapacity
FROM theater t
JOIN employee e
ON t.comName = e.comName
WHERE  t.comName= i_comName and manUsername = e.username;
END$$
DELIMITER ;

-- 17
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `admin_create_mov`(IN i_movName VARCHAR(50), IN i_movDuration INT, IN i_movRelease DATE)
BEGIN
INSERT INTO movie (movName, movReleaseDate, duration) VALUES (i_movName, i_movRelease, i_movDuration);
END$$
DELIMITER ;

-- 18
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_filter_th`(IN i_manUsername VARCHAR(50), IN i_movName VARCHAR(50), IN i_minMovDuration INT, IN i_maxMovDuration INT,
IN i_minMovReleaseDate DATE, IN i_maxMovReleaseDate DATE,IN i_minMovPlayDate DATE, IN i_maxMovPlayDate DATE, IN i_includeNotPlayed BOOLEAN)
BEGIN
        IF((NOT i_includeNotPlayed) OR i_includeNotPlayed is NULL) THEN
        DROP TABLE IF EXISTS ManFilterTh;
        CREATE TABLE ManFilterTh
        SELECT movie.movName,duration as movDuration,movie.movReleaseDate,movPlayDate
         FROM (select * FROM movieplay where thName in (select thName from employee where Username = i_manUsername)) as a right join movie on a.movName = movie.movName 
        WHERE
         ((movie.movName = i_movName OR i_movName = "") AND
            ((duration >= i_minMovDuration AND duration <= i_maxMovDuration) OR i_minMovDuration is NULL OR i_maxMovDuration is NULL) AND
            ((movie.movReleaseDate >= i_minMovReleaseDate AND movie.movReleaseDate <= i_maxMovReleaseDate) OR i_minMovReleaseDate is NULL OR i_maxMovReleaseDate is NULL) AND
            ((movPlayDate >= i_minMovPlayDate AND movPlayDate <= i_maxMovPlayDate) OR i_minMovPlayDate is NULL OR i_maxMovPlayDate is NULL OR movPlayDate is NULL));
        ELSE
        DROP TABLE IF EXISTS ManFilterTh;
        CREATE TABLE ManFilterTh
        SELECT movie.movName,duration as movDuration,movie.movReleaseDate, movPlayDate
        FROM (select * FROM movieplay where thName in (select thName from employee where Username = i_manUsername)) as a right join movie on a.movName = movie.movName
        WHERE 
           ((movie.movName = i_movName OR i_movName = "") AND
            ((duration >= i_minMovDuration AND duration <= i_maxMovDuration) OR i_minMovDuration is NULL OR i_maxMovDuration is NULL) AND
            ((movie.movReleaseDate >= i_minMovReleaseDate AND movie.movReleaseDate <= i_maxMovReleaseDate) OR i_minMovReleaseDate is NULL OR i_maxMovReleaseDate is NULL) AND
            (movPlayDate is NULL));
        END IF;
        
END$$
DELIMITER ;

-- 19
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `manager_schedule_mov`(IN i_manUsername VARCHAR(45), IN i_movName VARCHAR(45), IN i_movReleaseDate DATE, IN i_movPlayDate DATE)
BEGIN
    if(i_movPlayDate >= i_movReleaseDate) THEN
    INSERT INTO movieplay (movName, movReleaseDate, movPlayDate, thName, comName)
    select i_movName, i_movReleaseDate, i_movPlayDate,thName, comName
    from employee
    where username = i_manUsername ;
    end if;
END$$
DELIMITER ;

-- 20a
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_filter_mov`(IN i_movName VARCHAR(45), IN i_comName VARCHAR(45), IN i_city VARCHAR(45),IN i_state CHAR(3),
IN i_minMovPlayDate DATE, IN i_maxMovPlayDate DATE)
BEGIN
 DROP TABLE IF EXISTS CosFilterMovie;
    CREATE TABLE CosFilterMovie
    SELECT movName, thName, thStreet, thCity, thState, thZipCode, comName, movPlayDate, movReleaseDate
    FROM movieplay natural join theater
    WHERE 
    (( movPlayDate >= movReleaseDate )) AND
    ((movName = i_movName) or (i_movName = "ALL")) AND
    ((comName = i_comName) or (i_comName = "ALL")) AND
    (thCity = i_city or i_city = "") AND
    (thState = i_state or i_state = "ALL") AND
    ((movPlayDate >= i_minMovPlayDate AND movPlayDate <= i_maxMovPlayDate) or (i_minMovPlayDate is NULL and movPlayDate < i_maxMovPlayDate) or (i_maxMovPlayDate is NULL and movPlayDate > i_minMovPlayDate) or (i_minMovPlayDate is NULL and i_maxMovPlayDate is NULL));
END $$ 
DELIMITER ;

-- 20b
DROP PROCEDURE IF EXISTS customer_view_mov;
DELIMITER $$
CREATE PROCEDURE `customer_view_mov`(In i_creditCardNum CHAR(20), In i_movName VARCHAR(45), 
        In i_movReleaseDate DATE, In i_thName VARCHAR(45), 
                                In i_comName VARCHAR(45), In i_movPlayDate DATE)
BEGIN

 Insert into customerviewmovie 
    values (i_movName, i_movReleaseDate, i_movPlayDate,  i_comName, i_thName, i_creditCardNum);
    
END$$
DELIMITER ;

-- 21
DROP PROCEDURE IF EXISTS customer_view_history ;
DELIMITER $$
CREATE PROCEDURE `customer_view_history`(IN i_cusUsername VARCHAR(50))
BEGIN
	DROP TABLE IF EXISTS CosViewHistory;
    CREATE TABLE CosViewHistory
	select movName, thName, comName, creditCardNum, movPlayDate
    from customerviewmovie
    where creditCardNum in (select creditCardNum
							from customercreditcard
                            where i_cusUsername = username);
END$$
DELIMITER ;

-- 22a
DROP PROCEDURE IF EXISTS user_filter_th;
DELIMITER $$
CREATE PROCEDURE `user_filter_th`(IN i_thName VARCHAR(50), IN i_comName VARCHAR(50), IN i_city VARCHAR(50), IN i_state VARCHAR(3))
BEGIN
    DROP TABLE IF EXISTS UserFilterTh;
    CREATE TABLE UserFilterTh
	SELECT thName, thStreet, thCity, thState, thZipcode, comName 
    FROM Theater
    WHERE 
		(thName = i_thName OR i_thName = "ALL") AND
        (comName = i_comName OR i_comName = "ALL") AND
        (thCity = i_city OR i_city = "") AND
        (thState = i_state OR i_state = "ALL");
END$$
DELIMITER ;

-- 22b
DROP PROCEDURE IF EXISTS user_visit_th;
DELIMITER $$
CREATE PROCEDURE `user_visit_th`(IN i_thName VARCHAR(50), IN i_comName VARCHAR(50), IN i_visitDate DATE, IN i_username VARCHAR(50))
BEGIN
    INSERT INTO UserVisitTheater (thName, comName, visitDate, username)
    VALUES (i_thName, i_comName, i_visitDate, i_username);
END$$
DELIMITER ;

-- 23
DROP PROCEDURE IF EXISTS user_filter_visitHistory;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_filter_visitHistory`(IN i_username VARCHAR(50), IN i_minVisitDate DATE, IN i_maxVisitDate DATE,IN i_comName VARCHAR(50))
BEGIN
    DROP TABLE IF EXISTS UserVisitHistory;
    CREATE TABLE UserVisitHistory
    SELECT thName, thStreet, thCity, thState, thZipcode, comName, visitDate
    FROM UserVisitTheater
        NATURAL JOIN
        Theater
    WHERE
        (username = i_username) AND
        (i_minVisitDate IS NULL OR visitDate >= i_minVisitDate) AND
        (i_maxVisitDate IS NULL OR visitDate <= i_maxVisitDate) AND 
        (i_comName = comName OR i_comName = "ALL" );
END$$
DELIMITER ;


--
DROP PROCEDURE IF EXISTS test_for_phase4;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `test_for_phase4`(IN i_comName VARCHAR(45))
BEGIN
DROP TABLE IF EXISTS screen16comName;
CREATE TABLE screen16comName
SELECT comName
FROM company
WHERE  comName = i_comName;
END$$
DELIMITER ;
