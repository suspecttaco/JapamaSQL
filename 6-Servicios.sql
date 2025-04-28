use BD_JAPAMA
go

CREATE TABLE Servicios.ReporteProblema (
    ReporteId BIGINT PRIMARY KEY NOT NULL  IDENTITY (1,1),

    descripcion VARCHAR(50) NOT NULL,
    fecha_reporte DATE NOT NULL,
    EmpleadoId BIGINT NOT NULL,
    seguimiento VARCHAR(50) NOT NULL,
    DepartamentoId BIGINT NOT NULL,
    observaciones VARCHAR(50) NULL,
    fecha_mod DATE NOT NULL,
);
CREATE TABLE Servicios.SuspensionServicio (
    SuspensionId BIGINT PRIMARY KEY NOT NULL  IDENTITY (1,1),

    actividad CHAR(1) NULL,
    CONSTRAINT actividad CHECK(actividad IN('T','P')), --Temporal -> T Permanente -> P
    descricpion VARCHAR(50) NOT NULL,
    fecha_suspension DATE NOT NULL,
    enlace_documento VARCHAR(50) NOT NULL,
    fecha_mod DATE NOT NULL
);
CREATE TABLE Servicios.TicketServicio (
    ServicioId BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1),

    ClienteId BIGINT NOT NULL,
    SuspensionId BIGINT NULL,
    ReporteProblema BIGINT NULL,
    ProgramaDescuento BIGINT NULL,
    CartaNoAdeudos BIGINT NULL,
    fecha_mod DATE NOT NULL
);
CREATE TABLE Servicios.CartaNoAdeudos (
    CartaId BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1),

    enlace_documento VARCHAR(50) NOT NULL,
    fecha_mod DATE NOT NULL
);

CREATE TABLE Servicios.ProgramaDescuento (
    ProgramaId BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1),

    descricpion VARCHAR(50) NOT NULL,
    porcentaje_aplicado FLOAT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL,
    fecha_mod DATE NOT NULL
);

ALTER TABLE Servicios.TicketServicio ADD CONSTRAINT
FK_ServicioId FOREIGN KEY (SuspensionId) REFERENCES Servicios.SuspensionServicio(SuspensionId);
ALTER TABLE Servicios.TicketServicio ADD CONSTRAINT
FK_ReporteProblema FOREIGN KEY (ReporteProblema) REFERENCES Servicios.ReporteProblema(ReporteId);
ALTER TABLE Servicios.TicketServicio ADD CONSTRAINT
FK_ProgramaDescuento FOREIGN KEY (ProgramaDescuento) REFERENCES Servicios.ProgramaDescuento(ProgramaId);
ALTER TABLE Servicios.TicketServicio ADD CONSTRAINT
FK_CartaNoAdeudos FOREIGN KEY (CartaNoAdeudos) REFERENCES Servicios.CartaNoAdeudos(CartaId);