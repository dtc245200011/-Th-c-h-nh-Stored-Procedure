-- Thay đổi delimiter để tạo procedure
DELIMITER //

-- 1. Procedure không tham số: trả về tất cả customers (ví dụ)
DROP PROCEDURE IF EXISTS findAllCustomers//
CREATE PROCEDURE findAllCustomers()
BEGIN
  SELECT * FROM customers;
END//
 
-- 2. Procedure IN parameter: tìm theo customerName
DROP PROCEDURE IF EXISTS findCustomerByName//
CREATE PROCEDURE findCustomerByName(IN p_name VARCHAR(100))
BEGIN
  SELECT * FROM customers
  WHERE customerName = p_name;
END//

-- 3. Procedure OUT parameter: đếm số khách hàng theo country
DROP PROCEDURE IF EXISTS countCustomersByCountry//
CREATE PROCEDURE countCustomersByCountry(
  IN p_country VARCHAR(50),
  OUT p_count INT
)
BEGIN
  SELECT COUNT(*) INTO p_count
  FROM customers
  WHERE country = p_country;
END//

-- 4. Procedure INOUT parameter: cập nhật phone và trả về phone mới
DROP PROCEDURE IF EXISTS updateCustomerPhone//
CREATE PROCEDURE updateCustomerPhone(
  IN p_customerNumber INT,
  INOUT p_phone VARCHAR(50)
)
BEGIN
  UPDATE customers
  SET phone = p_phone
  WHERE customerNumber = p_customerNumber;
  SELECT phone INTO p_phone FROM customers WHERE customerNumber = p_customerNumber;
END//

-- 5. Procedure dùng cursor: liệt kê customerNumber có contactLastName trùng
DROP PROCEDURE IF EXISTS listCustomersByLastName//
CREATE PROCEDURE listCustomersByLastName(IN p_lastname VARCHAR(50))
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE c_number INT;
  DECLARE cur CURSOR FOR
    SELECT customerNumber FROM customers WHERE contactLastName = p_lastname;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  CREATE TEMPORARY TABLE IF NOT EXISTS tmp_results (customerNumber INT);
  TRUNCATE TABLE tmp_results;

  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO c_number;
    IF done THEN
      LEAVE read_loop;
    END IF;
    INSERT INTO tmp_results VALUES (c_number);
  END LOOP;
  CLOSE cur;

  SELECT * FROM tmp_results;
  DROP TEMPORARY TABLE IF EXISTS tmp_results;
END//

DELIMITER ;
