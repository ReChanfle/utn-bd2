
----SQL TP----
CREATE TABLE [products] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[name] NVARCHAR(255) NOT NULL,
	[description] NVARCHAR(255),
	[category_id] BIGINT NOT NULL,
	[is_active] BIT NOT NULL,
	[created_at] DATETIME NOT NULL,
	PRIMARY KEY([id])
);


CREATE TABLE [users] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[role_id] BIGINT NOT NULL,
	[firstname] NVARCHAR(255) NOT NULL,
	[lastname] NVARCHAR(255) NOT NULL,
	[email] NVARCHAR(255) NOT NULL UNIQUE,
	[username] NVARCHAR(255) NOT NULL UNIQUE,
	[password] NVARCHAR(255) NOT NULL,
	[is_active] BIT NOT NULL,
	[created_at] DATETIME NOT NULL,
	[updated_at] DATETIME,
	[country_id] BIGINT NOT NULL,
	[province_id] BIGINT NOT NULL,
	PRIMARY KEY([id])
);


CREATE TABLE [shopping_carts] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[customer_id] BIGINT NOT NULL,
	[store_id] BIGINT NOT NULL,
	[status] NVARCHAR(255) NOT NULL,
	[created_at] DATETIME NOT NULL,
	[updated_at] DATETIME,
	[deleted_at] DATETIME,
	PRIMARY KEY([id])
);


CREATE TABLE [customers] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[firstname] NVARCHAR(255) NOT NULL,
	[lastname] NVARCHAR(255) NOT NULL,
	[email] NVARCHAR(255) NOT NULL UNIQUE,
	[username] NVARCHAR(255) NOT NULL,
	[password] NVARCHAR(225) NOT NULL,
	[document] INT NOT NULL UNIQUE,
	[country_id] BIGINT NOT NULL,
	[province_id] BIGINT NOT NULL,
	[is_active] BIT NOT NULL,
	[suscription_id] BIGINT,
	[created_at] DATETIME NOT NULL,
	PRIMARY KEY([id])
);


CREATE TABLE [subscriptions] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[customer_id] BIGINT NOT NULL,
	[subscription_type_id] BIGINT NOT NULL,
	[start_at] DATETIME NOT NULL,
	[end_at] DATETIME NOT NULL,
	[status] BIT NOT NULL,
	PRIMARY KEY([id])
);


CREATE TABLE [product_attributes] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[name] NVARCHAR(255) NOT NULL UNIQUE,
	[code] NVARCHAR(255) NOT NULL UNIQUE,
	[created_at] DATETIME NOT NULL,
	PRIMARY KEY([id])
);


CREATE TABLE [product_attribute_rel] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[product_id] BIGINT NOT NULL,
	[product_attribute_id] BIGINT NOT NULL,
	PRIMARY KEY([id])
);

CREATE TABLE [product_categories] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[name] NVARCHAR(255) NOT NULL UNIQUE,
	[code] NVARCHAR(255) NOT NULL UNIQUE,
	[is_active] BIT NOT NULL,
	[created_at] DATETIME NOT NULL,
	[description] NVARCHAR(255),
	PRIMARY KEY([id])
);


CREATE TABLE [product_prices] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[product_id] BIGINT NOT NULL,
	[price] FLOAT NOT NULL,
	[sale_price] FLOAT,
	PRIMARY KEY([id])
);


CREATE TABLE [product_stocks] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[product_id] BIGINT NOT NULL,
	[quantity] INT NOT NULL,
	[store_id] BIGINT NOT NULL,
	[created_at] DATETIME NOT NULL,
	[udated_at] DATETIME,
	PRIMARY KEY([id])
);


CREATE TABLE [stores] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[name] NVARCHAR(255) NOT NULL UNIQUE,
	[code] NVARCHAR(255) UNIQUE,
	[province_id] BIGINT NOT NULL,
	[country_id] BIGINT NOT NULL,
	[created_at] DATETIME NOT NULL,
	PRIMARY KEY([id])
);


