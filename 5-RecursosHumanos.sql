use BD_JAPAMA
/*
Base de datos JAPAMA - Módulo de Recursos Humanos
Este script crea las tablas necesarias para gestionar empleados, nóminas, contratos y asistencias
*/

use BD_JAPAMA
go

-- Tabla para almacenar los diferentes puestos sindicales
CREATE TABLE [RecursosHumanos].[PuestoSindicato]
(
    [PuestoSindicatoId] smallint   NOT NULL primary key identity (1,1), -- Identificador único del puesto sindical
    [nombre]            char(50)   NOT NULL,                            -- Nombre o descripción del puesto
    [estatus]           varchar(1) NOT NULL,                            -- Estado del puesto (A-Activo, I-Inactivo)
    [fecha_mod]         datetime   NOT NULL                             -- Fecha de última modificación
)

-- Tabla para gestionar los turnos de trabajo
CREATE TABLE [RecursosHumanos].[Turno]
(
    [TurnoId]      tinyint  NOT NULL primary key identity (1,1), -- Identificador único del turno
    [tipo]         char(3)  NOT NULL,                            -- MAT->Matutino, VES->Vespertino, NOC->Nocturno
    [duracion]     tinyint  NOT NULL,                            -- Duración del turno en horas
    [hora_entrada] time(0)  NOT NULL,                            -- Hora de inicio del turno
    [hora_salida]  time(0)  NOT NULL,                            -- Hora de finalización del turno
    [fecha_mod]    datetime NOT NULL                             -- Fecha de última modificación
)

-- Tabla para registrar los bancos donde se realizan los pagos de nómina
create table [RecursosHumanos].[Banco]
(
    [BancoId]   INT         NOT NULL PRIMARY KEY IDENTITY (1,1), -- Identificador único del banco
    [nombre]    VARCHAR(50) NOT NULL,                            -- Nombre del banco
    [fecha_mod] DATETIME    NOT NULL                             -- Fecha de última modificación
)

-- Tabla para gestionar la información de nómina de los empleados
CREATE TABLE [RecursosHumanos].[Nomina]
(
    [NominaId]  int         NOT NULL primary key identity (1,1),                                 -- Identificador único de la nómina
    [clabe]     varchar(18) NOT NULL,                                                            -- CLABE interbancaria del empleado
    [BancoId]   int         NOT NULL foreign key references [RecursosHumanos].[Banco] (BancoId), -- Referencia al banco
    [fecha_mod] datetime    NOT NULL                                                             -- Fecha de última modificación
)

-- Tabla para almacenar los contratos de los empleados
create table [RecursosHumanos].[ContratoEmpleado]
(
    [ContratoId]        int primary key not null identity (1,1), -- Identificador único del contrato
    [tipo_contrato]     varchar(3)      not null,                -- SIN->Sindicalizado, CON->Confianza, EVE->Eventuales
    [fecha_contrato]    datetime        not null,                -- Fecha de inicio del contrato
    [fecha_vencimiento] datetime        not null,                -- Fecha de término del contrato
    [enlace_documento]  varchar(50)     not null,                -- Ruta al documento del contrato
    [fecha_mod]         datetime        not null                 -- Fecha de última modificación
)

-- Tabla para definir los puestos y sus compensaciones
CREATE TABLE [RecursosHumanos].[Puesto]
(
    [PuestoId]     smallint    NOT NULL primary key identity (1,1), -- Identificador único del puesto
    [descripcion]  varchar(50) NOT NULL,                            -- Descripción o nombre del puesto
    [salario_base] money       NOT NULL,                            -- Salario base del puesto
    [bonos]        money       NOT NULL,                            -- Bonos adicionales del puesto
    [fecha_mod]    datetime    NOT NULL                             -- Fecha de última modificación
)

-- Tabla principal de empleados
CREATE TABLE [RecursosHumanos].[Empleado]
(
    [EmpleadoId]         int         NOT NULL primary key identity (1,1),                                           -- Identificador único del empleado
    [nss]                varchar(11) NOT NULL unique,                                                               -- Número de Seguro Social
    [rfc]                varchar(13) NOT NULL unique,                                                               -- RFC del empleado
    [ContratoId]         int         NOT NULL foreign key references RecursosHumanos.ContratoEmpleado (ContratoId), -- Referencia al contrato
    [PuestoId]           smallint    NOT NULL foreign key references RecursosHumanos.Puesto (PuestoId),             -- Referencia al puesto
    [edo_civil]          varchar(3)  NOT NULL,                                                                      -- Estado civil
    [fecha_nacimiento]   date        NOT NULL,                                                                      -- Fecha de nacimiento
    [fecha_contratacion] datetime    NOT NULL,                                                                      -- Fecha de contratación
    [actividad]          char(1)     NOT NULL,                                                                      -- Estado de actividad (A-Activo, I-Inactivo)
    [fecha_mod]          datetime    NOT NULL,                                                                      -- Fecha de última modificación
    [PersonaId]          bigint      NOT NULL,                                                                      -- Referencia a la tabla de Personas
    [TurnoId]            tinyint     NOT NULL foreign key references RecursosHumanos.Turno (TurnoId),               -- Referencia al turno
    [NominaId]           int         NOT NULL foreign key references RecursosHumanos.Nomina (NominaId),             -- Referencia a la nómina
    [EstablecimientoId]  bigint      NOT NULL                                                                       -- Referencia al establecimiento
)

-- Tabla para gestionar la información sindical
CREATE TABLE [RecursosHumanos].[Sindicato]
(
    [SindicatoId]       int      NOT NULL primary key identity (1,1),                                                 -- Identificador único del registro sindical
    [EmpleadoId]        int      NOT NULL foreign key references RecursosHumanos.Empleado (EmpleadoId),               -- Referencia al empleado
    [fecha_afiliacion]  datetime NOT NULL,                                                                            -- Fecha de afiliación al sindicato
    [PuestoSindicatoId] smallint NOT NULL foreign key references RecursosHumanos.PuestoSindicato (PuestoSindicatoId), -- Puesto sindical
    [fecha_mod]         datetime NOT NULL                                                                             -- Fecha de última modificación
)

-- Tabla para registrar la asistencia de los empleados
CREATE TABLE [RecursosHumanos].[HistorialAsistencia]
(
    [AsistenciaId]  int      NOT NULL primary key identity (1,1),                                   -- Identificador único del registro de asistencia
    [EmpleadoId]    int      NOT NULL foreign key references RecursosHumanos.Empleado (EmpleadoId), -- Referencia al empleado
    [fecha_entrada] datetime NOT NULL,                                                              -- Fecha y hora de entrada
    [fecha_salida]  datetime NOT NULL,                                                              -- Fecha y hora de salida
    [fecha_mod]     datetime NOT NULL                                                               -- Fecha de última modificación
)
go

CREATE TABLE [RecursosHumanos].[PuestoSindicato]
(
    [PuestoSindicatoId] smallint NOT NULL primary key identity (1,1),
    [nombre] char(50) NOT NULL,
    [estatus] varchar(1) NOT NULL,
    [fecha_mod] datetime NOT NULL
)

CREATE TABLE [RecursosHumanos].[Turno]
(
    [TurnoId] tinyint NOT NULL primary key identity (1,1),
    [tipo] char(3) NOT NULL, -- MAT ->Matutino , VES ->Vespertino , NOC ->Nocturno 
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






