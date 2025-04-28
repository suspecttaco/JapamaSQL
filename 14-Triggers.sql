USE BD_JAPAMA
GO

CREATE SCHEMA Auditoria
GO

--DML
-- 1.- Actualizar fecha_mod en cada actualización de tuplas (EN TODAS LAS TABLAS ._.)

CREATE OR ALTER PROCEDURE Auditoria.Fecha_Mod_Trigger_ALL
AS
BEGIN
    DECLARE @SchemaName NVARCHAR(128)
    DECLARE @TableName NVARCHAR(128)
    DECLARE @SQL NVARCHAR(MAX)
    DECLARE @PrimaryKeyColumn NVARCHAR(128)

    -- Cursor para recorrer todos los esquemas y tablas
    DECLARE SchemaCursor CURSOR FOR
        SELECT DISTINCT TABLE_SCHEMA,
                        TABLE_NAME
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_TYPE = 'BASE TABLE'
          AND TABLE_SCHEMA IN ('Clientes', 'Inventarios', 'Personas', 'RecursosHumanos', 'Servicios', 'Sucursales')

    OPEN SchemaCursor
    FETCH NEXT FROM SchemaCursor INTO @SchemaName, @TableName

    WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Obtener el nombre de la columna de clave primaria
            SELECT @PrimaryKeyColumn = COL_NAME(ic.object_id, ic.column_id)
            FROM sys.indexes i
                     INNER JOIN sys.index_columns ic
                                ON i.object_id = ic.object_id
                                    AND i.index_id = ic.index_id
                     INNER JOIN sys.objects o
                                ON i.object_id = o.object_id
                     INNER JOIN sys.schemas s
                                ON o.schema_id = s.schema_id
            WHERE i.is_primary_key = 1
              AND s.name = @SchemaName
              AND o.name = @TableName;

            -- Crear trigger para UPDATE
            SET @SQL = '
        CREATE TRIGGER [' + @SchemaName + '].[TR_' + @TableName + '_UpdateFechaMod]
        ON [' + @SchemaName + '].[' + @TableName + ']
        AFTER UPDATE AS
        BEGIN
            SET NOCOUNT ON;
            IF UPDATE(fecha_mod) RETURN;

            UPDATE t
            SET fecha_mod = GETDATE()
            FROM [' + @SchemaName + '].[' + @TableName + '] t
            INNER JOIN INSERTED i ON t.' + @PrimaryKeyColumn + ' = i.' + @PrimaryKeyColumn + ';
        END'

            -- Eliminar el trigger si ya existe
            IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'TR_' + @TableName + '_UpdateFechaMod')
                EXEC ('DROP TRIGGER [' + @SchemaName + '].[TR_' + @TableName + '_UpdateFechaMod]')

            -- Crear el nuevo trigger
            EXEC sp_executesql @SQL

            FETCH NEXT FROM SchemaCursor INTO @SchemaName, @TableName
        END

    CLOSE SchemaCursor
    DEALLOCATE SchemaCursor
END
GO

EXEC Auditoria.Fecha_Mod_Trigger_ALL
GO

-- 2.- Bitacora de modificaciones

CREATE TABLE Auditoria.BitacoraModificaciones
(
    BitacoraId        BIGINT IDENTITY (1,1) PRIMARY KEY,
    Esquema           VARCHAR(50)  NOT NULL,
    Tabla             VARCHAR(50)  NOT NULL,
    PrimaryKeyColumn  VARCHAR(25)  NOT NULL,
    PrimaryKeyValue   VARCHAR(50)  NOT NULL,
    Usuario           VARCHAR(128) NOT NULL,
    FechaModificacion DATETIME     NOT NULL DEFAULT GETDATE()
)
GO

