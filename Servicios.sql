CREATE TABLE Servicios.ReporteProblema (
    ReporteId BIGINT PRIMARY KEY NOT NULL,
    CONSTRAINT ReporteId UNIQUE(ReporteId),

    ClienteId BIGINT NOT NULL,
    descripcion VARCHAR(50) NOT NULL,
    fecha_reporte DATE NOT NULL,
    EmpleadoId BIGINT NOT NULL,
    seguimiento VARCHAR(50) NOT NULL,
    DepartamentoId BIGINT NOT NULL,
    fecha_mod DATE NOT NULL,
);
CREATE TABLE Servicios.SuspensionServicio (
    SuspensionId BIGINT PRIMARY KEY NOT NULL,
    CONSTRAINT SuspensionId UNIQUE(SuspensionId),

    actividad CHAR(1) NULL,
    CONSTRAINT actividad CHECK(actividad IN('T','P')), --Temporar -> T Permanente -> P 
    descricpion VARCHAR(50) NOT NULL,
    ClienteId BIGINT NOT NULL,
    fecha_suspension DATE NOT NULL,
    enlace_documento VARCHAR(50) NOT NULL,
    fecha_mod DATE NOT NULL
);
CREATE TABLE Servicios.TipoServicio (
    ServicioId BIGINT PRIMARY KEY NOT NULL,
    CONSTRAINT ServicioId UNIQUE(ServicioId),

    SuspensionId BIGINT NULL,
    ReporteProblema BIGINT NULL,
    ProgramaDescuento BIGINT NULL,
    CartaNoAdeudos BIGINT NULL,
    fecha_mod DATE NOT NULL
);
CREATE TABLE Servicios.CartaNoAdeudos (
    CartaId BIGINT PRIMARY KEY NOT NULL,
    CONSTRAINT CartaId UNIQUE(CartaId),

    ClienteId BIGINT NOT NULL,
    enlace_documento VARCHAR(50) NOT NULL,
    fecha_mod DATE NOT NULL
);

CREATE TABLE Servicios.ProgramaDescuento (
    ProgramaId BIGINT PRIMARY KEY NOT NULL,
    CONSTRAINT ProgramaId UNIQUE(ProgramaId),

    descricpion VARCHAR(50) NOT NULL,
    porcentaje_aplicado FLOAT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL,
    fecha_mod DATE NOT NULL
);