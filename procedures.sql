
drop procedure if exists GetCustomerInfo;
DELIMITER //

CREATE PROCEDURE GetCustomerInfo(IN cust_id INT)
BEGIN
    SELECT * FROM customer WHERE customerID = cust_id;
END //

DELIMITER ;

drop procedure if exists TrackSalesActivities;
DELIMITER //

CREATE PROCEDURE TrackSalesActivities(IN cust_id INT)
BEGIN
    SELECT * FROM orders o
    JOIN product p ON o.productID = p.productID
    WHERE p.warehouseID IN (SELECT warehouseID FROM warehouse WHERE manager = 'Jane Smith')
    AND EXISTS (SELECT 1 FROM customer WHERE customerID = cust_id);
END //

DELIMITER ;

DELIMITER //

drop procedure if exists UpdateCustomerInfo;
CREATE PROCEDURE UpdateCustomerInfo(
    IN cust_id INT,
    IN new_name CHAR(30),
    IN new_address VARCHAR(100),
    IN new_phone INT,
    IN new_email VARCHAR(30)
)
BEGIN
    UPDATE customer
    SET customerName = new_name,
        customerAddress = new_address,
        customerPhone = new_phone,
        customerEmail = new_email
    WHERE customerID = cust_id;
END //

DELIMITER ;

call GetCustomerInfo(1);
call TrackSalesActivities(1);
call UpdateCustomerInfo(1, 'Lucy Maclean', 'Vault 33', 987654321, 'lmaclean@gmail.com');

select * from customer;