CREATE TABLE [provinces] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[name] NVARCHAR(255) NOT NULL UNIQUE,
	[code] NVARCHAR(255) NOT NULL UNIQUE,
	[country_id] BIGINT NOT NULL,
	[created_at] DATETIME NOT NULL,
	PRIMARY KEY([id])
);


CREATE TABLE [countries] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[name] NVARCHAR(255) NOT NULL UNIQUE,
	[code] NVARCHAR(255) NOT NULL UNIQUE,
	[created_at] DATETIME,
	PRIMARY KEY([id])
);

CREATE TABLE [sales] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[customer_id] BIGINT NOT NULL,
	[shopping_cart_id] BIGINT NOT NULL,
	[store_id] BIGINT NOT NULL,
	[status] NVARCHAR(255),
 	[total_amount] FLOAT NOT NULL,
 	[updated_at] DATETIME,
	[created_at] DATETIME NOT NULL,
	PRIMARY KEY([id])
);


CREATE TABLE [user_roles] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[name] NVARCHAR(255) NOT NULL,
	[code] NVARCHAR(255) NOT NULL,
	[created_at] DATETIME NOT NULL,
	PRIMARY KEY([id])
);


CREATE TABLE [subscription_types] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[name] NVARCHAR(255) NOT NULL UNIQUE,
	[code] NVARCHAR(255) NOT NULL UNIQUE,
	[discount_percentage] FLOAT NOT NULL,
	[created_at] DATETIME NOT NULL,
	PRIMARY KEY([id])
);


CREATE TABLE [sale_items] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[sale_id] BIGINT,
	[product_id] BIGINT,
	[quantity] INT NOT NULL,
	[price_at_time] FLOAT NOT NULL,
	[created_at] DATETIME,
	PRIMARY KEY([id])
);


CREATE TABLE [shopping_carts_items] (
	[id] BIGINT NOT NULL IDENTITY UNIQUE,
	[shopping_cart_id] BIGINT NOT NULL,
	[product_id] BIGINT NOT NULL,
	[quantity] INT NOT NULL,
	[price_at_time] FLOAT NOT NULL,
	[created_at] DATETIME NOT NULL,
	PRIMARY KEY([id])
);

-- products → products_categories
ALTER TABLE [products]
ADD FOREIGN KEY ([category_id]) REFERENCES [product_categories]([id]);

-- users → user_roles
ALTER TABLE [users]
ADD FOREIGN KEY ([role_id]) REFERENCES [user_roles]([id]);

-- users → countries
ALTER TABLE [users]
ADD FOREIGN KEY ([country_id]) REFERENCES [countries]([id]);

-- users → provinces
ALTER TABLE [users]
ADD FOREIGN KEY ([province_id]) REFERENCES [provinces]([id]);

-- customers → countries
ALTER TABLE [customers]
ADD FOREIGN KEY ([country_id]) REFERENCES [countries]([id]);

-- customers → provinces
ALTER TABLE [customers]
ADD FOREIGN KEY ([province_id]) REFERENCES [provinces]([id]);

-- customers → subscriptions
ALTER TABLE [customers]
ADD FOREIGN KEY ([suscription_id]) REFERENCES [subscriptions]([id]);

-- shopping_carts → customers
ALTER TABLE [shopping_carts]
ADD FOREIGN KEY ([customer_id]) REFERENCES [customers]([id]);

-- subscriptions → customers
ALTER TABLE [subscriptions]
ADD FOREIGN KEY ([customer_id]) REFERENCES [customers]([id]);

-- subscriptions → subscriptions_type
ALTER TABLE [subscriptions]
ADD FOREIGN KEY ([subscription_type_id]) REFERENCES [subscription_types]([id]);

-- product_attribute_rel → products
ALTER TABLE [product_attribute_rel]
ADD FOREIGN KEY ([product_id]) REFERENCES [products]([id]);

