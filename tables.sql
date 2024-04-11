use cs_2024_spring_3430_101_t3;

drop table if exists employee, customer, warehouse, product, orders, inventory;

create table employee(
	employeeID int(10) primary key,
    employeeName char(30),
    employeeRole char(30),
    employeeAddress varchar(100),
    employeePhone int(10),
    employeeEmail varchar(30)
);

create table customer(
	customerID int(10) primary key,
    customerName char(30),
    customerAddress varchar(100),
    customerPhone int(10),
    customerEmail varchar(30)
);

create table warehouse(
	warehouseID int(10) primary key,
    location varchar(100),
    manager char(30)
);

create table product(
	productID int(10) primary key,
    productName varchar(50),
    productDescription text,
    productPrice decimal(10,2),
    productCategory varchar(30),
    productQuantity int(10),
    warehouseID int(10),
    foreign key (warehouseID) references warehouse(warehouseID)
);

create table orders(
	orderID int(10) primary key,
    productID int(10),
    unitPrice decimal(10,2),
    quanity int(10),
    foreign key (productID) references product(productID)
);

create table inventory(
	warehouseID int(10),
    productID int(10),
    inventoryID int(10) primary key,
    quantity int(10),
	foreign key (warehouseID) references warehouse(warehouseID),
    foreign key (productID) references product(productID)
);

-- Insert data into the employee table
INSERT INTO employee VALUES
    (1, 'John Doe', 'Manager', '123 Main St, Anytown, USA', 1234567890, 'john.doe@example.com'),
    (2, 'Jane Smith', 'Sales Associate', '456 Elm St, Othertown, USA', 9876543210, 'jane.smith@example.com');

-- Insert data into the customer table
INSERT INTO customer VALUES
    (1, 'Alice Johnson', '789 Maple Ave, Anycity, USA', 2345678901, 'alice.johnson@example.com'),
    (2, 'Bob Brown', '101 Oak St, Othercity, USA', 8901234567, 'bob.brown@example.com');

-- Insert data into the warehouse table
INSERT INTO warehouse VALUES
    (1, 'Warehouse A', 'John Doe'),
    (2, 'Warehouse B', 'Jane Smith');

-- Insert data into the product table
INSERT INTO product VALUES
    (1, 'Laptop', '15" laptop with Intel Core i5 processor', 899.99, 'Electronics', 50, 1),
    (2, 'Smartphone', '5.5" smartphone with dual-camera', 599.99, 'Electronics', 100, 1),
    (3, 'Chair', 'Comfortable office chair with lumbar support', 149.99, 'Furniture', 75, 2);

-- Insert data into the orders table
-- Insert data into the orders table
INSERT INTO orders VALUES
    (1, 1, 899.99, 2),
    (2, 2, 599.99, 3),
    (3, 3, 149.99, 1);

-- Insert data into the inventory table
INSERT INTO inventory VALUES
    (1, 1, 1, 50),
    (1, 2, 2, 100),
    (2, 3, 3, 75);

-- View data in the employee table
SELECT * FROM employee;

-- View data in the customer table
SELECT * FROM customer;

-- View data in the warehouse table
SELECT * FROM warehouse;

-- View data in the product table
SELECT * FROM product;

-- View data in the orders table
SELECT * FROM orders;

-- View data in the inventory table
SELECT * FROM inventory;
