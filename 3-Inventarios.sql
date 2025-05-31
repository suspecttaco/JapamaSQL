use BD_JAPAMA
go

/*
============================================
    MÓDULO DE INVENTARIOS
============================================
Este script crea las tablas necesarias para gestionar:
- Materiales y sus tipos
- Mobiliario y sus categorías 
- Vehículos, talleres y reportes
- Control de inventario general
- Facturación, proveedores y compras
*/

-- Catálogos de materiales
create table [Inventarios].[TipoMaterial]
(
    [TipoMaterialId] int primary key identity (1,1) not null, -- Llave primaria autoincremental
    [descripcion]    varchar(50),                             -- Tipo de material (herramientas, consumibles, etc)
    [fecha_mod]      datetime                       not null  -- Auditoría de modificación
)
GO

create table [Inventarios].[Material]
(
    [MaterialId]     int primary key identity (1,1) not null,                                    -- ID único del material
    [nombre]         varchar(50)                    not null,                                    -- Nombre descriptivo
    [descripcion]    varchar(50),                                                                -- Detalles adicionales
    [actividad]      varchar(1)                     not null,                                    -- Estado A=Activo, I=Inactivo
    [TipoMaterialId] int foreign key references [Inventarios].[TipoMaterial] ([TipoMaterialId]), -- FK al tipo
    [fecha_mod]      datetime                       not null                                     -- Auditoría
)
GO

-- Catálogos de mobiliario
create table [Inventarios].[TipoMobiliario]
(
    [TipoMobiliarioId] int primary key identity (1,1) not null, -- ID del tipo
    [descripcion]      varchar(50)                    not null, -- Categoría (escritorios, sillas, etc)
    fecha_mod          datetime                       not null  -- Auditoría
)
GO

create table [Inventarios].[Mobiliario]
(
    [MobiliarioId]     int primary key identity (1,1) not null,                                        -- ID único
    [nombre]           varchar(50)                    not null,                                        -- Nombre del mueble
    [descripcion]      varchar(50)                    not null,                                        -- Características
    [actividad]        varchar(1)                     not null,                                        -- A=Activo, I=Inactivo
    [TipoMobiliarioId] int foreign key references [Inventarios].[TipoMobiliario] ([TipoMobiliarioId]), -- FK al tipo
    [fecha_mod]        datetime                       not null,                                        -- Auditoría
)
GO

-- Control de vehículos y mantenimiento
create table [Inventarios].[TallerVehiculo]
(
    [TallerId]  int primary key identity not null, -- ID del taller
    [PersonaId] bigint,                            -- FK a tabla de personas (encargado)
    [fecha_mod] datetime                 not null  -- Auditoría
)
GO

create table [Inventarios].[TipoVehiculo]
(
    [TipoVehiculoId] int primary key identity (1,1) not null, -- ID del tipo
    [nombre]         varchar(50)                    not null, -- Categoría (sedan, pickup, etc)
    [fecha_mod]      datetime                       not null  -- Auditoría
)
GO

create table [Inventarios].[Vehiculo]
(
    [VehiculoId]        int primary key identity (1,1) not null,                                    -- ID único
    [TipoVehiculoId]    int foreign key references [Inventarios].[TipoVehiculo] ([TipoVehiculoId]), -- FK al tipo
    [matricula]         varchar(20)                    not null,                                    -- Placa del vehículo
    [actividad]         varchar(1)                     not null,                                    -- A=Activo, I=Inactivo
    [EstablecimientoId] bigint,                                                                     -- FK pendiente a establecimientos
    [fecha_mod]         datetime                       not null                                     -- Auditoría
)
GO

create table [Inventarios].[ReporteVehiculo]
(
    [ReporteId]     bigint primary key identity (1,1) not null,                             -- ID del reporte
    [VehiculoId]    int foreign key references [Inventarios].[Vehiculo] ([VehiculoId]),     -- Vehículo reportado
    [TallerId]      int foreign key references [Inventarios].[TallerVehiculo] ([TallerId]), -- Taller asignado
    [descripcion]   varchar(100)                      not null,                             -- Detalle del servicio
    [fecha_reporte] datetime                          not null,                             -- Cuándo se reportó
    [fecha_mod]     datetime                          not null                              -- Auditoría
)
GO

-- Control general de inventario
create table [Inventarios].[Inventario]
(
    [ProductoId]   int primary key identity (1,1) not null,                                -- ID del producto
    [MaterialId]   int foreign key references [Inventarios].[Material] ([MaterialId]),     -- FK opcional a material
    [MobiliarioId] int foreign key references [Inventarios].[Mobiliario] ([MobiliarioId]), -- FK opcional a mobiliario  
    [VehiculoId]   int foreign key references Inventarios.Vehiculo (VehiculoId),           -- FK opcional a vehículo
    [cantidad]     int                            not null,                                -- Stock disponible
    [fecha_mod]    datetime                       not null                                 -- Auditoría
)
GO

-- Facturación y compras
create table [Inventarios].[Facturacion]
(
    [FacturaId]         bigint primary key identity (1,1) not null, -- ID de factura
    [EstablecimientoId] bigint,                                     -- FK pendiente a establecimientos
    [fecha_factura]     datetime                          not null, -- Fecha de emisión
    [enlace_documento]  varchar(100)                      not null, -- URL/ruta al PDF
    [fecha_mod]         datetime                          not null  -- Auditoría
)
GO

create table [Inventarios].[Proveedor]
(
    [ProveedorId] int primary key identity (1,1) not null, -- ID del proveedor
    [PersonaId]   bigint,                                  -- FK a datos personales
    [fecha_mod]   datetime                       not null, -- Auditoría
)
GO

create table Inventarios.Compra
(
    CompraId     bigint primary key identity (1,1) not null,                        -- ID de la compra
    ProductoId   int foreign key references Inventarios.Inventario (ProductoId),    -- Producto comprado
    FacturaId    bigint foreign key references Inventarios.Facturacion (FacturaId), -- Factura asociada
    ProveedorId  int foreign key references Inventarios.Proveedor (ProveedorId),    -- Proveedor
    fecha_compra datetime                          not null,                        -- Fecha de compra
    monto        money                             not null,                        -- Costo total
    cantidad     int                               not null,                        -- Unidades compradas
    fecha_mod    datetime                                                           -- Auditoría
)
GO