CREATE OR ALTER PROCEDURE Auditoria.TR_BITACORA_MOD_ALL
AS
BEGIN
    DECLARE @SchemaName NVARCHAR(50)
    DECLARE @TableName NVARCHAR(50)
    DECLARE @SQL NVARCHAR(MAX)
    DECLARE @PrimaryKeyColumn NVARCHAR(25)

    DECLARE SchemaCursor CURSOR FOR
        SELECT DISTINCT TABLE_SCHEMA,
                        TABLE_NAME
        FROM INFORMATION_SCHEMA.TABLES
        WHERE TABLE_TYPE = 'BASE TABLE'
          AND TABLE_SCHEMA IN ('Clientes', 'Inventarios', 'Personas', 'RecursosHumanos', 'Servicios', 'Sucursales')

    OPEN SchemaCursor
    FETCH NEXT FROM SchemaCursor INTO @SchemaName, @TableName

    WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Obtener nombre de la clave primaria
            SELECT @PrimaryKeyColumn = COL_NAME(ic.object_id, ic.column_id)
            FROM sys.indexes i
                     INNER JOIN sys.index_columns ic
                                ON i.object_id = ic.object_id
                                    AND i.index_id = ic.index_id
                     INNER JOIN sys.objects o
                                ON i.object_id = o.object_id
                     INNER JOIN sys.schemas s
                                ON o.schema_id = s.schema_id
            WHERE i.is_primary_key = 1
              AND s.name = @SchemaName
              AND o.name = @TableName;

            -- Crear trigger para UPDATE
            SET @SQL = '
        CREATE TRIGGER [' + @SchemaName + '].[TR_' + @TableName + '_Bitacora]
        ON [' + @SchemaName + '].[' + @TableName + ']
        AFTER UPDATE AS
        BEGIN
            INSERT INTO Auditoria.BitacoraModificaciones (
                Esquema,
                Tabla,
                PrimaryKeyColumn,
                PrimaryKeyValue,
                Usuario
            )
            SELECT
                ''' + @SchemaName + ''',
                ''' + @TableName + ''',
                ''' + @PrimaryKeyColumn + ''',
                CAST(i.' + @PrimaryKeyColumn + ' AS VARCHAR(50)),
                SYSTEM_USER
            FROM INSERTED i;
        END'

            -- Eliminar trigger si existe
            IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'TR_' + @TableName + '_Bitacora')
                EXEC ('DROP TRIGGER [' + @SchemaName + '].[TR_' + @TableName + '_Bitacora]')

            -- Crear nuevo trigger
            EXEC sp_executesql @SQL

            FETCH NEXT FROM SchemaCursor INTO @SchemaName, @TableName
        END

    CLOSE SchemaCursor
    DEALLOCATE SchemaCursor
END
GO

EXEC Auditoria.TR_BITACORA_MOD_ALL
GO
-- 3.- Bitacora modificaciones de inventario
CREATE TABLE Auditoria.ModificacionInventario
(
    ModId             BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1),
    ProductId         INT                NOT NULL REFERENCES Inventarios.Inventario (ProductoId),
    cantidad_anterior INT                NOT NULL,
    cantidad_nueva    INT                NOT NULL,
    fecha             DATE               NOT NULL
)
GO

CREATE OR ALTER TRIGGER TR_Historial_Inventario
    ON Inventarios.Inventario
    AFTER UPDATE
    AS
BEGIN
    SET NOCOUNT ON;

    -- Insertar registros del historial para todas las filas modificadas
    INSERT INTO Auditoria.ModificacionInventario
        (ProductId, cantidad_anterior, cantidad_nueva, fecha)
    SELECT i.ProductoId,
           d.cantidad,
           i.cantidad,
           GETDATE()
    FROM inserted i
             INNER JOIN deleted d ON i.ProductoId = d.ProductoId
    WHERE i.cantidad <> d.cantidad; -- Solo registrar cuando la cantidad realmente cambió
END
GO

-- 4.- Evitar que el sueldo ingresado sea menor al registrado

