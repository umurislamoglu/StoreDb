CREATE Database Store



CREATE TABLE Category (
	id INT IDENTITY (1, 1) PRIMARY KEY,
	category_name VARCHAR (250) NOT NULL);

CREATE TABLE Brands (
	id INT IDENTITY (1, 1) PRIMARY KEY,
	brand_name VARCHAR (250) NOT NULL);

CREATE TABLE Products (
	id INT IDENTITY (1, 1) PRIMARY KEY,
	product_name VARCHAR (250) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	Stock INT,
	CONSTRAINT FK_BrandProduct FOREIGN KEY (brand_id) REFERENCES Brands(id),
	CONSTRAINT FK_CategoryProduct FOREIGN KEY (category_id) REFERENCES Category(id)
);

CREATE TABLE Stores (
	id INT IDENTITY (1, 1) PRIMARY KEY,
	store_name VARCHAR (250) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (250),
	street VARCHAR (250),
	city VARCHAR (50),
	zip_code VARCHAR (5)
);

CREATE TABLE Managers (
	id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (250) NOT NULL,
	phone VARCHAR (25),
	isactive TINYINT NOT NULL,
	store_id INT NOT NULL,
	CONSTRAINT FK_ManagerStore FOREIGN KEY (store_id) REFERENCES Stores(id),
);

CREATE TABLE Employees (
	id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (250) NOT NULL,
	phone VARCHAR (25),
	isactive tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_id INT 
	CONSTRAINT FK_EmployeeStore FOREIGN KEY (store_id) REFERENCES Stores(id),
	CONSTRAINT FK_EmployeeManager FOREIGN KEY (manager_id) REFERENCES Managers(id),
);

CREATE TABLE Customers (
	id INT IDENTITY (1, 1) PRIMARY KEY,
	first_name VARCHAR (250) NOT NULL,
	last_name VARCHAR (250) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (250) NOT NULL,
	street VARCHAR (250),
	city VARCHAR (50),
	states varchar(5),
	zip_code VARCHAR (5)
);

CREATE TABLE Orders (
	id INT IDENTITY (1, 1) PRIMARY KEY,
	customer_id INT,
	store_id INT NOT NULL,
	product_id INT NOT NULL,
	employee_id INT NOT NULL,
	order_date DATE NOT NULL,
	order_quantity INT NOT NULL,
	order_price INT NOT NULL,
	CONSTRAINT FK_OrderStore FOREIGN KEY (store_id) REFERENCES Stores(id),
	CONSTRAINT FK_OrderCustomer FOREIGN KEY (customer_id) REFERENCES Customers(id),
	CONSTRAINT FK_Orderemployee FOREIGN KEY (employee_id) REFERENCES Employees(id),
	CONSTRAINT FK_OrderProduct FOREIGN KEY (product_id) REFERENCES Products(id)
);