-- product_attribute_rel → product_attributes
ALTER TABLE [product_attribute_rel]
ADD FOREIGN KEY ([product_attribute_id]) REFERENCES [product_attributes]([id]);

-- product_prices → products
ALTER TABLE [product_prices]
ADD FOREIGN KEY ([product_id]) REFERENCES [products]([id]);

-- product_stocks → products
ALTER TABLE [product_stocks]
ADD FOREIGN KEY ([product_id]) REFERENCES [products]([id]);

-- product_stocks → stores
ALTER TABLE [product_stocks]
ADD FOREIGN KEY ([store_id]) REFERENCES [stores]([id]);

-- stores → provinces
ALTER TABLE [stores]
ADD FOREIGN KEY ([province_id]) REFERENCES [provinces]([id]);

-- stores → countries
ALTER TABLE [stores]
ADD FOREIGN KEY ([country_id]) REFERENCES [countries]([id]);

-- provinces → countries
ALTER TABLE [provinces]
ADD FOREIGN KEY ([country_id]) REFERENCES [countries]([id]);

-- sales → customers
ALTER TABLE [sales]
ADD FOREIGN KEY ([customer_id]) REFERENCES [customers]([id]);

ALTER TABLE [sales]
ADD FOREIGN KEY ([store_id]) REFERENCES [stores]([id]);

ALTER TABLE [shopping_carts]
ADD FOREIGN KEY ([store_id]) REFERENCES [stores]([id])

-- sales → shopping_carts
ALTER TABLE [sales]
ADD FOREIGN KEY ([shopping_cart_id]) REFERENCES [shopping_carts]([id]);

-- sale_items → sales
ALTER TABLE [sale_items]
ADD FOREIGN KEY ([sale_id]) REFERENCES [sales]([id]);

-- sale_items → products
ALTER TABLE [sale_items]
ADD FOREIGN KEY ([product_id]) REFERENCES [products]([id]);

-- shopping_carts_items → shopping_carts
ALTER TABLE [shopping_carts_items]
ADD FOREIGN KEY ([shopping_cart_id]) REFERENCES [shopping_carts]([id]);

-- shopping_carts_items → products
ALTER TABLE [shopping_carts_items]
ADD FOREIGN KEY ([product_id]) REFERENCES [products]([id]);

---- Valores de prueba----

INSERT INTO [countries] ([name], [code], [created_at]) VALUES 
('Argentina', 'AR', GETDATE()),
('México', 'MX', GETDATE());

INSERT INTO [user_roles] ([name], [code], [created_at]) VALUES 
('Administrador', 'ADMIN', GETDATE()),
('Vendedor', 'SELLER', GETDATE());

INSERT INTO [subscription_types] ([name], [code], [discount_percentage], [created_at]) VALUES 
('Básica', 'BASIC', 5.0, GETDATE()),
('Premium', 'PREMIUM', 15.0, GETDATE());

INSERT INTO [product_categories] ([name], [code], [is_active], [created_at], [description]) VALUES 
('Electrónica', 'ELEC', 1, GETDATE(), 'Artículos tecnológicos y gadgets'),
('Ropa', 'CLOTH', 1, GETDATE(), 'Indumentaria general');

INSERT INTO [product_attributes] ([name], [code], [created_at]) VALUES 
('Color', 'COLOR', GETDATE()),
('Tamaño', 'SIZE', GETDATE());

-- 2. Nivel 1
INSERT INTO [provinces] ([name], [code], [country_id], [created_at]) VALUES 
('Buenos Aires', 'BUE', 1, GETDATE()),
('Ciudad de México', 'CDMX', 2, GETDATE());

INSERT INTO [products] ([name], [description], [category_id], [is_active], [created_at]) VALUES 
('Smartphone XYZ', 'Teléfono inteligente de última generación', 1, 1, GETDATE()),
('Camiseta Algodón', 'Camiseta básica 100% algodón', 2, 1, GETDATE());

