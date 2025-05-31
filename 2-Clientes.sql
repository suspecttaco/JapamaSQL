use BD_JAPAMA
/*
Base de datos JAPAMA (Junta de Agua Potable y Alcantarillado del Municipio)
Este script crea las tablas necesarias para gestionar clientes, contratos, tarifas y consumos
*/

-- Tabla que almacena la información principal de los clientes
CREATE TABLE Clientes.Cliente
(
    ClienteId   BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1), -- Identificador único del cliente
    PersonaId   BIGINT             NOT NULL,                -- Referencia a la información personal del cliente
    fecha_corte DATE               NOT NULL,                -- Fecha de corte del servicio
    ContratoId  BIGINT             NOT NULL,                -- Referencia al contrato del cliente
    actividad   CHAR(1)            NULL,                    -- Estado del cliente: A=Activo, T=Temporal, P=Permanente
    CONSTRAINT actividad CHECK (actividad IN ('A', 'T', 'P')),
    fecha_mod   DATE               NOT NULL                 -- Fecha de última modificación
);

-- Tabla para gestionar los contratos de servicios
CREATE TABLE Clientes.Contrato
(
    ContratoId       BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1), -- Identificador único del contrato
    fecha_contrato   DATE               NOT NULL,                -- Fecha de firma del contrato
    enlace_documento varchar(50)        NOT NULL,                -- Ruta al documento digitalizado del contrato
    TipoTarifaId     BIGINT             NOT NULL,                -- Referencia al tipo de tarifa aplicada
    medidor          VARCHAR(12)        NOT NULL,                -- Número de medidor asignado
    fecha_mod        DATE               NOT NULL                 -- Fecha de última modificación
);

-- Tabla que define los tipos de tarifas disponibles
CREATE TABLE Clientes.TipoTarifa
(
    TipoTarifaId BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1), -- Identificador único del tipo de tarifa
    nombre       VARCHAR(50)        NOT NULL,                -- Nombre descriptivo del tipo de tarifa
    TarifaId     BIGINT             NOT NULL,                -- Referencia a la tarifa base
    fecha_mod    DATE               NOT NULL                 -- Fecha de última modificación
);

-- Tabla que establece los montos base para cada concepto de cobro
CREATE TABLE Clientes.Tarifa
(
    TarifaId         BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1), -- Identificador único de la tarifa
    precio_base      MONEY              NOT NULL,                -- Precio base del servicio
    base_agua        MONEY              NOT NULL,                -- Costo base por consumo de agua
    base_drenaje     MONEY              NOT NULL,                -- Costo base por servicio de drenaje
    base_saneamiento MONEY              NOT NULL,                -- Costo base por saneamiento
    max_m3           INT                NOT NULL,                -- Consumo máximo en metros cúbicos
    fecha_mod        DATE               NOT NULL                 -- Fecha de última modificación
);

-- Tabla para registro de adeudos de los clientes
CREATE TABLE Clientes.Adeudos
(
    AdeudoId          BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1), -- Identificador único del adeudo
    EstablecimientoId BIGINT             NOT NULL,                -- Referencia al establecimiento
    ClienteId         BIGINT             NOT NULL,                -- Cliente al que corresponde el adeudo
    ConsumoId         BIGINT             NOT NULL,                -- Referencia al consumo relacionado
    CargoId           BIGINT             NOT NULL,                -- Tipo de cargo aplicado
    adeudo_anterior   MONEY              NOT NULL,                -- Monto del adeudo anterior
    adeudo_actual     MONEY              NOT NULL,                -- Monto del adeudo actual
    IVA               MONEY              NOT NULL,                -- Impuesto al Valor Agregado
    fecha_vencimiento DATE               NOT NULL,                -- Fecha límite de pago
    fecha_mod         DATE               NOT NULL                 -- Fecha de última modificación
);

-- Tabla para registro de consumos de agua
CREATE TABLE Clientes.Consumo
(
    ConsumoId         BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1), -- Identificador único del consumo
    lectura_anterior  INT                NOT NULL,                -- Lectura previa del medidor
    lectura_actual    INT                NOT NULL,                -- Lectura actual del medidor
    consumo_m3        INT                NOT NULL,                -- Consumo en metros cúbicos
    facturado_m3      MONEY              NOT NULL,                -- Monto facturado por consumo
    periodo_lectura   DATE               NOT NULL,                -- Fecha de la lectura
    costo_saneamiento INT,                                        -- Costo por saneamiento
    costo_drenaje     INT,                                        -- Costo por drenaje
    fecha_mod         DATE               NOT NULL                 -- Fecha de última modificación
);

