/*
Script para la creación de tablas relacionadas con Servicios en la base de datos BD_JAPAMA
Este script define las estructuras para manejar reportes de problemas, suspensiones de servicio,
tickets de servicio, cartas de no adeudos y programas de descuento.
*/

use BD_JAPAMA
go

/* 
Tabla que almacena los reportes de problemas
- Registra problemas reportados por empleados
- Incluye seguimiento y observaciones
*/
CREATE TABLE Servicios.ReporteProblema
(
    ReporteId      BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1), -- Identificador único del reporte
    descripcion    VARCHAR(50)        NOT NULL,                -- Descripción del problema
    fecha_reporte  DATE               NOT NULL,                -- Fecha en que se realizó el reporte
    EmpleadoId     BIGINT             NOT NULL,                -- ID del empleado que registró el reporte
    seguimiento    VARCHAR(50)        NOT NULL,                -- Estado o seguimiento del reporte
    DepartamentoId BIGINT             NOT NULL,                -- Departamento asignado al reporte
    observaciones  VARCHAR(50)        NULL,                    -- Observaciones adicionales (opcional)
    fecha_mod      DATE               NOT NULL,                -- Fecha de última modificación
);

/*
Tabla para gestionar suspensiones de servicio
- Maneja suspensiones temporales y permanentes
*/
CREATE TABLE Servicios.SuspensionServicio
(
    SuspensionId     BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1), -- ID único de suspensión
    actividad        CHAR(1)            NULL,                    -- Tipo de suspensión
    CONSTRAINT actividad CHECK (actividad IN ('T', 'P')),        -- T=Temporal, P=Permanente
    descricpion      VARCHAR(50)        NOT NULL,                -- Motivo de la suspensión
    fecha_suspension DATE               NOT NULL,                -- Fecha de inicio de la suspensión
    enlace_documento VARCHAR(50)        NOT NULL,                -- Referencia al documento de suspensión
    fecha_mod        DATE               NOT NULL                 -- Fecha de última modificación
);

/*
Tabla principal de tickets de servicio
- Centraliza diferentes tipos de servicios
- Relaciona clientes con diversos servicios
*/
CREATE TABLE Servicios.TicketServicio
(
    ServicioId        BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1), -- ID único del ticket
    ClienteId         BIGINT             NOT NULL,                -- Cliente asociado al servicio
    SuspensionId      BIGINT             NULL,                    -- Referencia a suspensión (si existe)
    ReporteProblema   BIGINT             NULL,                    -- Referencia a reporte (si existe)
    ProgramaDescuento BIGINT             NULL,                    -- Programa de descuento aplicado
    CartaNoAdeudos    BIGINT             NULL,                    -- Referencia a carta de no adeudos
    fecha_mod         DATE               NOT NULL                 -- Fecha de última modificación
);

/*
Tabla para gestionar cartas de no adeudos
- Documenta certificados de no adeudo
*/
CREATE TABLE Servicios.CartaNoAdeudos
(
    CartaId          BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1), -- ID único de la carta
    enlace_documento VARCHAR(50)        NOT NULL,                -- Ubicación del documento
    fecha_mod        DATE               NOT NULL                 -- Fecha de última modificación
);

/*
Tabla de programas de descuento
- Gestiona diferentes programas de descuento
- Incluye periodos de validez y porcentajes
*/
CREATE TABLE Servicios.ProgramaDescuento
(
    ProgramaId          BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1), -- ID único del programa
    descricpion         VARCHAR(50)        NOT NULL,                -- Descripción del programa
    porcentaje_aplicado FLOAT              NOT NULL,                -- Porcentaje de descuento
    fecha_inicio        DATE               NOT NULL,                -- Inicio del programa
    fecha_final         DATE               NOT NULL,                -- Fin del programa
    fecha_mod           DATE               NOT NULL                 -- Fecha de última modificación
);

-- Definición de relaciones entre tablas
ALTER TABLE Servicios.TicketServicio
    ADD CONSTRAINT
        FK_ServicioId FOREIGN KEY (SuspensionId) REFERENCES Servicios.SuspensionServicio (SuspensionId);
ALTER TABLE Servicios.TicketServicio
    ADD CONSTRAINT
        FK_ReporteProblema FOREIGN KEY (ReporteProblema) REFERENCES Servicios.ReporteProblema (ReporteId);
ALTER TABLE Servicios.TicketServicio
    ADD CONSTRAINT
        FK_ProgramaDescuento FOREIGN KEY (ProgramaDescuento) REFERENCES Servicios.ProgramaDescuento (ProgramaId);
ALTER TABLE Servicios.TicketServicio
    ADD CONSTRAINT
        FK_CartaNoAdeudos FOREIGN KEY (CartaNoAdeudos) REFERENCES Servicios.CartaNoAdeudos (CartaId);