INSERT INTO [stores] ([name], [code], [province_id], [country_id], [created_at]) VALUES 
('Sucursal Central', 'STORE_MAIN', 1, 1, GETDATE()),
('Sucursal Norte', 'STORE_NORTH', 2, 2, GETDATE());

-- 3. Nivel 2
INSERT INTO [users] ([role_id], [firstname], [lastname], [email], [username], [password], [is_active], [created_at], [updated_at], [country_id], [province_id]) VALUES 
(1, 'Juan', 'Pérez', 'admin@tienda.com', 'juan.admin', 'hash_pwd_123', 1, GETDATE(), NULL, 1, 1),
(2, 'María', 'López', 'vendedor1@tienda.com', 'maria.seller', 'hash_pwd_456', 1, GETDATE(), NULL, 1, 1);

INSERT INTO [customers] ([firstname], [lastname], [email], [username], [password], [document], [country_id], [province_id], [is_active], [suscription_id], [created_at]) VALUES 
('Carlos', 'Gómez', 'carlos.g@email.com', 'carlosg', 'hash_pwd_789', 11223344, 1, 1, 1, NULL, GETDATE()),
('Ana', 'Martínez', 'ana.m@email.com', 'anamart', 'hash_pwd_012', 55667788, 2, 2, 1, NULL, GETDATE());

INSERT INTO [product_prices] ([product_id], [price], [sale_price]) VALUES 
(1, 599.99, 549.99),
(2, 25.00, NULL);

INSERT INTO [product_attribute_rel] ([product_id], [product_attribute_id]) VALUES 
(1, 1),
(2, 2);


INSERT INTO [product_stocks] ([product_id], [quantity], [store_id], [created_at], [udated_at]) VALUES 
(1, 50, 1, GETDATE(), NULL),  -- 50 Smartphones en Sucursal Central (ID 1)
(2, 150, 2, GETDATE(), NULL); -- 150 Camisetas en Sucursal Norte (ID 2)


INSERT INTO [subscriptions] ([customer_id], [subscription_type_id], [start_at], [end_at], [status]) VALUES 
(1, 2, GETDATE(), DATEADD(year, 1, GETDATE()), 1),
(2, 1, GETDATE(), DATEADD(month, 1, GETDATE()), 1);

UPDATE [customers] SET [suscription_id] = 1 WHERE [id] = 1;
UPDATE [customers] SET [suscription_id] = 2 WHERE [id] = 2;


INSERT INTO [shopping_carts] ([customer_id], [store_id], [status], [created_at], [updated_at], [deleted_at]) VALUES 
(1, 1, 'ACTIVO', GETDATE(), NULL, NULL),  
(2, 2, 'CERRADO', GETDATE(), NULL, NULL); 

INSERT INTO [shopping_carts_items] ([shopping_cart_id], [product_id], [quantity], [price_at_time], [created_at]) VALUES 
(1, 1, 1, 549.99, GETDATE()), -- 1 Smartphone en carrito 1
(2, 2, 3, 25.00, GETDATE());  -- 3 Camisetas en carrito 2


INSERT INTO [sales] ([customer_id], [shopping_cart_id], [store_id], [status], [total_amount], [created_at]) VALUES 
(2, 2, 2, 'COMPLETED', 75.00, GETDATE());


INSERT INTO [sale_items] ([sale_id], [product_id], [quantity], [price_at_time], [created_at]) VALUES 
(1, 2, 3, 25.00, GETDATE());

-- Vista 1 -> detalle de venta

CREATE VIEW VW_SalesDetails AS
SELECT
   s.id AS sale_id,
   c.firstname + ' ' + c.lastname AS customer_name,
   s.total_amount,
   s.created_at AS sale_date,
   p.name AS product_name,
   si.quantity,
   si.price_at_time,
   (si.quantity * si.price_at_time) AS subtotal
FROM sales s
INNER JOIN customers c ON s.customer_id = c.id
INNER JOIN sale_items si ON s.id = si.sale_id
INNER JOIN products p ON si.product_id = p.id;