-- Tabla de cargos por servicios adicionales
CREATE TABLE Clientes.CargoServicio
(
    CargoId     BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1), -- Identificador único del cargo
    descripcion VARCHAR(50)        NOT NULL,                -- Descripción del cargo
    monto       MONEY              NOT NULL,                -- Monto del cargo
    fecha_mod   DATE               NOT NULL                 -- Fecha de última modificación
);

-- Tabla para almacenar los diferentes métodos de pago aceptados
CREATE TABLE Clientes.MetodoPago
(
    MetodoPagoId     INT PRIMARY KEY NOT NULL IDENTITY(1,1),  -- Identificador único del método de pago
    nombre           VARCHAR(50)     NOT NULL,                -- Nombre del método de pago (Efectivo, Tarjeta, Transferencia)
    descripcion      VARCHAR(100)    NULL,                    -- Descripción adicional
    activo           BIT             NOT NULL DEFAULT 1,       -- Indica si el método está disponible
    requiere_comprobante BIT         NOT NULL DEFAULT 0,      -- Indica si requiere comprobante adicional
    fecha_mod        DATETIME        NOT NULL                 -- Fecha de última modificación
);

-- Tabla para registrar los pagos realizados por los clientes
CREATE TABLE Clientes.Pago
(
    PagoId           BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1), -- Identificador único del pago
    ClienteId        BIGINT          NOT NULL,                  -- Cliente que realiza el pago
    AdeudoId         BIGINT          NOT NULL,                  -- Adeudo que se está pagando
    monto            MONEY           NOT NULL,                  -- Cantidad pagada
    fecha_pago       DATETIME        NOT NULL,                  -- Fecha y hora del pago
    MetodoPagoId     INT             NOT NULL,                  -- Método utilizado para el pago
    EstablecimientoId BIGINT         NOT NULL,                  -- Sucursal donde se realizó el pago
    EmpleadoId       INT             NULL,                      -- Empleado que registró el pago (NULL si fue automático)
    referencia_pago  VARCHAR(50)     NULL,                      -- Referencia o número de autorización
    fecha_mod        DATETIME        NOT NULL                   -- Fecha de última modificación
);

-- Tabla para registrar el historial de estatus de los pagos
CREATE TABLE Clientes.EstatusPago
(
    EstatusId        INT PRIMARY KEY NOT NULL IDENTITY(1,1),    -- Identificador único del estatus
    nombre           VARCHAR(30)     NOT NULL,                  -- Nombre del estatus (Pendiente, Pagado, Cancelado, etc.)
    descripcion      VARCHAR(100)    NULL,                      -- Descripción del estatus
    fecha_mod        DATETIME        NOT NULL                   -- Fecha de última modificación
);

-- Tabla para seguimiento de estado de los pagos
CREATE TABLE Clientes.PagoEstatus
(
    PagoEstatusId    BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1), -- Identificador único del registro
    PagoId           BIGINT          NOT NULL,                  -- Referencia al pago
    EstatusId        INT             NOT NULL,                  -- Estatus actual del pago
    comentario       VARCHAR(200)    NULL,                      -- Comentario opcional sobre el cambio de estatus
    fecha_cambio     DATETIME        NOT NULL,                  -- Fecha y hora del cambio de estatus
    EmpleadoId       INT             NULL,                      -- Empleado que cambió el estatus
    fecha_mod        DATETIME        NOT NULL                   -- Fecha de última modificación
);

