use BD_JAPAMA
go

create table [Inventarios].[TipoMaterial] (
    [TipoMaterialId] int primary key identity (1,1) not null,
    [descripcion] varchar(50),
    [fecha_mod] datetime not null
)

create table [Inventarios].[Material] (
    [MaterialId] int primary key identity (1,1) not null,
    [nombre] varchar(50) not null ,
)