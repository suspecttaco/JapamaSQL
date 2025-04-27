use BD_JAPAMA
go

create table [Inventarios].[TipoMaterial] (
    [TipoMaterialId] int primary key identity (1,1) not null,
    [descripcion] varchar(50),
    [fecha_mod] datetime not null
)

create table [Inventarios].[Material] (
    [MaterialId] int primary key identity (1,1) not null,
    [nombre] varchar(50) not null,
    [descripcion] varchar(50),
    [actividad] varchar(1) not null,
    [TipoMaterialId] int foreign key references [Inventarios].[TipoMaterial] ([TipoMaterialId]),
    [fecha_mod] datetime not null
)

create table [Inventarios].[TipoMobiliario] (
    [TipoMobiliarioId] int primary key identity (1,1) not null,
    [descripcion] varchar(50) not null,
    fecha_mod datetime not null
)

create table [Inventarios].[Mobiliario] (
    [MobiliarioId] int primary key identity (1,1) not null,
    [nombre] varchar(50) not null,
    [descripcion] varchar(50) not null,
    [actividad] varchar(1) not null,
    [TipoMobiliarioId] int foreign key references [Inventarios].[TipoMobiliario] ([TipoMobiliarioId]),
    [fecha_mod] datetime not null,
)

create table [Inventarios].[TallerVehiculo] (
    [TallerId] int primary key identity not null,
    [PersonaId] bigint,
    [fecha_mod] datetime not null
)

create table [Inventarios].[TipoVehiculo] (
    [TipoVehiculoId] int primary key identity (1,1) not null,
    [nombre] varchar(50) not null,
    [fecha_mod] datetime not null
)

create table [Inventarios].[Vehiculo] (
    [VehiculoId] int primary key identity (1,1) not null,
    [TipoVehiculoId] int foreign key references [Inventarios].[TipoVehiculo] ([TipoVehiculoId]),
    [matricula] varchar(20) not null,
    [actividad] varchar(1) not null,
    [EstablecimientoId] bigint, --Pendiente relacion
    [fecha_mod] datetime not null
)

create table [Inventarios].[ReporteVehiculo] (
    [ReporteId] bigint primary key identity (1,1) not null,
    [VehiculoId] int foreign key references [Inventarios].[Vehiculo] ([VehiculoId]),
    [TallerId] int foreign key references [Inventarios].[TallerVehiculo] ([TallerId]),
    [descripcion] varchar(100) not null,
    [fecha_reporte] datetime not null,
    [fecha_mod] datetime not null
)

create table [Inventarios].[Inventario] (
    [ProductoId] int primary key identity (1,1) not null,
    [MaterialId] int foreign key references [Inventarios].[Material] ([MaterialId]),
    [MobiliarioId] int foreign key references [Inventarios].[Mobiliario] ([MobiliarioId]),
    [VehiculoId] int foreign key references Inventarios.Vehiculo (VehiculoId),
    [cantidad] int not null,
    [fecha_mod] datetime not null
)

create table [Inventarios].[Facturacion] (
    [FacturaId] bigint primary key identity (1,1) not null,
    [EstablecimientoId] bigint, --Pendiente relacion
    [fecha_factura] datetime not null,
    [enlace_documento] varchar(100) not null,
    [fecha_mod] datetime not null
)

create table [Inventarios].[Proveedor] (
    [ProveedorId] int primary key identity (1,1) not null,
    [PersonaId] bigint,
    [fecha_mod] datetime not null,
)

create table Inventarios.Compra (
    CompraId     bigint primary key identity (1,1) not null,
    ProductoId   int foreign key references Inventarios.Inventario (ProductoId),
    FacturaId    bigint foreign key references Inventarios.Facturacion (FacturaId),
    ProveedorId  int foreign key references Inventarios.Proveedor (ProveedorId),
    fecha_compra datetime not null,
    monto money not null,
    cantidad int not null,
    fecha_mod datetime
)