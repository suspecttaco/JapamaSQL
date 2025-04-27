use BD_JAPAMA
go

CREATE TABLE [RecursosHumanos].[PuestoSindicato]
(
    [PuestoSindicatoId] smallint NOT NULL primary key identity (1,1),
    [nombre] varchar(50) NOT NULL,
    [estatus] varchar(1) NOT NULL,
    [fecha_mod] datetime NOT NULL
)

CREATE TABLE [RecursosHumanos].[Turno]
(
    [TurnoId] tinyint NOT NULL primary key identity (1,1),
    [tipo] varchar(50) NOT NULL,
    [duracion] tinyint NOT NULL,
    [hora_entrada] time(0) NOT NULL,
    [hora_salida] time(0) NOT NULL,
    [fecha_mod] datetime NOT NULL
)

create table [RecursosHumanos].[Banco]
(
    [BancoId] INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    [nombre] VARCHAR(50) NOT NULL,
    [fecha_mod] DATETIME NOT NULL
)

CREATE TABLE [RecursosHumanos].[Nomina]
(
    [NominaId] int NOT NULL primary key identity (1,1),
    [clabe] varchar(18) NOT NULL,
    [BancoId] int NOT NULL foreign key references [RecursosHumanos].[Banco] (BancoId),
    [fecha_mod] datetime NOT NULL
)

create table [RecursosHumanos].[ContratoEmpleado]
(
    [ContratoId] int primary key not null identity (1,1),
    [tipo_contrato] varchar(3) not null, --SIN ->Sindicalizado CON->Confianza Eve->Eventuales
    [fecha_contrato] datetime not null,
    [fecha_vencimiento] datetime not null,
    [enlace_documento] varchar(50) not null,
    [fecha_mod] datetime not null
)

CREATE TABLE [RecursosHumanos].[Puesto]
(
    [PuestoId] smallint NOT NULL primary key identity (1,1),
    [descripcion] varchar(50) NOT NULL,
    [salario_base] money NOT NULL,
    [bonos] money NOT NULL,
    [fecha_mod] datetime NOT NULL
)

CREATE TABLE [RecursosHumanos].[Empleado]
(
    [EmpleadoId] int NOT NULL primary key identity (1,1),
    [nss] varchar(11) NOT NULL unique,
    [rfc] varchar(13) NOT NULL unique,
    [ContratoId] int NOT NULL foreign key references RecursosHumanos.ContratoEmpleado (ContratoId),
    [PuestoId] smallint NOT NULL foreign key references RecursosHumanos.Puesto (PuestoId),
    [edo_civil] varchar(3) NOT NULL,
    [fecha_nacimiento] date NOT NULL,
    [fecha_contratacion] datetime NOT NULL,
    [actividad] char(1) NOT NULL,
    [fecha_mod] datetime NOT NULL,
    [PersonaId] bigint NOT NULL, 
    [TurnoId] tinyint NOT NULL foreign key references RecursosHumanos.Turno (TurnoId),
    [NominaId] int NOT NULL foreign key references RecursosHumanos.Nomina (NominaId),
    [EstablecimientoId] bigint NOT NULL
)

CREATE TABLE [RecursosHumanos].[Sindicato]
(
    [SindicatoId] int NOT NULL primary key identity (1,1),
    [EmpleadoId] int NOT NULL foreign key references RecursosHumanos.Empleado (EmpleadoId),
    [fecha_afiliacion] datetime NOT NULL,
    [PuestoSindicatoId] smallint NOT NULL foreign key references RecursosHumanos.PuestoSindicato (PuestoSindicatoId),
    [fecha_mod] datetime NOT NULL
)

CREATE TABLE [RecursosHumanos].[HistorialAsistencia]
(
    [AsistenciaId] int NOT NULL primary key identity (1,1),
    [EmpleadoId] int NOT NULL foreign key references RecursosHumanos.Empleado (EmpleadoId),
    [fecha_entrada] datetime NOT NULL,
    [fecha_salida] datetime NOT NULL,
    [fecha_mod] datetime NOT NULL
)






