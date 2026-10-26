USE [SHOPI]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[parent_category_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customers]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[full_name] [nvarchar](255) NULL,
	[phone] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[registered_at] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employees]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employees](
	[employee_id] [int] IDENTITY(1,1) NOT NULL,
	[store_id] [int] NULL,
	[role_id] [int] NULL,
	[full_name] [nvarchar](255) NULL,
	[phone] [nvarchar](255) NULL,
	[hired_at] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[loyalty_cards]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loyalty_cards](
	[card_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[card_number] [nvarchar](255) NULL,
	[bonus_balance] [decimal](18, 2) NULL,
	[issued_at] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[card_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[category_id] [int] NULL,
	[article] [nvarchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[brand] [nvarchar](255) NULL,
	[size] [nvarchar](255) NULL,
	[color] [nvarchar](255) NULL,
	[purchase_price] [decimal](18, 2) NULL,
	[retail_price] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[promotion_products]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[promotion_products](
	[promotion_product_id] [int] IDENTITY(1,1) NOT NULL,
	[promotion_id] [int] NULL,
	[product_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[promotion_product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[promotions]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[promotions](
	[promotion_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[discount_percent] [decimal](18, 2) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[promotion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[purchase_items]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[purchase_items](
	[purchase_item_id] [int] IDENTITY(1,1) NOT NULL,
	[purchase_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NULL,
	[purchase_price] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[purchase_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[purchases]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[purchases](
	[purchase_id] [int] IDENTITY(1,1) NOT NULL,
	[supplier_id] [int] NULL,
	[store_id] [int] NULL,
	[employee_id] [int] NULL,
	[purchase_date] [datetime] NULL,
	[status] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[purchase_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[returns]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[returns](
	[return_id] [int] IDENTITY(1,1) NOT NULL,
	[sale_item_id] [int] NULL,
	[return_date] [datetime] NULL,
	[reason] [nvarchar](255) NULL,
	[quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[return_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sale_items]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sale_items](
	[sale_item_id] [int] IDENTITY(1,1) NOT NULL,
	[sale_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NULL,
	[price] [decimal](18, 2) NULL,
	[discount_amount] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[sale_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales](
	[sale_id] [int] IDENTITY(1,1) NOT NULL,
	[store_id] [int] NULL,
	[employee_id] [int] NULL,
	[customer_id] [int] NULL,
	[sale_date] [datetime] NULL,
	[total_amount] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[sale_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stock]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stock](
	[stock_id] [int] IDENTITY(1,1) NOT NULL,
	[store_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[stock_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stores]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stores](
	[store_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[address] [nvarchar](255) NULL,
	[phone] [nvarchar](255) NULL,
	[opened_at] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[store_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[suppliers]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[suppliers](
	[supplier_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[contact_person] [nvarchar](255) NULL,
	[phone] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 26.10.2026 13:50:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[Role] [nvarchar](50) NOT NULL,
	[FIO] [nvarchar](255) NOT NULL,
	[Photo] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[categories] ON 
GO
INSERT [dbo].[categories] ([category_id], [name], [parent_category_id]) VALUES (1, N'Мужская одежда', NULL)
GO
INSERT [dbo].[categories] ([category_id], [name], [parent_category_id]) VALUES (2, N'Женская одежда', NULL)
GO
INSERT [dbo].[categories] ([category_id], [name], [parent_category_id]) VALUES (3, N'Верхняя одежда', NULL)
GO
INSERT [dbo].[categories] ([category_id], [name], [parent_category_id]) VALUES (4, N'Футболки', 1)
GO
INSERT [dbo].[categories] ([category_id], [name], [parent_category_id]) VALUES (5, N'Джинсы', 1)
GO
INSERT [dbo].[categories] ([category_id], [name], [parent_category_id]) VALUES (6, N'Платья', 2)
GO
SET IDENTITY_INSERT [dbo].[categories] OFF
GO
SET IDENTITY_INSERT [dbo].[customers] ON 
GO
INSERT [dbo].[customers] ([customer_id], [full_name], [phone], [email], [registered_at]) VALUES (1, N'Козлов Андрей Петрович', N'+7 (900) 111-22-33', N'kozlov@mail.ru', CAST(N'2023-01-15' AS Date))
GO
INSERT [dbo].[customers] ([customer_id], [full_name], [phone], [email], [registered_at]) VALUES (2, N'Никитина Мария Игоревна', N'+7 (900) 444-55-66', N'nikitina@mail.ru', CAST(N'2023-03-20' AS Date))
GO
INSERT [dbo].[customers] ([customer_id], [full_name], [phone], [email], [registered_at]) VALUES (3, N'Волков Дмитрий Сергеевич', N'+7 (900) 777-88-99', N'volkov@mail.ru', CAST(N'2023-05-10' AS Date))
GO
SET IDENTITY_INSERT [dbo].[customers] OFF
GO
SET IDENTITY_INSERT [dbo].[employees] ON 
GO
INSERT [dbo].[employees] ([employee_id], [store_id], [role_id], [full_name], [phone], [hired_at]) VALUES (1, 1, 1, N'Иванов Иван Иванович', N'+7 (999) 111-11-11', CAST(N'2020-06-01' AS Date))
GO
INSERT [dbo].[employees] ([employee_id], [store_id], [role_id], [full_name], [phone], [hired_at]) VALUES (2, 1, 2, N'Петрова Анна Сергеевна', N'+7 (999) 222-22-22', CAST(N'2021-02-15' AS Date))
GO
INSERT [dbo].[employees] ([employee_id], [store_id], [role_id], [full_name], [phone], [hired_at]) VALUES (3, 2, 2, N'Сидоров Алексей Николаевич', N'+7 (999) 333-33-33', CAST(N'2021-12-01' AS Date))
GO
INSERT [dbo].[employees] ([employee_id], [store_id], [role_id], [full_name], [phone], [hired_at]) VALUES (4, 3, 1, N'Кузнецова Елена Владимировна', N'+7 (999) 444-44-44', CAST(N'2022-04-10' AS Date))
GO
INSERT [dbo].[employees] ([employee_id], [store_id], [role_id], [full_name], [phone], [hired_at]) VALUES (5, 1, 3, N'Смирнов Дмитрий Олегович', N'+7 (999) 555-55-55', CAST(N'2023-01-20' AS Date))
GO
SET IDENTITY_INSERT [dbo].[employees] OFF
GO
SET IDENTITY_INSERT [dbo].[loyalty_cards] ON 
GO
INSERT [dbo].[loyalty_cards] ([card_id], [customer_id], [card_number], [bonus_balance], [issued_at]) VALUES (1, 1, N'1111-2222-3333', CAST(150.00 AS Decimal(18, 2)), CAST(N'2023-01-15' AS Date))
GO
INSERT [dbo].[loyalty_cards] ([card_id], [customer_id], [card_number], [bonus_balance], [issued_at]) VALUES (2, 2, N'4444-5555-6666', CAST(300.50 AS Decimal(18, 2)), CAST(N'2023-03-20' AS Date))
GO
INSERT [dbo].[loyalty_cards] ([card_id], [customer_id], [card_number], [bonus_balance], [issued_at]) VALUES (3, 3, N'7777-8888-9999', CAST(50.00 AS Decimal(18, 2)), CAST(N'2023-05-10' AS Date))
GO
SET IDENTITY_INSERT [dbo].[loyalty_cards] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 
GO
INSERT [dbo].[products] ([product_id], [category_id], [article], [name], [brand], [size], [color], [purchase_price], [retail_price]) VALUES (1, 4, N'ART-001', N'Футболка хлопковая', N'Nike', N'L', N'Белый', CAST(1200.00 AS Decimal(18, 2)), CAST(2500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[products] ([product_id], [category_id], [article], [name], [brand], [size], [color], [purchase_price], [retail_price]) VALUES (2, 4, N'ART-002', N'Футболка оверсайз', N'Adidas', N'XL', N'Черный', CAST(1500.00 AS Decimal(18, 2)), CAST(3200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[products] ([product_id], [category_id], [article], [name], [brand], [size], [color], [purchase_price], [retail_price]) VALUES (3, 5, N'ART-003', N'Джинсы классические', N'Levis', N'32', N'Синий', CAST(3500.00 AS Decimal(18, 2)), CAST(6500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[products] ([product_id], [category_id], [article], [name], [brand], [size], [color], [purchase_price], [retail_price]) VALUES (4, 6, N'ART-004', N'Платье летнее', N'Zara', N'M', N'Красный', CAST(2000.00 AS Decimal(18, 2)), CAST(4500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[products] ([product_id], [category_id], [article], [name], [brand], [size], [color], [purchase_price], [retail_price]) VALUES (5, 3, N'ART-005', N'Куртка зимняя', N'Columbia', N'L', N'Черный', CAST(8000.00 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[products] OFF
GO
SET IDENTITY_INSERT [dbo].[promotion_products] ON 
GO
INSERT [dbo].[promotion_products] ([promotion_product_id], [promotion_id], [product_id]) VALUES (1, 1, 1)
GO
INSERT [dbo].[promotion_products] ([promotion_product_id], [promotion_id], [product_id]) VALUES (2, 1, 2)
GO
INSERT [dbo].[promotion_products] ([promotion_product_id], [promotion_id], [product_id]) VALUES (3, 2, 5)
GO
INSERT [dbo].[promotion_products] ([promotion_product_id], [promotion_id], [product_id]) VALUES (4, 3, 3)
GO
SET IDENTITY_INSERT [dbo].[promotion_products] OFF
GO
SET IDENTITY_INSERT [dbo].[promotions] ON 
GO
INSERT [dbo].[promotions] ([promotion_id], [name], [discount_percent], [start_date], [end_date]) VALUES (1, N'Осенняя распродажа', CAST(20.00 AS Decimal(18, 2)), CAST(N'2023-09-01' AS Date), CAST(N'2023-10-31' AS Date))
GO
INSERT [dbo].[promotions] ([promotion_id], [name], [discount_percent], [start_date], [end_date]) VALUES (2, N'Черная пятница', CAST(50.00 AS Decimal(18, 2)), CAST(N'2023-11-24' AS Date), CAST(N'2023-11-27' AS Date))
GO
INSERT [dbo].[promotions] ([promotion_id], [name], [discount_percent], [start_date], [end_date]) VALUES (3, N'Скидка на джинсы', CAST(15.00 AS Decimal(18, 2)), CAST(N'2023-10-15' AS Date), CAST(N'2023-11-15' AS Date))
GO
SET IDENTITY_INSERT [dbo].[promotions] OFF
GO
SET IDENTITY_INSERT [dbo].[purchase_items] ON 
GO
INSERT [dbo].[purchase_items] ([purchase_item_id], [purchase_id], [product_id], [quantity], [purchase_price]) VALUES (1, 1, 1, 50, CAST(1200.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[purchase_items] ([purchase_item_id], [purchase_id], [product_id], [quantity], [purchase_price]) VALUES (2, 1, 2, 30, CAST(1500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[purchase_items] ([purchase_item_id], [purchase_id], [product_id], [quantity], [purchase_price]) VALUES (3, 2, 3, 20, CAST(3500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[purchase_items] ([purchase_item_id], [purchase_id], [product_id], [quantity], [purchase_price]) VALUES (4, 3, 4, 40, CAST(2000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[purchase_items] ([purchase_item_id], [purchase_id], [product_id], [quantity], [purchase_price]) VALUES (5, 3, 5, 10, CAST(8000.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[purchase_items] OFF
GO
SET IDENTITY_INSERT [dbo].[purchases] ON 
GO
INSERT [dbo].[purchases] ([purchase_id], [supplier_id], [store_id], [employee_id], [purchase_date], [status]) VALUES (1, 1, 1, 4, CAST(N'2023-01-10T10:00:00.000' AS DateTime), N'Доставлено')
GO
INSERT [dbo].[purchases] ([purchase_id], [supplier_id], [store_id], [employee_id], [purchase_date], [status]) VALUES (2, 2, 2, 4, CAST(N'2023-05-10T14:30:00.000' AS DateTime), N'В пути')
GO
INSERT [dbo].[purchases] ([purchase_id], [supplier_id], [store_id], [employee_id], [purchase_date], [status]) VALUES (3, 3, 3, 4, CAST(N'2023-10-10T09:15:00.000' AS DateTime), N'Доставлено')
GO
SET IDENTITY_INSERT [dbo].[purchases] OFF
GO
SET IDENTITY_INSERT [dbo].[roles] ON 
GO
INSERT [dbo].[roles] ([role_id], [title]) VALUES (1, N'Директор')
GO
INSERT [dbo].[roles] ([role_id], [title]) VALUES (2, N'Продавец-консультант')
GO
INSERT [dbo].[roles] ([role_id], [title]) VALUES (3, N'Кассир')
GO
INSERT [dbo].[roles] ([role_id], [title]) VALUES (4, N'Менеджер по закупкам')
GO
SET IDENTITY_INSERT [dbo].[roles] OFF
GO
SET IDENTITY_INSERT [dbo].[stock] ON 
GO
INSERT [dbo].[stock] ([stock_id], [store_id], [product_id], [quantity]) VALUES (1, 1, 1, 20)
GO
INSERT [dbo].[stock] ([stock_id], [store_id], [product_id], [quantity]) VALUES (2, 1, 2, 15)
GO
INSERT [dbo].[stock] ([stock_id], [store_id], [product_id], [quantity]) VALUES (3, 2, 3, 10)
GO
INSERT [dbo].[stock] ([stock_id], [store_id], [product_id], [quantity]) VALUES (4, 3, 4, 25)
GO
INSERT [dbo].[stock] ([stock_id], [store_id], [product_id], [quantity]) VALUES (5, 1, 5, 5)
GO
SET IDENTITY_INSERT [dbo].[stock] OFF
GO
SET IDENTITY_INSERT [dbo].[stores] ON 
GO
INSERT [dbo].[stores] ([store_id], [name], [address], [phone], [opened_at]) VALUES (1, N'Магазин на Тверской', N'г. Москва, ул. Тверская, д. 15', N'+7 (495) 123-45-67', CAST(N'2020-05-10' AS Date))
GO
INSERT [dbo].[stores] ([store_id], [name], [address], [phone], [opened_at]) VALUES (2, N'ТЦ Европейский', N'г. Москва, пл. Киевского Вокзала, д. 2', N'+7 (495) 987-65-43', CAST(N'2021-11-20' AS Date))
GO
INSERT [dbo].[stores] ([store_id], [name], [address], [phone], [opened_at]) VALUES (3, N'Магазин в Санкт-Петербурге', N'г. СПб, Невский проспект, д. 50', N'+7 (812) 111-22-33', CAST(N'2022-03-15' AS Date))
GO
SET IDENTITY_INSERT [dbo].[stores] OFF
GO
SET IDENTITY_INSERT [dbo].[suppliers] ON 
GO
INSERT [dbo].[suppliers] ([supplier_id], [name], [contact_person], [phone], [email]) VALUES (1, N'ООО "Текстиль-Опт"', N'Сергеев Сергей', N'+7 (495) 111-22-33', N'textil@mail.ru')
GO
INSERT [dbo].[suppliers] ([supplier_id], [name], [contact_person], [phone], [email]) VALUES (2, N'ИП "Модный Стиль"', N'Смирнова Ольга', N'+7 (812) 444-55-66', N'style@mail.ru')
GO
INSERT [dbo].[suppliers] ([supplier_id], [name], [contact_person], [phone], [email]) VALUES (3, N'Фабрика "Одежда-Про"', N'Николаев Петр', N'+7 (800) 777-88-99', N'pro@mail.ru')
GO
SET IDENTITY_INSERT [dbo].[suppliers] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([ID], [Login], [Password], [Role], [FIO], [Photo]) VALUES (1, N'admin', N'admin123', N'Администратор', N'Кузьмина Ксения Сергеевна', NULL)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__loyalty___1E6E0AF437BDB61C]    Script Date: 26.10.2026 13:50:32 ******/
ALTER TABLE [dbo].[loyalty_cards] ADD UNIQUE NONCLUSTERED 
(
	[card_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__products__8D48A8992AC36F2A]    Script Date: 26.10.2026 13:50:32 ******/
ALTER TABLE [dbo].[products] ADD UNIQUE NONCLUSTERED 
(
	[article] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__5E55825BAE6CC5A4]    Script Date: 26.10.2026 13:50:32 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[categories]  WITH CHECK ADD FOREIGN KEY([parent_category_id])
REFERENCES [dbo].[categories] ([category_id])
GO
ALTER TABLE [dbo].[employees]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([role_id])
GO
ALTER TABLE [dbo].[employees]  WITH CHECK ADD FOREIGN KEY([store_id])
REFERENCES [dbo].[stores] ([store_id])
GO
ALTER TABLE [dbo].[loyalty_cards]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customers] ([customer_id])
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[categories] ([category_id])
GO
ALTER TABLE [dbo].[promotion_products]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([product_id])
GO
ALTER TABLE [dbo].[promotion_products]  WITH CHECK ADD FOREIGN KEY([promotion_id])
REFERENCES [dbo].[promotions] ([promotion_id])
GO
ALTER TABLE [dbo].[purchase_items]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([product_id])
GO
ALTER TABLE [dbo].[purchase_items]  WITH CHECK ADD FOREIGN KEY([purchase_id])
REFERENCES [dbo].[purchases] ([purchase_id])
GO
ALTER TABLE [dbo].[purchases]  WITH CHECK ADD FOREIGN KEY([employee_id])
REFERENCES [dbo].[employees] ([employee_id])
GO
ALTER TABLE [dbo].[purchases]  WITH CHECK ADD FOREIGN KEY([store_id])
REFERENCES [dbo].[stores] ([store_id])
GO
ALTER TABLE [dbo].[purchases]  WITH CHECK ADD FOREIGN KEY([supplier_id])
REFERENCES [dbo].[suppliers] ([supplier_id])
GO
ALTER TABLE [dbo].[returns]  WITH CHECK ADD FOREIGN KEY([sale_item_id])
REFERENCES [dbo].[sale_items] ([sale_item_id])
GO
ALTER TABLE [dbo].[sale_items]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([product_id])
GO
ALTER TABLE [dbo].[sale_items]  WITH CHECK ADD FOREIGN KEY([sale_id])
REFERENCES [dbo].[sales] ([sale_id])
GO 
ALTER TABLE [dbo].[sales]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customers] ([customer_id])
GO
ALTER TABLE [dbo].[sales]  WITH CHECK ADD FOREIGN KEY([employee_id])
REFERENCES [dbo].[employees] ([employee_id])
GO
ALTER TABLE [dbo].[sales]  WITH CHECK ADD FOREIGN KEY([store_id])
REFERENCES [dbo].[stores] ([store_id])
GO
ALTER TABLE [dbo].[stock]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([product_id])
GO
ALTER TABLE [dbo].[stock]  WITH CHECK ADD FOREIGN KEY([store_id])
REFERENCES [dbo].[stores] ([store_id])
GO
