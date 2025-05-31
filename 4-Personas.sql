-- Base de datos JAPAMA (Junta de Agua Potable y Alcantarillado del Municipio)
use BD_JAPAMA
go

-- Tabla que almacena las localidades o ubicaciones geográficas
create table [Personas].[Localidad]
(
    [LocalidadId] int primary key identity (1,1) not null, -- Identificador único de la localidad
    [nombre]      varchar(50)                    not null, -- Nombre de la localidad
    [fecha_mod]   datetime                       not null, -- Fecha de última modificación del registro
);

-- Tabla que define los diferentes tipos de domicilio (ej: Residencial, Comercial, etc.)
create table [Personas].[TipoDomicilio]
(
    [TipoDomicilioId] int primary key identity (1,1) not null, -- Identificador único del tipo de domicilio
    [descripcion]     varchar(50)                    not null, -- Descripción del tipo de domicilio
    [fecha_mod]       datetime                       not null  -- Fecha de última modificación del registro
);

-- Tabla que almacena las direcciones físicas
create table [Personas].[Domicilio]
(
    [DomicilioId]      bigint primary key identity (1,1) not null,                                                                 -- Identificador único del domicilio
    [domicilio_linea1] varchar(100)                      not null,                                                                 -- Primera línea de la dirección (calle, número)
    [domicilio_linea2] varchar(100),                                                                                               -- Segunda línea de la dirección (referencias adicionales)
    [cod_postal]       varchar(5)                        not null,                                                                 -- Código postal
    [LocalidadId]      int                               not null foreign key references Personas.Localidad (LocalidadId),         -- Referencia a la localidad
    [TipoDomicilioId]  int                               not null foreign key references Personas.TipoDomicilio (TipoDomicilioId), -- Referencia al tipo de domicilio
    [fecha_mod]        datetime                          not null                                                                  -- Fecha de última modificación del registro
);

-- Tabla que define los tipos de números telefónicos (ej: Móvil, Fijo, etc.)
create table [Personas].[TipoNumero]
(
    [TipoNumeroId] int primary key identity (1,1) not null, -- Identificador único del tipo de número
    [descripcion]  varchar(50)                    not null, -- Descripción del tipo de número
    [fecha_mod]    datetime                       not null  -- Fecha de última modificación del registro
);

-- Tabla que almacena los números telefónicos
create table [Personas].[NumeroTelefonico]
(
    [NumeroTelId]  bigint primary key identity (1,1) not null,                      -- Identificador único del número telefónico
    [numero]       varchar(10) unique                not null,                      -- Número telefónico (debe ser único)
    [TipoNumeroId] int foreign key references Personas.TipoNumero ([TipoNumeroId]), -- Referencia al tipo de número
    [fecha_mod]    datetime                          not null                       -- Fecha de última modificación del registro
);

-- Tabla que almacena las direcciones de correo electrónico
create table [Personas].[Email]
(
    [EmailId]   bigint primary key identity (1,1) not null, -- Identificador único del email
    [correo]    varchar(50) unique                not null, -- Dirección de correo electrónico (debe ser única)
    [fecha_mod] datetime                          not null  -- Fecha de última modificación del registro
);

-- Tabla principal que almacena la información de las personas
create table [Personas].[Persona]
(
    [PersonaId]    bigint primary key identity (1,1) not null,                              -- Identificador único de la persona
    [nombre]       varchar(50)                       not null,                              -- Nombre de la persona
    [apellido1]    varchar(50),                                                             -- Primer apellido
    [apellido2]    varchar(50),                                                             -- Segundo apellido
    [tipo_persona] varchar(1)                        not null,                              -- Tipo de persona (F: Física, M: Moral)
    [EmailId]      bigint foreign key references Personas.Email ([EmailId]),                -- Referencia al email
    [NumeroTelId]  bigint foreign key references Personas.NumeroTelefonico ([NumeroTelId]), -- Referencia al número telefónico
    [DomicilioId]  bigint,                                                                  -- Referencia al domicilio
    [fecha_mod]    datetime                          not null                               -- Fecha de última modificación del registro
);

-- Tabla para tipos de sectores (residencial, industrial, comercial, etc.)
CREATE TABLE [Personas].[TipoSector]
(
    [TipoSectorId] INT PRIMARY KEY IDENTITY (1,1) NOT NULL, -- Identificador único del tipo de sector
    [descripcion]  VARCHAR(50)                    NOT NULL, -- Descripción del tipo de sector
    [fecha_mod]    DATETIME                       NOT NULL  -- Fecha de última modificación del registro
);

-- Tabla para almacenar los sectores de la ciudad con más información
CREATE TABLE [Personas].[Sector]
(
    [SectorId]     INT PRIMARY KEY IDENTITY (1,1) NOT NULL, -- Identificador único del sector
    [nombre]       VARCHAR(50)                    NOT NULL, -- Nombre del sector
    [descripcion]  VARCHAR(200),                           -- Descripción opcional del sector
    [TipoSectorId] INT FOREIGN KEY REFERENCES Personas.TipoSector (TipoSectorId), -- Tipo de sector
    [LocalidadId]  INT FOREIGN KEY REFERENCES Personas.Localidad (LocalidadId),   -- Localidad a la que pertenece
    [area_km2]     DECIMAL(10,2),                          -- Área en kilómetros cuadrados (opcional)
    [poblacion]    INT,                                    -- Población aproximada (opcional)
    [fecha_mod]    DATETIME                       NOT NULL  -- Fecha de última modificación del registro
);

-- Modificación de la tabla Domicilio para incluir el sector
ALTER TABLE [Personas].[Domicilio]
    ADD [SectorId] INT FOREIGN KEY REFERENCES Personas.Sector (SectorId);
