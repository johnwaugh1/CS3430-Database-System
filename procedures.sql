use cs_2024_spring_3430_101_t3;
drop procedure if exists GetCustomerInfo;
drop procedure if exists TrackSalesActivities;
drop procedure if exists UpdateCustomerInfo;

delimiter //
create procedure GetCustomerInfo(in cust_id int)
begin
    select * from customer where customerID = cust_id;
end //
delimiter ;

delimiter //
create procedure UpdateCustomerInfo(
    in cust_id int,
    in new_name char(30),
    in new_address varchar(100),
    in new_phone int,
    in new_email varchar(30),
    in new_product int(10)
)
begin
    insert into customer (customerID, customerName, customerAddress, customerPhone, customerEmail, customerProduct)
    values (cust_id, new_name, new_address, new_phone, new_email, new_product)
    on duplicate key update
        customerName = new_name,
        customerAddress = new_address,
        customerPhone = new_phone,
        customerEmail = new_email,
        customerProduct = new_product;
end //
delimiter ;

delimiter //
create procedure TrackSalesActivities(in cust_product_id int)
begin
    if cust_product_id is null then
        select * from orders o
        join product p on o.productID = p.productID
        where p.warehouseID in (select warehouseID from warehouse);
    else
        select * from orders o
        join product p on o.productID = p.productID
        where p.warehouseID in (select warehouseID from warehouse)
        and o.productID = cust_product_id;
    end if;
end //
delimiter ;

-- Testing UpdateCustomerInfo and GetCustomerInfo
select * from customer;
call UpdateCustomerInfo(3, 'Lucy Maclean', 'Vault 33', 987654321, 'lmaclean@gmail.com', 3);
select * from customer;
call GetCustomerInfo(3);

-- Testing remaining procedures
call TrackSalesActivities(2);
