-- Gọi procedure không tham số
CALL findAllCustomers();

-- Gọi procedure IN
CALL findCustomerByName('Land of Toys Inc.');

-- Gọi procedure OUT
SET @cnt = 0;
CALL countCustomersByCountry('USA', @cnt);
SELECT @cnt AS customers_in_USA;

-- Gọi procedure INOUT
SET @phone = '999-999-9999';
CALL updateCustomerPhone(175, @phone);
SELECT @phone AS updated_phone;

-- Gọi procedure dùng cursor
CALL listCustomersByLastName('King');
