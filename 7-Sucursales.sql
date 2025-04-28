use BD_JAPAMA
go

CREATE TABLE Sucursales.Departamento (
    DepartamentoId int PRIMARY KEY NOT NULL IDENTITY (1,1),
    descripcion VARCHAR(50) NOT NULL,
    segmento_red VARCHAR(16) NOT NULL,
    fecha_mod DATE NOT NULL,
);

CREATE TABLE Sucursales.Red (
    RedId INT PRIMARY KEY NOT NULL IDENTITY (1,1),
    compania_red VARCHAR(50) NOT NULL,
    segmento_red VARCHAR(16) NOT NULL,
    fecha_mod DATE NOT NULL,
);

CREATE TABLE Sucursales.TipoEstablecimiento (
    TipoEstablecimientId BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1),
    nombre VARCHAR(50) NOT NULL,
    fecha_mod DATE NOT NULL,
);

CREATE TABLE Sucursales.Establecimiento (
    EstablecimientoId BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1),

    nombre VARCHAR(50) NOT NULL,
    TipoEstablecimientoId BIGINT NOT NULL FOREIGN KEY REFERENCES Sucursales.TipoEstablecimiento (TipoEstablecimientId),
    DomicilioId BIGINT NOT NULL,
    RedId INT NOT NULL FOREIGN KEY REFERENCES Sucursales.Red (RedId),
    DepartamentoId INT NOT NULL FOREIGN KEY REFERENCES Sucursales.Departamento (DepartamentoId),
    fecha_mod DATE NOT NULL,
);

CREATE TABLE Sucursales.CajeroAutomatico (
    CajeroId BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1),

    EstablecimientoId BIGINT NOT NULL FOREIGN KEY REFERENCES Sucursales.Establecimiento (EstablecimientoId),
    actividad CHAR(1) NOT NULL,
    CONSTRAINT actividad CHECK(actividad IN('A','I','S')), --Activo ->A Inactivo ->I Suspendido ->S
    fecha_inicio DATE NOT NULL,
    fecha_cierre DATE NOT NULL,
    horario VARCHAR(20) NOT NULL,
    BancoId INT NOT NULL,
    fecha_mod DATE NOT NULL,
);