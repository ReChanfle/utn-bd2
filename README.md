
E-Commerce Database Schema
Este repositorio contiene un script SQL completo para la creación y gestión de una base de datos relacional orientada a un sistema de comercio electrónico (E-Commerce) y gestión de ventas en sucursales.

El script está escrito en T-SQL (compatible con Microsoft SQL Server) e incluye la creación de tablas, relaciones, datos de prueba, vistas, procedimientos almacenados, triggers y scripts de limpieza.

📋 Características Principales
El modelo de datos cubre los módulos esenciales de un sistema de ventas:

Catálogo de Productos: Gestión de productos, categorías, atributos (color, tamaño), precios y control de stock por sucursal.

Gestión de Usuarios y Clientes: Roles de sistema (Admin, Vendedor), perfiles de clientes y gestión de suscripciones (Básica, Premium).

Gestión de Ventas y Carrito: Flujo completo desde la creación de un carrito de compras hasta su conversión en una venta procesada.

Localización: Estructura geográfica para países, provincias y sucursales comerciales.

🗄️ Estructura de Tablas
Las tablas están organizadas en las siguientes áreas lógicas:

Usuarios y Clientes: users, user_roles, customers, subscriptions, subscription_types.

Inventario y Productos: products, product_categories, product_attributes, product_attribute_rel, product_prices, product_stocks.

Ventas y Operaciones: shopping_carts, shopping_carts_items, sales, sale_items.

Geografía y Sucursales: stores, provinces, countries.

⚙️ Lógica de Negocio Integrada
El script no solo define la estructura, sino que automatiza procesos mediante programación en la base de datos:

Vistas (Views)
VW_SalesDetails: Reporte detallado de ventas, clientes, productos y subtotales.

VW_ProductDetails: Resumen de productos incluyendo categoría, precio actual y stock total consolidado.

VW_ActiveSuscriptions: Listado de clientes con suscripciones activas, planes y vigencia.

Procedimientos Almacenados (Stored Procedures)
SP_GenerateSaleFromShoppingCart: Toma un carrito de compras activo, calcula los totales, genera la venta, transfiere los ítems y cierra el carrito. Funciona dentro de una transacción para garantizar la integridad de los datos.

SP_ReportSalesByDate: Genera un reporte de ventas filtrado por un rango de fechas específico.

Triggers
TR_SubtrackStockFromSale: Descuenta automáticamente el stock del inventario de la sucursal correspondiente cuando se insertan ítems en una venta.

TR_ReStockAferCanceledSale: Devuelve automáticamente las cantidades de producto al stock de la sucursal si una venta cambia su estado a CANCELED.

🚀 Cómo usar este script
Abre tu gestor de base de datos (ej. SQL Server Management Studio o Azure Data Studio).

Crea una base de datos nueva vacía.

Copia y pega el contenido del archivo .sql.

⚠️ IMPORTANTE: El script incluye una sección de pruebas al final (EXEC, UPDATE, SELECT) seguida inmediatamente por un script de limpieza (Teardown) que borra todos los datos, relaciones y tablas.

Si deseas conservar la base de datos para explorarla, comenta o elimina las líneas desde -- 1. Desactivar todas las restricciones de claves foráneas hacia abajo antes de ejecutar.

🧹 Script de Limpieza (Teardown)
Al final del archivo se incluyen utilidades prácticas para reiniciar el entorno de desarrollo:

Vaciado masivo de tablas sin romper la integridad referencial.

Eliminación dinámica de todas las Foreign Keys.

Eliminación iterativa de todas las tablas, vistas, triggers y procedimientos.
