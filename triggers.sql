use cs_2024_spring_3430_101_t3;
drop trigger if exists check_product_quantity_before_insert;
drop trigger if exists check_product_quantity_before_update;
drop trigger if exists update_inventory_after_order;
drop trigger if exists check_inventory;

-- check quantity before order placed
delimiter //
create trigger check_inventory
before insert on orders
for each row
begin
    declare product_quantity int;
    select quantity into product_quantity from inventory where productID = new.productID;
    if product_quantity < new.quanity then
        signal sqlstate '45000' set message_text = 'Insufficient quantity in inventory';
    end if;
end//
delimiter ;

-- update the inventory after order
delimiter //
create trigger update_inventory_after_order
after insert on orders
for each row
begin
    update inventory
    set quantity = quantity - new.quanity
    where productID = new.productID;
end//
delimiter ;

-- check product quantity before update
delimiter //
create trigger check_product_quantity_before_update
before update on inventory
for each row
begin
    if new.quantity < 0 then
        signal sqlstate '45000' set message_text = 'Quantity cannot be negative';
    end if;
end//
delimiter ;

-- Check Product Quantity Before Insert
delimiter //
create trigger check_product_quantity_before_insert
before insert on inventory
for each row
begin
    if new.quantity < 0 then
        signal sqlstate '45000' set message_text = 'Quantity cannot be negative';
    end if;
end//
delimiter ;

-- Update product quantity after insert
delimiter //
create trigger update_product_quantity
after insert on orders
for each row
begin
    update product
    set productquantity = productquantity - new.quantity
    where productid = new.productid;
end//
delimiter ;

-- Update customer order count after order
delimiter //
create trigger update_customer_order_count
after insert on orders
for each row
begin
    update customer
    set customerordercount = customerordercount + 1
    where customerid = (
        select customerid from product where productid = new.productid
    );
end//
delimiter ;
