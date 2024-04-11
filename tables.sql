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
