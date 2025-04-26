use BD_JAPAMA
go

CREATE TABLE Clientes.Cliente (
    ClienteId BIGINT PRIMARY KEY NOT NULL,
    CONSTRAINT ClienteId UNIQUE(ClienteId),

    PersonaId BIGINT NOT NULL,
    --CONSTRAINT FK_PersonaId FOREIGN KEy (PersonaId) REFERENCES Personas.Persona(PersonaId),

    fecha_corte DATE NOT NULL,
    
    ContratoId BIGINT NOT NULL,
    --CONSTRAINT FK_ContratoId FOREIGN KEY (ContratoId) REFERENCES Clientes.Contrato(ContratoId),

    fecha_mod DATE NOT NULL
);
CREATE TABLE Clientes.Contrato (
    ContratoId BIGINT PRIMARY KEY NOT NULL,
    CONSTRAINT ContratoId UNIQUE(ContratoId),

    fecha_contrato DATE NOT NULL,
    
    enlace_documento varchar(50) NOT NULL,

    TipoTaridaId BIGINT NOT NULL,
    --CONSTRAINT FK_TipoTarifaId FOREIGN kEY (TipoTaridaId) REFERENCES Clientes.TipoTarifa (TipoTaridaId),

    medidor VARCHAR(12) NOT NULL,

    fecha_mod DATE NOT NULL
);
CREATE TABLE Clientes.TipoTarifa (
    TipoTarifaId BIGINT PRIMARY KEY NOT NULL,
    CONSTRAINT TipoTarifaId UNIQUE(TipoTarifaId),

    nombre VARCHAR(50) NOT NULL,

    TarifaId BIGINT NOT NULL,
    --CONSTRAINT FK_TarifaId FOREIGN KEY (TarifaId) REFERENCES Clientes.Tarifa(TarifaId),

    fecha_mod DATE NOT NULL

);
CREATE TABLE Clientes.Tarifa(
    TarifaId BIGINT PRIMARY KEY NOT NULL,
    CONSTRAINT TarifaId UNIQUE(TarifaId),

    precio_base MONEY NOT NULL,
    base_agua MONEY NOT NULL,
    base_drenaje MONEY NOT NULL,
    base_saneamiento MONEY NOT NULL,
    max_m3 INT NOT NULL,
    fecha_mod DATE NOT NULL
);
CREATE TABLE Clientes.Adeudos (
    AdeudiId BIGINT PRIMARY KEY NOT NULL,
    CONSTRAINT AdeudoId UNIQUE(AdeudiId),

    EstablecimientoId BIGINT NOT NULL,
    ClienteId BIGINT NOT NULL,
    ConsumoId BIGINT NOT NULL,
    CargoId BIGINT NOT NULL,
    adeudo_anterior MONEY NOT NULL,
    adeudo_actual MONEY NOT NULL,
    IVA MONEY NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    fecha_mod DATE NOT NULL
);
CREATE TABLE Clientes.Consumo (
    ConsumoId BIGINT PRIMARY KEY NOT NULL,
    CONSTRAINT ConsumoId UNIQUE(ConsumoId),

    lectura_anterior MONEY NOT NULL,
    lectura_actual MONEY NOT NULL,
    consumo_m3 INT NOT NULL,
    facturado_m3 MONEY NOT NULL,
    periodo_lectura DATE NOT NULL,
    fecha_mod DATE NOT NULL
);
CREATE TABLE Clientes.CargoServicio (
    CargoId BIGINT PRIMARY KEY NOT NULL,
    descripcion VARCHAR(50) NOT NULL,
    monto MONEY NOT NULL,
    fecha_mod DATE NOT NULL
);