-- Vista 2 -> 

CREATE VIEW VW_ProductDetails AS
SELECT
p.id AS product_id,
p.name AS product_name,
p.description,
pc.name AS category_name,
pp.price AS current_price,
ISNULL(SUM(ps.quantity), 0) AS total_stock
FROM products p
INNER JOIN product_categories pc ON p.category_id = pc.id
LEFT JOIN product_prices pp ON p.id = pp.product_id
LEFT JOIN product_stocks ps ON p.id = ps.product_id
GROUP BY
p.id, p.name, p.description, pc.name, pp.price;

-- Vista 3 -> 

CREATE VIEW VW_ActiveSuscriptions AS
SELECT
c.id AS customer_id,
c.firstname + ' ' + c.lastname AS customer_name,
st.name AS subscription_plan,
st.discount_percentage,
sub.start_at,
sub.end_at
FROM subscriptions sub
INNER JOIN customers c ON sub.customer_id = c.id
INNER JOIN subscription_types st ON sub.subscription_type_id = st.id
WHERE sub.status = 1
AND sub.end_at >= GETDATE();

--Procedimiento 1 -> generar venta

CREATE PROCEDURE SP_GenerateSaleFromShoppingCart
    @shopping_cart_id BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @customer_id BIGINT;
        DECLARE @store_id BIGINT; -- Variable para almacenar la tienda del carrito
        DECLARE @total FLOAT;

        -- 1. Validar que el carrito exista, no esté cerrado, y obtener cliente y tienda
        SELECT @customer_id = customer_id,
               @store_id = store_id
        FROM shopping_carts
        WHERE id = @shopping_cart_id
          AND status != 'CERRADO';

        IF @customer_id IS NULL OR @store_id IS NULL
        BEGIN
            RAISERROR('Carrito inexistente, cerrado o sin sucursal asignada', 16, 1);
            ROLLBACK;
            RETURN;
        END

        -- 2. Calcular el total del carrito
        SELECT @total = ISNULL(SUM(quantity * price_at_time), 0)
        FROM shopping_carts_items
        WHERE shopping_cart_id = @shopping_cart_id;

        -- 3. Insertar la venta usando el store_id obtenido del carrito
        INSERT INTO sales (
            customer_id, 
            store_id, 
            shopping_cart_id, 
            status,
            total_amount, 
            created_at,
            updated_at
        )
        VALUES (
            @customer_id, 
            @store_id, 
            @shopping_cart_id, 
            'PROCESADA', 
            @total, 
            GETDATE(),
            GETDATE()
        );

        DECLARE @sale_id BIGINT = SCOPE_IDENTITY();

        -- 4. Pasar los items del carrito a los items de la venta
        INSERT INTO sale_items (sale_id, product_id, quantity, price_at_time, created_at)
        SELECT @sale_id, product_id, quantity, price_at_time, GETDATE()
        FROM shopping_carts_items
        WHERE shopping_cart_id = @shopping_cart_id;

        -- 5. Cerrar el carrito
        UPDATE shopping_carts
        SET status = 'CERRADO',
            updated_at = GETDATE()
        WHERE id = @shopping_cart_id;

        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        THROW;
    END CATCH
END;

-- Procedimiento 2 -> generar reporte

CREATE PROCEDURE SP_ReportSalesByDate
@FechaInicio DATETIME,
@FechaFin DATETIME
AS
BEGIN
SET NOCOUNT ON;

SELECT
s.id AS SaleID,
c.firstname + ' ' + c.lastname AS CustomerName,
s.total_amount,
s.created_at AS SaleDate
FROM sales s
INNER JOIN customers c ON s.customer_id = c.id
WHERE s.created_at BETWEEN @FechaInicio AND @FechaFin
ORDER BY s.created_at DESC;
END;

-- Trigger de stock -> descontar, se ejecuta despues del insert del procedure de generar ventas en sales_items

