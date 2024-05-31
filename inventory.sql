/*
This file contains a script of Transact SQL (T-SQL) command to interact with a database named 'Inventory'.
Requirements:
- SQL Server 2022 is installed and running
- database 'Inventory' already exists.
Details:
- Sets the default database to 'Inventory'.
- Creates a 'categories' table and related 'products' table if they do not already exist.
- Remove all rows from the tables (in case they already existed).
- Populates the 'Categories' table with sample data.
- Populates the 'Products' table with sample data.
- Creates a stored procedure named 'GetProductsByCategory' that returns a list of products for a given category.
Errors:
- if the database 'Inventory' does not exist, the script will print an error message and exit.
*/

-- Set the default database to 'Inventory'
USE Inventory;


/*
Create a Catagory table with the following columns:
- CategoryID (Primary Key)
- CategoryName (Unique)
- Description (Optional)
Rules:
Create the table only if one does not already exist.
*/
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Categories')
BEGIN
    CREATE TABLE Categories
    (
        CategoryID INT PRIMARY KEY,
        CategoryName NVARCHAR(50) UNIQUE,
        Description NVARCHAR(255)
    );
END;

-- Create a Products table with the following columns:
-- ProductID (Primary Key)
-- ProductName
-- CategoryID (Foreign Key)
-- Price

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Products')
BEGIN
    CREATE TABLE Products
    (
        ProductID INT PRIMARY KEY,
        ProductName NVARCHAR(50),
        CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
        Price DECIMAL(10, 2),
        -- Add a timestamp column for the creation date
        CreatedAt DATETIME DEFAULT GETDATE(),
        -- Add a timestamp column for the last update date
        UpdatedAt DATETIME DEFAULT GETDATE()
    );
END;

-- Remove all rows from the tables products and categories tables
TRUNCATE TABLE Products;
TRUNCATE TABLE Categories;

-- Populate the Categories table with sample data
INSERT INTO Categories (CategoryID, CategoryName, Description) VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Clothing', 'Clothing items and accessories'),
(3, 'Books', 'Books and reading materials');

-- Populate the Products table with sample data
INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES
(1, 'Laptop', 1, 999.99),
(2, 'Smartphone', 1, 599.99),
(3, 'T-shirt', 2, 19.99),
(4, 'Jeans', 2, 49.99),
(5, 'Novel', 3, 9.99),
(6, 'Textbook', 3, 59.99);

-- Create a stored procedure named 'GetProductsByCategory' that returns a list of products for a given category
IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'GetProductsByCategory')
BEGIN
    DROP PROCEDURE GetProductsByCategory;
END;

CREATE PROCEDURE GetProductsByCategory
    @CategoryName NVARCHAR(50)
AS
BEGIN
    SELECT p.ProductID, p.ProductName, p.Price
    FROM Products p
    JOIN Categories c ON p.CategoryID = c.CategoryID
    WHERE c.CategoryName = @CategoryName;
END;

-- Print a success message
PRINT 'Inventory database setup completed successfully.';





