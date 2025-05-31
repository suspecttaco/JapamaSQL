use BD_JAPAMA
go

-- Schema para manejar la información de sucursales y cajeros automáticos
-- Creado: 2025-05-30

-- Tabla que almacena los departamentos de la organización
CREATE TABLE Sucursales.Departamento
(
    DepartamentoId int PRIMARY KEY NOT NULL IDENTITY (1,1), -- Identificador único del departamento
    descripcion    VARCHAR(50)     NOT NULL,                -- Nombre o descripción del departamento
    segmento_red   VARCHAR(16)     NOT NULL,                -- Segmento de red asignado al departamento
    fecha_mod      DATE            NOT NULL,                -- Fecha de última modificación
);

-- Tabla que almacena información de las redes de comunicación
CREATE TABLE Sucursales.Red
(
    RedId        INT PRIMARY KEY NOT NULL IDENTITY (1,1), -- Identificador único de la red
    compania_red VARCHAR(50)     NOT NULL,                -- Nombre de la compañía proveedora de la red
    segmento_red VARCHAR(16)     NOT NULL,                -- Identificador del segmento de red
    fecha_mod    DATE            NOT NULL,                -- Fecha de última modificación
);

-- Tabla que define los diferentes tipos de establecimientos
CREATE TABLE Sucursales.TipoEstablecimiento
(
    TipoEstablecimientId BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1), -- Identificador único del tipo
    nombre               VARCHAR(50)        NOT NULL,                -- Nombre del tipo de establecimiento
    fecha_mod            DATE               NOT NULL,                -- Fecha de última modificación
);

-- Tabla que almacena la información de los establecimientos
CREATE TABLE Sucursales.Establecimiento
(
    EstablecimientoId     BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1),                                                               -- Identificador único del establecimiento
    nombre                VARCHAR(50)        NOT NULL,                                                                              -- Nombre del establecimiento
    TipoEstablecimientoId BIGINT             NOT NULL FOREIGN KEY REFERENCES Sucursales.TipoEstablecimiento (TipoEstablecimientId), -- Tipo de establecimiento
    DomicilioId           BIGINT             NOT NULL,                                                                              -- Referencia al domicilio del establecimiento
    RedId                 INT                NOT NULL FOREIGN KEY REFERENCES Sucursales.Red (RedId),                                -- Red asociada al establecimiento
    DepartamentoId        INT                NOT NULL FOREIGN KEY REFERENCES Sucursales.Departamento (DepartamentoId),              -- Departamento responsable
    fecha_mod             DATE               NOT NULL,                                                                              -- Fecha de última modificación
);

-- Tabla que gestiona la información de los cajeros automáticos
CREATE TABLE Sucursales.CajeroAutomatico
(
    CajeroId          BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1),                                                        -- Identificador único del cajero
    EstablecimientoId BIGINT             NOT NULL FOREIGN KEY REFERENCES Sucursales.Establecimiento (EstablecimientoId), -- Establecimiento donde está ubicado
    actividad         CHAR(1)            NOT NULL,                                                                       -- Estado del cajero (A=Activo, I=Inactivo, S=Suspendido)
    CONSTRAINT actividad CHECK (actividad IN ('A', 'I', 'S')),                                                           -- Restricción para los valores permitidos de actividad
    fecha_inicio      DATE               NOT NULL,                                                                       -- Fecha de inicio de operaciones
    fecha_cierre      DATE               NOT NULL,                                                                       -- Fecha de cierre o último día de operación
    horario           VARCHAR(20)        NOT NULL,                                                                       -- Horario de funcionamiento
    BancoId           INT                NOT NULL,                                                                       -- Identificador del banco propietario
    fecha_mod         DATE               NOT NULL,                                                                       -- Fecha de última modificación
);