-- Tabla para comprobantes de pago (facturas, recibos, etc.)
CREATE TABLE Clientes.Comprobante
(
    ComprobanteId    BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1), -- Identificador único del comprobante
    PagoId           BIGINT          NOT NULL,                  -- Pago asociado al comprobante
    folio            VARCHAR(20)     NOT NULL,                  -- Número de folio del comprobante
    serie            VARCHAR(5)      NULL,                      -- Serie del comprobante (opcional)
    fecha_emision    DATETIME        NOT NULL,                  -- Fecha y hora de emisión
    subtotal         MONEY           NOT NULL,                  -- Subtotal sin impuestos
    iva              MONEY           NOT NULL,                  -- Monto de IVA
    total            MONEY           NOT NULL,                  -- Total con impuestos
    enlace_documento VARCHAR(100)    NULL,                      -- Ruta al documento digitalizado
    fecha_mod        DATETIME        NOT NULL                   -- Fecha de última modificación
);

-- Tabla para facilitar pagos parciales o pagos múltiples adeudos
CREATE TABLE Clientes.PagoDetalle
(
    PagoDetalleId    BIGINT PRIMARY KEY NOT NULL IDENTITY(1,1), -- Identificador único del detalle
    PagoId           BIGINT          NOT NULL,                  -- Pago al que pertenece
    AdeudoId         BIGINT          NOT NULL,                  -- Adeudo que se está pagando
    monto_aplicado   MONEY           NOT NULL,                  -- Monto aplicado a este adeudo específico
    fecha_mod        DATETIME        NOT NULL                   -- Fecha de última modificación
);

-- Definición de relaciones entre tablas
ALTER TABLE Clientes.Pago
    ADD CONSTRAINT FK_Pago_Cliente
        FOREIGN KEY (ClienteId) REFERENCES Clientes.Cliente (ClienteId);

ALTER TABLE Clientes.Pago
    ADD CONSTRAINT FK_Pago_Adeudo
        FOREIGN KEY (AdeudoId) REFERENCES Clientes.Adeudos (AdeudoId);

ALTER TABLE Clientes.Pago
    ADD CONSTRAINT FK_Pago_MetodoPago
        FOREIGN KEY (MetodoPagoId) REFERENCES Clientes.MetodoPago (MetodoPagoId);

ALTER TABLE Clientes.PagoEstatus
    ADD CONSTRAINT FK_PagoEstatus_Pago
        FOREIGN KEY (PagoId) REFERENCES Clientes.Pago (PagoId);

ALTER TABLE Clientes.PagoEstatus
    ADD CONSTRAINT FK_PagoEstatus_Estatus
        FOREIGN KEY (EstatusId) REFERENCES Clientes.EstatusPago (EstatusId);

ALTER TABLE Clientes.Comprobante
    ADD CONSTRAINT FK_Comprobante_Pago
        FOREIGN KEY (PagoId) REFERENCES Clientes.Pago (PagoId);

ALTER TABLE Clientes.PagoDetalle
    ADD CONSTRAINT FK_PagoDetalle_Pago
        FOREIGN KEY (PagoId) REFERENCES Clientes.Pago (PagoId);

ALTER TABLE Clientes.PagoDetalle
    ADD CONSTRAINT FK_PagoDetalle_Adeudo
        FOREIGN KEY (AdeudoId) REFERENCES Clientes.Adeudos (AdeudoId);
GO
ALTER TABLE Clientes.Contrato
    ADD CONSTRAINT
        FK_TipoTarifaId FOREIGN kEY (TipoTarifaId) REFERENCES Clientes.TipoTarifa (TipoTarifaId);

ALTER TABLE Clientes.TipoTarifa
    ADD CONSTRAINT
        FK_TarifaId FOREIGN KEY (TarifaId) REFERENCES Clientes.Tarifa (TarifaId);

ALTER TABLE Clientes.Adeudos
    ADD CONSTRAINT
        FK_ClienteId FOREIGN KEY (ClienteId) REFERENCES Clientes.Cliente (ClienteId);

ALTER TABLE Clientes.Adeudos
    ADD CONSTRAINT
        FK_ConsumoId FOREIGN KEY (ConsumoId) REFERENCES Clientes.Consumo (ConsumoId);

ALTER TABLE Clientes.Adeudos
    ADD CONSTRAINT
        FK_CargoId FOREIGN KEY (CargoId) REFERENCES Clientes.CargoServicio (CargoId);

ALTER TABLE Clientes.cliente
    ADD CONSTRAINT
        FK_ContratoId FOREIGN KEY (ContratoId) REFERENCES Clientes.Contrato (ContratoId);
GO