CREATE OR ALTER TRIGGER TR_SubtrackStockFromSale
ON sale_items
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE ps
    SET ps.quantity = ps.quantity - i.quantity
    FROM product_stocks ps
    INNER JOIN inserted i ON ps.product_id = i.product_id
    INNER JOIN sales s ON i.sale_id = s.id 
    WHERE ps.store_id = s.store_id;
END;

-- Trigger de venta cancelada -> sumar

CREATE OR ALTER TRIGGER TR_ReStockAferCanceledSale
ON sales
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(status)
    BEGIN
        -- Agrupamos las cantidades a devolver por producto y sucursal
        WITH StockADevolver AS (
            SELECT 
                si.product_id,
                i.store_id,
                SUM(si.quantity) as TotalQuantityToRestore
            FROM inserted i
            INNER JOIN deleted d ON i.id = d.id
            INNER JOIN sale_items si ON i.id = si.sale_id
            WHERE i.status = 'CANCELED' AND d.status <> 'CANCELED'
            GROUP BY si.product_id, i.store_id
        )
        -- Actualizamos el stock
        UPDATE ps
        SET ps.quantity = ps.quantity + sad.TotalQuantityToRestore
        FROM product_stocks ps
        INNER JOIN StockADevolver sad 
            ON ps.product_id = sad.product_id 
            AND ps.store_id = sad.store_id; 
    END
END;
---Prueba store procedure crear venta----

EXEC SP_GenerateSaleFromShoppingCart 1;

---Prueba store procedure generar reporte----

EXEC SP_ReportSalesByDate 
    @FechaInicio = '2026-01-01',
    @FechaFin = '2026-12-31';

----Prueba trigger anulacion de venta----

UPDATE sales
SET status = 'CANCELED'
WHERE id = 2;

-- Pruebas vistas --

SELECT * FROM VW_SalesDetails;

SELECT * FROM VW_ProductDetails;

SELECT * FROM VW_ActiveSuscriptions;


-- 1. Desactivar todas las restricciones de claves foráneas
EXEC sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all";

-- 2. Borrar los datos de todas las tablas
DELETE FROM sale_items;
DELETE FROM shopping_carts_items;
DELETE FROM sales;
DELETE FROM shopping_carts;
DELETE FROM subscriptions;
DELETE FROM customers;
DELETE FROM users;
DELETE FROM product_stocks;
DELETE FROM stores;
DELETE FROM product_prices;
DELETE FROM product_attribute_rel;
DELETE FROM product_attributes;
DELETE FROM products;
DELETE FROM product_categories;
DELETE FROM provinces;
DELETE FROM countries;
DELETE FROM user_roles;
DELETE FROM subscriptions_types;

-- 3. Activar nuevamente las restricciones de claves foráneas
EXEC sp_MSforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all";

-- 1. Eliminar todas las relaciones (Claves Foráneas) de la base de datos
DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += N'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id))
    + '.' + QUOTENAME(OBJECT_NAME(parent_object_id)) 
    + ' DROP CONSTRAINT ' + QUOTENAME(name) + ';' + CHAR(13) + CHAR(10)
FROM sys.foreign_keys;

EXEC sp_executesql @sql;

-- 2. Eliminar (Dropear) todas las tablas usando el procedimiento interno
EXEC sp_MSforeachtable 'DROP TABLE ?';

-- Drop SP, Triggers y Views ----

DROP PROCEDURE IF EXISTS  SP_GenerateSaleFromShoppingCart;
DROP PROCEDURE IF EXISTS  SP_ReportSalesByDate;

DROP TRIGGER IF EXISTS TR_SubtrackStockFromSale;
DROP TRIGGER IF EXISTS TR_ReStockAferCanceledSale;
 
DROP VIEW IF EXISTS VW_SalesDetails;
DROP VIEW IF EXISTS VW_ProductDetails;
DROP VIEW IF EXISTS VW_ActiveSuscriptions;
 