CREATE OR ALTER TRIGGER TR_REGLA_SUELDOS
    ON RecursosHumanos.Puesto
    AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(SELECT 1
              FROM inserted i
                       JOIN deleted d ON i.PuestoId = d.PuestoId
              WHERE i.salario_base < d.salario_base)
        BEGIN
            RAISERROR ('No se puede reducir el sueldo base', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
END
GO

-- 5.- Bigtacora modificaciones en el sueldo a los puestos
CREATE TABLE Auditoria.HistorialModSueldos
(
    ModId           INT PRIMARY KEY NOT NULL IDENTITY (1,1),
    PuestoId        SMALLINT        NOT NULL FOREIGN KEY REFERENCES RecursosHumanos.Puesto (PuestoId),
    fecha           DATE            NOT NULL,
    sueldo_anterior MONEY           NOT NULL,
    sueldo_nuevo    MONEY           NOT NULL
)
GO

CREATE OR ALTER TRIGGER TR_Registro_Sueldos
    ON RecursosHumanos.Puesto
    AFTER UPDATE
    AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Auditoria.HistorialModSueldos(PuestoId, fecha, sueldo_anterior, sueldo_nuevo)
    SELECT deleted.PuestoId, GETDATE(), deleted.salario_base, inserted.salario_base
    FROM inserted
             JOIN deleted
                  ON inserted.PuestoId = deleted.PuestoId;
END
GO

-- 6.- REGLA: Evitar que un horario dure mas de 8 horas

CREATE TRIGGER TR_HORARIO_MAX
    ON RecursosHumanos.Turno
    AFTER UPDATE
    AS
BEGIN
    IF EXISTS (SELECT 1
               FROM inserted
                        JOIN deleted ON inserted.TurnoId = deleted.TurnoId
               WHERE inserted.duracion > 8
                 AND inserted.tipo = 'MAT')
        BEGIN
            RAISERROR ('LA JORNADA MATUTINA SOLO DEBE SER DE 8 HORAS MAXIMAS',16,1);
            ROLLBACK TRANSACTION;
        END
    ELSE
        IF EXISTS (SELECT 1
                   FROM inserted
                            JOIN deleted ON inserted.TurnoId = deleted.TurnoId
                   WHERE inserted.duracion > 7.5
                     AND inserted.tipo = 'VES')
            BEGIN
                RAISERROR ('LA JORNADA VESPERTINA SOLO DEBE SER DE 7 HORAS Y MEDIA MAXIMAS',16,1);
                ROLLBACK TRANSACTION;
            END
        ELSE
            IF EXISTS (SELECT 1
                       FROM inserted
                                JOIN deleted ON inserted.TurnoId = deleted.TurnoId
                       WHERE inserted.duracion > 7
                         AND inserted.tipo = 'NOC')
                BEGIN
                    RAISERROR ('LA JORNADA NOCTURNA SOLO DEBE SER DE 7 HORAS MAXIMAS',16,1);
                    ROLLBACK TRANSACTION;
                END

END
GO

-- 7.- REGLA: DEBE EXISTIR UNO DE LOS SIGUIENTES: MaterialID | MobiliarioId | VehiculoId en la fina de Inventario

CREATE TRIGGER TR_CHECK_TIPO_INVENTARIO
    ON Inventarios.Inventario
    AFTER UPDATE
    AS
BEGIN
    IF NOT EXISTS(SELECT 1
                  FROM inserted
                  WHERE inserted.MaterialId IS NOT NULL
                     OR inserted.MobiliarioId IS NOT NULL
                     OR inserted.VehiculoId IS NOT NULL)
        BEGIN
            RAISERROR ('Debe haber minimo un tipo de producto',16,1);
            ROLLBACK TRANSACTION;
        END
END
GO

-- 8.- Revisar Fecha de vencimiento y aumentar saldo atrasado

CREATE TRIGGER TR_SALDO_ATRASADO
    ON Clientes.Adeudos
    AFTER UPDATE
    AS
BEGIN
    UPDATE Clientes.Adeudos
    SET adeudo_anterior += adeudo_actual
    WHERE DATEDIFF(DAY, fecha_vencimiento, GETDATE()) > 0
END
GO

--DDL
--1.- Cambio en la estructura/esquema de la BD
CREATE TABLE Auditoria.HistorialMovsEstructura
(
    [MovimientoId] int PRIMARY KEY IDENTITY (1,1) NOT NULL,
    [tipo_mov]     nvarchar(50)                   NULL,
    [nom_obj]      nvarchar(50)                   NULL,
    [tipo_obj]     nvarchar(25)                   NULL,
    [fecha]        datetime                       NULL,
    [usuario]      nvarchar(25)                   NULL,
)
GO

CREATE OR ALTER TRIGGER TG_REGISTRO_MOVS
    ON DATABASE
    FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE,
    CREATE_VIEW, ALTER_VIEW, DROP_VIEW,
    CREATE_PROCEDURE, ALTER_PROCEDURE, DROP_PROCEDURE,
    CREATE_FUNCTION, ALTER_FUNCTION, DROP_FUNCTION
    AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @EventData XML = EVENTDATA();

    BEGIN TRY
        INSERT INTO BD_JAPAMA.Auditoria.HistorialMovsEstructura (tipo_mov, nom_obj, tipo_obj, fecha, usuario)
        VALUES (@EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(50)'), -- Tipo de evento (ej. CREATE_TABLE)
                @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(50)'), -- Nombre del objeto (ej. tabla)
                @EventData.value('(/EVENT_INSTANCE/ObjectType)[1]', 'NVARCHAR(25)'), -- Tipo de objeto (ej. TABLE)
                GETDATE(), -- Fecha y hora del evento
                SUSER_NAME() -- Nombre del usuario que ejecutó la operación
               );
    END TRY
    BEGIN CATCH
        RETURN;
    END CATCH

END;
GO

--LOG ON
--1.- Historial de acceso a la BD
CREATE TABLE Auditoria.RegistroAccesoBD
(
    AccesoId     BIGINT PRIMARY KEY NOT NULL IDENTITY (1,1),
    usuario      varchar(128),
    fecha_acceso DATETIME DEFAULT GETDATE()
)
GO

CREATE OR ALTER TRIGGER TR_RegistroAccesos
    ON ALL SERVER
    FOR LOGON
    AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1
                   FROM BD_JAPAMA.Auditoria.RegistroAccesoBD
                   WHERE usuario = ORIGINAL_LOGIN()
                     AND fecha_acceso >= DATEADD(MINUTE, -30, GETDATE()))
        BEGIN
            BEGIN TRY
                INSERT INTO BD_JAPAMA.Auditoria.RegistroAccesoBD (usuario)
                VALUES (ORIGINAL_LOGIN());
            END TRY
            BEGIN CATCH
                RETURN;
            END CATCH
        END
END
GO
-- PARA EVITAR MUCHOS PROBLEMAS
DISABLE TRIGGER TR_RegistroAccesos ON ALL SERVER
GO


