--CREATE DATABASE SHOP
GO
USE SHOP
GO

CREATE TABLE [stores] (
  [store_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255),
  [address] nvarchar(255),
  [phone] nvarchar(255),
  [opened_at] date
)
GO

CREATE TABLE [roles] (
  [role_id] int PRIMARY KEY IDENTITY(1, 1),
  [title] nvarchar(255)
)
GO


CREATE TABLE [employees] (
  [employee_id] int PRIMARY KEY IDENTITY(1, 1),
  [store_id] int,
  [role_id] int,
  [full_name] nvarchar(255),
  [phone] nvarchar(255),
  [hired_at] date
)
GO

CREATE TABLE [categories] (
  [category_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255),
  [parent_category_id] int
)
GO

CREATE TABLE [products] (
  [product_id] int PRIMARY KEY IDENTITY(1, 1),
  [category_id] int,
  [article] nvarchar(255) UNIQUE,
  [name] nvarchar(255),
  [brand] nvarchar(255),
  [size] nvarchar(255),
  [color] nvarchar(255),
  [purchase_price] decimal(18,2),
  [retail_price] decimal(18,2)
)
GO

CREATE TABLE [suppliers] (
  [supplier_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255),
  [contact_person] nvarchar(255),
  [phone] nvarchar(255),
  [email] nvarchar(255)
)
GO

CREATE TABLE [purchases] (
  [purchase_id] int PRIMARY KEY IDENTITY(1, 1),
  [supplier_id] int,
  [store_id] int,
  [employee_id] int,
  [purchase_date] datetime,
  [status] nvarchar(255)
)
GO

CREATE TABLE [purchase_items] (
  [purchase_item_id] int PRIMARY KEY IDENTITY(1, 1),
  [purchase_id] int,
  [product_id] int,
  [quantity] int,
  [purchase_price] decimal(18,2)
)
GO

CREATE TABLE [stock] (
  [stock_id] int PRIMARY KEY IDENTITY(1, 1),
  [store_id] int,
  [product_id] int,
  [quantity] int
)
GO

CREATE TABLE [customers] (
  [customer_id] int PRIMARY KEY IDENTITY(1, 1),
  [full_name] nvarchar(255),
  [phone] nvarchar(255),
  [email] nvarchar(255),
  [registered_at] date
)
GO

CREATE TABLE [loyalty_cards] (
  [card_id] int PRIMARY KEY IDENTITY(1, 1),
  [customer_id] int,
  [card_number] nvarchar(255) UNIQUE,
  [bonus_balance] decimal(18,2),
  [issued_at] date
)
GO

CREATE TABLE [promotions] (
  [promotion_id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255),
  [discount_percent] decimal(18,2),
  [start_date] date,
  [end_date] date
)
GO

CREATE TABLE [promotion_products] (
  [promotion_product_id] int PRIMARY KEY IDENTITY(1, 1),
  [promotion_id] int,
  [product_id] int
)
GO

CREATE TABLE [sales] (
  [sale_id] int PRIMARY KEY IDENTITY(1, 1),
  [store_id] int,
  [employee_id] int,
  [customer_id] int,
  [sale_date] datetime,
  [total_amount] decimal(18,2)
)
GO

CREATE TABLE [sale_items] (
  [sale_item_id] int PRIMARY KEY IDENTITY(1, 1),
  [sale_id] int,
  [product_id] int,
  [quantity] int,
  [price] decimal(18,2),
  [discount_amount] decimal(18,2)
)
GO

CREATE TABLE [returns] (
  [return_id] int PRIMARY KEY IDENTITY(1, 1),
  [sale_item_id] int,
  [return_date] datetime,
  [reason] nvarchar(255),
  [quantity] int
)
GO

-- Внешние ключи (связи между таблицами)
ALTER TABLE [employees] ADD FOREIGN KEY ([store_id]) REFERENCES [stores] ([store_id])
ALTER TABLE [employees] ADD FOREIGN KEY ([role_id]) REFERENCES [roles] ([role_id])
ALTER TABLE [categories] ADD FOREIGN KEY ([parent_category_id]) REFERENCES [categories] ([category_id])
ALTER TABLE [products] ADD FOREIGN KEY ([category_id]) REFERENCES [categories] ([category_id])
ALTER TABLE [purchases] ADD FOREIGN KEY ([supplier_id]) REFERENCES [suppliers] ([supplier_id])
ALTER TABLE [purchases] ADD FOREIGN KEY ([store_id]) REFERENCES [stores] ([store_id])
ALTER TABLE [purchases] ADD FOREIGN KEY ([employee_id]) REFERENCES [employees] ([employee_id])
ALTER TABLE [purchase_items] ADD FOREIGN KEY ([purchase_id]) REFERENCES [purchases] ([purchase_id])
ALTER TABLE [purchase_items] ADD FOREIGN KEY ([product_id]) REFERENCES [products] ([product_id])
ALTER TABLE [stock] ADD FOREIGN KEY ([store_id]) REFERENCES [stores] ([store_id])
ALTER TABLE [stock] ADD FOREIGN KEY ([product_id]) REFERENCES [products] ([product_id])
ALTER TABLE [loyalty_cards] ADD FOREIGN KEY ([customer_id]) REFERENCES [customers] ([customer_id])
ALTER TABLE [promotion_products] ADD FOREIGN KEY ([promotion_id]) REFERENCES [promotions] ([promotion_id])
ALTER TABLE [promotion_products] ADD FOREIGN KEY ([product_id]) REFERENCES [products] ([product_id])
ALTER TABLE [sales] ADD FOREIGN KEY ([store_id]) REFERENCES [stores] ([store_id])
ALTER TABLE [sales] ADD FOREIGN KEY ([employee_id]) REFERENCES [employees] ([employee_id])
ALTER TABLE [sales] ADD FOREIGN KEY ([customer_id]) REFERENCES [customers] ([customer_id])
ALTER TABLE [sale_items] ADD FOREIGN KEY ([sale_id]) REFERENCES [sales] ([sale_id])
ALTER TABLE [sale_items] ADD FOREIGN KEY ([product_id]) REFERENCES [products] ([product_id])
ALTER TABLE [returns] ADD FOREIGN KEY ([sale_item_id]) REFERENCES [sale_items] ([sale_item_id])
GO

-- НОВАЯ ТАБЛИЦА ДЛЯ АВТОРИЗАЦИИ (добавлена для методички)
CREATE TABLE [Users] (
  [ID] int PRIMARY KEY IDENTITY(1, 1),
  [Login] nvarchar(50) NOT NULL UNIQUE,
  [Password] nvarchar(255) NOT NULL,
  [Role] nvarchar(50) NOT NULL,
  [FIO] nvarchar(255) NOT NULL,
  [Photo] nvarchar(255) NULL
)
GO

-- Добавим тестового администратора (пароль пока просто текстом, потом захэшируем)
INSERT INTO [Users] ([Login], [Password], [Role], [FIO]) 
VALUES ('admin', 'admin123', 'Администратор', 'Кузьмина Ксения Сергеевна')
GO