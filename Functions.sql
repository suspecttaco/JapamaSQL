use BD_JAPAMA
go

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

            -- 5. Insertar Contrato Empleado
            DECLARE @ContratoId INT;
            INSERT INTO RecursosHumanos.ContratoEmpleado (tipo_contrato, fecha_contrato,
                                                          fecha_vencimiento, enlace_documento, fecha_mod)
            VALUES (@TipoContrato, GETDATE(), @FechaVencimiento,
                    @EnlaceDocumento, GETDATE());
            SET @ContratoId = SCOPE_IDENTITY();

            -- 6. Insertar Nómina
            DECLARE @NominaId INT;
            INSERT INTO RecursosHumanos.Nomina (clabe, BancoId, fecha_mod)
            VALUES (@Clabe, @BancoId, GETDATE());
            SET @NominaId = SCOPE_IDENTITY();

            -- 7. Insertar Empleado
            INSERT INTO RecursosHumanos.Empleado (nss, rfc, ContratoId, PuestoId, edo_civil,
                                                  fecha_nacimiento, fecha_contratacion, fecha_mod,
                                                  PersonaId, TurnoId, NominaId, actividad)
            VALUES (@NSS, @RFC, @ContratoId, @PuestoId, @EstadoCivil,
                    @FechaNacimiento, @FechaContratacion, GETDATE(),
                    @PersonaId, @TurnoId, @NominaId, 'A');

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

-- 3.- Insertar proveedor
        CREATE OR ALTER PROCEDURE Inventarios.InsertarProveedor
            -- Parámetros para Persona
            @Nombre VARCHAR(100),
            @Email VARCHAR(50),
            @NumeroTelefono VARCHAR(10),
            @TipoNumero INT,
            @TipoPersona varchar(1),
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
                INSERT INTO Personas.Domicilio (domicilio_linea1, domicilio_linea2, cod_postal,
                                                LocalidadId, TipoDomicilioId, fecha_mod)
                VALUES (@DomicilioLinea1, @DomicilioLinea2, @CodigoPostal,
                        @LocalidadId, @TipoDomicilioId, GETDATE());
                SET @DomicilioId = SCOPE_IDENTITY();

                -- 4. Insertar Persona
                DECLARE @PersonaId BIGINT;
                INSERT INTO Personas.Persona (nombre, tipo_persona,
                                              EmailId, NumeroTelId, DomicilioId, fecha_mod)
                VALUES (@Nombre, @TipoPersona,
                        @EmailId, @NumeroTelId, @DomicilioId, GETDATE());
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

-- 4.- Insertar producto

-- 5.- Insertar compra

-- 6.- Insertar reporteVehiculo

-- 7.- Insertar Reporte falla servicio

-- 8.- Insertar Adeudo