USE BD_JAPAMA
GO

-- 1.- Insertar clientes
CREATE OR ALTER PROCEDURE Clientes.InsertarCliente
    -- Parámetros para Persona
    @Nombre VARCHAR(50),
    @Apellido1 VARCHAR(50),
    @Apellido2 VARCHAR(50),
    @Email VARCHAR(50),
    @NumeroTelefono VARCHAR(10),
    @TipoNumero INT,
    @TipoPersona varchar(1),
    -- Parámetros para Domicilio
    @DomicilioLinea1 VARCHAR(100),
    @DomicilioLinea2 VARCHAR(100),
    @CodigoPostal VARCHAR(5),
    @LocalidadId INT,
    @TipoDomicilioId INT,
    -- Parámetros para Cliente
    @FechaCorte DATE,
    -- Parámetros para Contrato
    @FechaContrato DATE,
    @EnlaceDocumento VARCHAR(50),
    @TipoTarifaId BIGINT,
    @Medidor VARCHAR(12)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Insertar Email
        DECLARE @EmailId BIGINT;
        INSERT INTO Personas.Email (correo, fecha_mod)
        VALUES (@Email, GETDATE());
        SET @EmailId = SCOPE_IDENTITY();

        -- 2. Insertar Número Telefónico
        DECLARE @NumeroTelId BIGINT;
        INSERT INTO Personas.NumeroTelefonico (numero, TipoNumeroId, fecha_mod)
        VALUES (@NumeroTelefono, @TipoNumero, GETDATE());
        SET @NumeroTelId = SCOPE_IDENTITY();

        -- 3. Insertar Domicilio
        DECLARE @DomicilioId BIGINT;
        INSERT INTO Personas.Domicilio (domicilio_linea1, domicilio_linea2, cod_postal,
                                        LocalidadId, TipoDomicilioId, fecha_mod)
        VALUES (@DomicilioLinea1, @DomicilioLinea2, @CodigoPostal,
                @LocalidadId, @TipoDomicilioId, GETDATE());
        SET @DomicilioId = SCOPE_IDENTITY();

        -- 4. Insertar Persona
        DECLARE @PersonaId BIGINT;
        INSERT INTO Personas.Persona (nombre, apellido1, apellido2, tipo_persona,
                                      EmailId, NumeroTelId, DomicilioId, fecha_mod)
        VALUES (@Nombre, @Apellido1, @Apellido2, @TipoPersona,
                @EmailId, @NumeroTelId, @DomicilioId, GETDATE());
        SET @PersonaId = SCOPE_IDENTITY();

        -- 5. Insertar Contrato
        DECLARE @ContratoId BIGINT;
        INSERT INTO Clientes.Contrato (fecha_contrato, enlace_documento,
                                       TipoTarifaId, medidor, fecha_mod)
        VALUES (@FechaContrato, @EnlaceDocumento,
                @TipoTarifaId, @Medidor, GETDATE());
        SET @ContratoId = SCOPE_IDENTITY();

        -- 6. Insertar Cliente
        INSERT INTO Clientes.Cliente (PersonaId, fecha_corte, ContratoId, fecha_mod)
        VALUES (@PersonaId, @FechaCorte, @ContratoId, GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- 2.- Insertar empleado
CREATE OR ALTER PROCEDURE RecursosHumanos.InsertarEmpleado
    -- Parámetros para Persona
    @Nombre VARCHAR(50),
    @Apellido1 VARCHAR(50),
    @Apellido2 VARCHAR(50),
    @Email VARCHAR(50),
    @NumeroTelefono VARCHAR(10),
    @TipoNumero INT,
    @TipoPersona varchar(1),
    -- Parámetros para Domicilio
    @DomicilioLinea1 VARCHAR(100),
    @DomicilioLinea2 VARCHAR(100),
    @CodigoPostal VARCHAR(5),
    @LocalidadId INT,
    @TipoDomicilioId INT,
    -- Parámetros específicos del Empleado
    @NSS VARCHAR(11),
    @RFC VARCHAR(13),
    @EstadoCivil VARCHAR(3),
    @FechaNacimiento DATE,
    @FechaContratacion DATETIME,
    @PuestoId SMALLINT,
    @TurnoId TINYINT,
    @EstablecimientoID INT,
    -- Parámetros para Contrato
    @TipoContrato VARCHAR(3),
    @FechaVencimiento DATETIME,
    @EnlaceDocumento VARCHAR(50),
    -- Parámetros para Nómina
    @Clabe VARCHAR(18),
    @BancoId INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Insertar Email
        DECLARE @EmailId BIGINT;
        INSERT INTO Personas.Email (correo, fecha_mod)
        VALUES (@Email, GETDATE());
        SET @EmailId = SCOPE_IDENTITY();

        -- 2. Insertar Número Telefónico
        DECLARE @NumeroTelId BIGINT;
        INSERT INTO Personas.NumeroTelefonico (numero, TipoNumeroId, fecha_mod)
        VALUES (@NumeroTelefono, @TipoNumero, GETDATE());
        SET @NumeroTelId = SCOPE_IDENTITY();

        -- 3. Insertar Domicilio
        DECLARE @DomicilioId BIGINT;
        INSERT INTO Personas.Domicilio (domicilio_linea1, domicilio_linea2, cod_postal, LocalidadId, TipoDomicilioId,
                                        fecha_mod)
        VALUES (@DomicilioLinea1, @DomicilioLinea2, @CodigoPostal, @LocalidadId, @TipoDomicilioId, GETDATE());
        SET @DomicilioId = SCOPE_IDENTITY();

        -- 4. Insertar Persona
        DECLARE @PersonaId BIGINT;
        INSERT INTO Personas.Persona (nombre, apellido1, apellido2, tipo_persona, EmailId, NumeroTelId, DomicilioId,
                                      fecha_mod)
        VALUES (@Nombre, @Apellido1, @Apellido2, @TipoPersona, @EmailId, @NumeroTelId, @DomicilioId, GETDATE());
        SET @PersonaId = SCOPE_IDENTITY();

        -- 5. Insertar Contrato Empleado
        DECLARE @ContratoId INT;
        INSERT INTO RecursosHumanos.ContratoEmpleado (tipo_contrato, fecha_contrato, fecha_vencimiento,
                                                      enlace_documento, fecha_mod)
        VALUES (@TipoContrato, GETDATE(), @FechaVencimiento, @EnlaceDocumento, GETDATE());
        SET @ContratoId = SCOPE_IDENTITY();

        -- 6. Insertar Nómina
        DECLARE @NominaId INT;
        INSERT INTO RecursosHumanos.Nomina (clabe, BancoId, fecha_mod)
        VALUES (@Clabe, @BancoId, GETDATE());
        SET @NominaId = SCOPE_IDENTITY();

        -- 7. Insertar Empleado
        INSERT INTO RecursosHumanos.Empleado (nss, rfc, ContratoId, PuestoId, edo_civil, fecha_nacimiento,
                                              fecha_contratacion, fecha_mod, PersonaId, TurnoId, NominaId, actividad,
                                              EstablecimientoId)
        VALUES (@NSS, @RFC, @ContratoId, @PuestoId, @EstadoCivil, @FechaNacimiento, @FechaContratacion, GETDATE(),
                @PersonaId, @TurnoId, @NominaId, 'A', @EstablecimientoID);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- 3.- Insertar proveedor
CREATE OR ALTER PROCEDURE Inventarios.InsertarProveedor
    -- Parámetros para Persona
    @Nombre VARCHAR(100),
    @Email VARCHAR(50),
    @NumeroTelefono VARCHAR(10),
    @TipoNumero INT,
    @TipoPersona varchar(1),
    @TipoDomicilioId INT,
    -- Parámetros para Domicilio
    @DomicilioLinea1 VARCHAR(100),
    @DomicilioLinea2 VARCHAR(100),
    @CodigoPostal VARCHAR(5),
    @LocalidadId INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Insertar Email
        DECLARE @EmailId BIGINT;
        INSERT INTO Personas.Email (correo, fecha_mod)
        VALUES (@Email, GETDATE());
        SET @EmailId = SCOPE_IDENTITY();

        -- 2. Insertar Número Telefónico
        DECLARE @NumeroTelId BIGINT;
        INSERT INTO Personas.NumeroTelefonico (numero, TipoNumeroId, fecha_mod)
        VALUES (@NumeroTelefono, @TipoNumero, GETDATE());
        SET @NumeroTelId = SCOPE_IDENTITY();

        -- 3. Insertar Domicilio
        DECLARE @DomicilioId BIGINT;
        INSERT INTO Personas.Domicilio (domicilio_linea1, domicilio_linea2, cod_postal, LocalidadId, TipoDomicilioId,
                                        fecha_mod)
        VALUES (@DomicilioLinea1, @DomicilioLinea2, @CodigoPostal, @LocalidadId, @TipoDomicilioId, GETDATE());
        SET @DomicilioId = SCOPE_IDENTITY();

        -- 4. Insertar Persona
        DECLARE @PersonaId BIGINT;
        INSERT INTO Personas.Persona (nombre, tipo_persona, EmailId, NumeroTelId, DomicilioId, fecha_mod)
        VALUES (@Nombre, @TipoPersona, @EmailId, @NumeroTelId, @DomicilioId, GETDATE());
        SET @PersonaId = SCOPE_IDENTITY();

        -- 5. Insertar Proveedor
        INSERT INTO Inventarios.Proveedor (PersonaId, fecha_mod)
        VALUES (@PersonaId, GETDATE())
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


-- 4.- Insertar producto
CREATE OR ALTER PROCEDURE Inventarios.InsertarProducto @Nombre varchar(50), @Descripcion varchar(50),
                                                       @Cantidad int, @TipoProducto varchar(1),
                                                       @SubtipoProducto int
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @MaterialId int;
        DECLARE @MobiliarioId int;
        IF @TipoProducto = 1
            BEGIN

                INSERT INTO Inventarios.Material (nombre, descripcion, actividad, TipoMaterialId, fecha_mod)
                VALUES (@Nombre, @Descripcion, 'A', @SubtipoProducto, GETDATE());
                SET @MaterialId = SCOPE_IDENTITY();

                INSERT INTO Inventarios.Inventario (MaterialId, cantidad, fecha_mod)
                VALUES (@MaterialId, @Cantidad, GETDATE())

            END
        ELSE
            IF @TipoProducto = 2
                BEGIN
                    INSERT INTO Inventarios.Mobiliario (nombre, descripcion, actividad, TipoMobiliarioId, fecha_mod)
                    VALUES (@Nombre, @Descripcion, 'A', @SubtipoProducto, GETDATE());
                    SET @MobiliarioId = SCOPE_IDENTITY();

                    INSERT INTO Inventarios.Inventario (MobiliarioId, cantidad, fecha_mod)
                    VALUES (@MobiliarioId, @Cantidad, GETDATE())
                END
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO

-- 5.- Insertar compra producto

CREATE OR ALTER PROCEDURE Inventarios.InsertarCompra @ProductoId INT, @FacturaId BIGINT, @ProveedorId INT, @Monto MONEY,
                                                     @Cantidad INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Insertar la compra
        INSERT INTO Inventarios.Compra (ProductoId, FacturaId, ProveedorId, fecha_compra, monto, cantidad, fecha_mod)
        VALUES (@ProductoId, @FacturaId, @ProveedorId, GETDATE(), @Monto, @Cantidad, GETDATE());

        -- 2. Actualizar el inventario
        UPDATE Inventarios.Inventario
        SET cantidad  = cantidad + @Cantidad,
            fecha_mod = GETDATE()
        WHERE ProductoId = @ProductoId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO

-- 6.- Insertar reporteVehiculo
CREATE OR ALTER PROCEDURE Inventarios.InsertarReporteVehiculo @VehiculoId INT, @TallerId INT, @Descripcion VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Inventarios.ReporteVehiculo (VehiculoId, TallerId, descripcion, fecha_reporte, fecha_mod)
        VALUES (@VehiculoId, @TallerId, @Descripcion, GETDATE(), GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO
-- 7.- Insertar Reporte falla servicio

CREATE OR ALTER PROCEDURE Servicios.InsertarTicketSoporte
    -- Parámetros para servicio general
    @ClienteId BIGINT,
    -- Parámetros específicos según el tipo de servicio
    @TipoServicio CHAR(1), -- 'R' Reporte, 'S' Suspensión, 'C' Carta, 'P' Programa
-- Parámetros para Reporte
    @Descripcion VARCHAR(50),
    @EmpleadoId BIGINT,
    @Seguimiento VARCHAR(50),
    @DepartamentoId BIGINT,
    @Observaciones VARCHAR(50),
    -- Parámetros para Suspensión
    @Actividad CHAR(1),
    @FechaSuspension DATE,
    @EnlaceDocumentoSuspension VARCHAR(50),
    -- Parámetros para Carta
    @EnlaceDocumentoCarta VARCHAR(50),
    -- Parámetros para Programa
    @ProgramaDescuentoId BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insertar el servicio según el tipo
        IF @TipoServicio = 'R'
            BEGIN
                -- Insertar Reporte Problema
                INSERT INTO Servicios.ReporteProblema
                (descripcion, fecha_reporte, EmpleadoId, seguimiento, DepartamentoId, observaciones, fecha_mod)
                VALUES (@Descripcion, GETDATE(), @EmpleadoId, @Seguimiento, @DepartamentoId, @Observaciones, GETDATE());

                DECLARE @ReporteId BIGINT = SCOPE_IDENTITY();

                -- Crear ticket con reporte
                INSERT INTO Servicios.TicketServicio
                (ClienteId, SuspensionId, ReporteProblema, ProgramaDescuento, CartaNoAdeudos, fecha_mod)
                VALUES (@ClienteId, NULL, @ReporteId, NULL, NULL, GETDATE());
            END

        ELSE
            IF @TipoServicio = 'S'
                BEGIN
                    -- Insertar Suspensión
                    INSERT INTO Servicios.SuspensionServicio
                        (actividad, descricpion, fecha_suspension, enlace_documento, fecha_mod)
                    VALUES (@Actividad, @Descripcion, @FechaSuspension, @EnlaceDocumentoSuspension, GETDATE());

                    DECLARE @SuspensionId BIGINT = SCOPE_IDENTITY();

                    -- Crear ticket con suspensión
                    INSERT INTO Servicios.TicketServicio
                    (ClienteId, SuspensionId, ReporteProblema, ProgramaDescuento, CartaNoAdeudos, fecha_mod)
                    VALUES (@ClienteId, @SuspensionId, NULL, NULL, NULL, GETDATE());
                END

            ELSE
                IF @TipoServicio = 'C'
                    BEGIN
                        -- Insertar Carta
                        INSERT INTO Servicios.CartaNoAdeudos
                            (enlace_documento, fecha_mod)
                        VALUES (@EnlaceDocumentoCarta, GETDATE());

                        DECLARE @CartaId BIGINT = SCOPE_IDENTITY();

                        -- Crear ticket con carta
                        INSERT INTO Servicios.TicketServicio
                        (ClienteId, SuspensionId, ReporteProblema, ProgramaDescuento, CartaNoAdeudos, fecha_mod)
                        VALUES (@ClienteId, NULL, NULL, NULL, @CartaId, GETDATE());
                    END

                ELSE
                    IF @TipoServicio = 'P'
                        BEGIN
                            -- Crear ticket con programa de descuento
                            INSERT INTO Servicios.TicketServicio
                            (ClienteId, SuspensionId, ReporteProblema, ProgramaDescuento, CartaNoAdeudos, fecha_mod)
                            VALUES (@ClienteId, NULL, NULL, @ProgramaDescuentoId, NULL, GETDATE());
                        END
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- 8.- Insertar Adeudo
CREATE OR ALTER PROCEDURE Clientes.InsertarAdeudoConConsumo
    -- Parámetros para Consumo
    @LecturaAnterior MONEY,
    @LecturaActual MONEY,
    @ConsumoM3 INT,
    @FacturadoM3 MONEY,
    @PeriodoLectura DATE,
    -- Parámetros para Adeudo
    @EstablecimientoId BIGINT,
    @ClienteId BIGINT,
    @CargoId BIGINT,
    @AdeudoAnterior MONEY,
    @AdeudoActual MONEY,
    @IVA MONEY,
    @FechaVencimiento DATE
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Insertar el registro de consumo
        DECLARE @ConsumoId BIGINT;

        INSERT INTO Clientes.Consumo (lectura_anterior,
                                      lectura_actual,
                                      consumo_m3,
                                      facturado_m3,
                                      periodo_lectura,
                                      fecha_mod)
        VALUES (@LecturaAnterior,
                @LecturaActual,
                @ConsumoM3,
                @FacturadoM3,
                @PeriodoLectura,
                GETDATE());

        SET @ConsumoId = SCOPE_IDENTITY();

        -- 2. Insertar el adeudo relacionado con el consumo
        INSERT INTO Clientes.Adeudos (EstablecimientoId,
                                      ClienteId,
                                      ConsumoId,
                                      CargoId,
                                      adeudo_anterior,
                                      adeudo_actual,
                                      IVA,
                                      fecha_vencimiento,
                                      fecha_mod)
        VALUES (@EstablecimientoId,
                @ClienteId,
                @ConsumoId,
                @CargoId,
                @AdeudoAnterior,
                @AdeudoActual,
                @IVA,
                @FechaVencimiento,
                GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO