USE [master]
GO
/****** Object:  Database [BD_JAPAMA]    Script Date: 31/05/2025 12:55:37 a. m. ******/
CREATE DATABASE [BD_JAPAMA]
    CONTAINMENT = NONE
    ON  PRIMARY
    ( NAME = N'BD_JAPAMA', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\BD_JAPAMA.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
    LOG ON
    ( NAME = N'BD_JAPAMA_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\BD_JAPAMA_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BD_JAPAMA] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
    begin
        EXEC [BD_JAPAMA].[dbo].[sp_fulltext_database] @action = 'enable'
    end
GO
ALTER DATABASE [BD_JAPAMA] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [BD_JAPAMA] SET ANSI_NULLS OFF
GO
ALTER DATABASE [BD_JAPAMA] SET ANSI_PADDING OFF
GO
ALTER DATABASE [BD_JAPAMA] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [BD_JAPAMA] SET ARITHABORT OFF
GO
ALTER DATABASE [BD_JAPAMA] SET AUTO_CLOSE ON
GO
ALTER DATABASE [BD_JAPAMA] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [BD_JAPAMA] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [BD_JAPAMA] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [BD_JAPAMA] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [BD_JAPAMA] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [BD_JAPAMA] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [BD_JAPAMA] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [BD_JAPAMA] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [BD_JAPAMA] SET  ENABLE_BROKER
GO
ALTER DATABASE [BD_JAPAMA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [BD_JAPAMA] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [BD_JAPAMA] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [BD_JAPAMA] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [BD_JAPAMA] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [BD_JAPAMA] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [BD_JAPAMA] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [BD_JAPAMA] SET RECOVERY SIMPLE
GO
ALTER DATABASE [BD_JAPAMA] SET  MULTI_USER
GO
ALTER DATABASE [BD_JAPAMA] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [BD_JAPAMA] SET DB_CHAINING OFF
GO
ALTER DATABASE [BD_JAPAMA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF )
GO
ALTER DATABASE [BD_JAPAMA] SET TARGET_RECOVERY_TIME = 60 SECONDS
GO
ALTER DATABASE [BD_JAPAMA] SET DELAYED_DURABILITY = DISABLED
GO
ALTER DATABASE [BD_JAPAMA] SET ACCELERATED_DATABASE_RECOVERY = OFF
GO
ALTER DATABASE [BD_JAPAMA] SET QUERY_STORE = ON
GO
ALTER DATABASE [BD_JAPAMA] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BD_JAPAMA]
GO
/****** Object:  Schema [Auditoria]    Script Date: 31/05/2025 12:55:37 a. m. ******/
CREATE SCHEMA [Auditoria]
GO
/****** Object:  Schema [Clientes]    Script Date: 31/05/2025 12:55:37 a. m. ******/
CREATE SCHEMA [Clientes]
GO
/****** Object:  Schema [Inventarios]    Script Date: 31/05/2025 12:55:37 a. m. ******/
CREATE SCHEMA [Inventarios]
GO
/****** Object:  Schema [Personas]    Script Date: 31/05/2025 12:55:37 a. m. ******/
CREATE SCHEMA [Personas]
GO
/****** Object:  Schema [RecursosHumanos]    Script Date: 31/05/2025 12:55:37 a. m. ******/
CREATE SCHEMA [RecursosHumanos]
GO
/****** Object:  Schema [Servicios]    Script Date: 31/05/2025 12:55:37 a. m. ******/
CREATE SCHEMA [Servicios]
GO
/****** Object:  Schema [Sucursales]    Script Date: 31/05/2025 12:55:37 a. m. ******/
CREATE SCHEMA [Sucursales]
GO
/****** Object:  Synonym [Clientes].[Usuarios]    Script Date: 31/05/2025 12:55:37 a. m. ******/
CREATE SYNONYM [Clientes].[Usuarios] FOR [Clientes].[Cliente]
GO
/****** Object:  Synonym [RecursosHumanos].[Trabajadores]    Script Date: 31/05/2025 12:55:37 a. m. ******/
CREATE SYNONYM [RecursosHumanos].[Trabajadores] FOR [RecursosHumanos].[Empleado]
GO
/****** Object:  UserDefinedFunction [Clientes].[FC_TotalUsuariosActivos]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 2.- Total de usuarios activos
CREATE FUNCTION [Clientes].[FC_TotalUsuariosActivos]()
    RETURNS BIGINT AS
BEGIN
    DECLARE @TotalActivos BIGINT
    SET @TotalActivos = (SELECT COUNT(*) FROM Clientes.Cliente
                         WHERE Clientes.Cliente.actividad = 'A')
    RETURN @TotalActivos
END
GO
/****** Object:  UserDefinedFunction [Personas].[FC_TotalPersonaFisicaMoral]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 4.- Total de tipo de persona fisica/moral
CREATE FUNCTION [Personas].[FC_TotalPersonaFisicaMoral]
(@tipo VARCHAR(1)) RETURNS INT AS
BEGIN
    DECLARE @TotalPersona INT
    SET @TotalPersona = (SELECT COUNT(*) FROM Personas.Persona
                         WHERE Personas.Persona.tipo_persona = @tipo);
    RETURN @TotalPersona
END
GO
/****** Object:  UserDefinedFunction [RecursosHumanos].[AsistenciaPeriodo]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 2.- Historial de asistencia detallado por periodo (fecha inicio -> fecha fin)
CREATE FUNCTION [RecursosHumanos].[AsistenciaPeriodo] (@fecha_inicio DATETIME ,@fecha_fin DATETIME)
    RETURNS @AsistenciaPeriodo TABLE (
                                         nom_establecimiento varchar(50),
                                         nom_empleado varchar(50),
                                         ap1 varchar(50),
                                         ap2 varchar(50),
                                         fecha date,
                                         hora_entrada time(0),
                                         hora_salida time(0)
                                     )
AS
BEGIN
    INSERT @AsistenciaPeriodo
    SELECT
        Es.nombre,
        P.nombre,
        P.apellido1,
        P.apellido2,
        CONVERT(DATE,A.fecha_entrada),
        CONVERT(TIME(0), A.fecha_entrada),
        CONVERT(TIME(0),A.fecha_salida)
    FROM RecursosHumanos.Empleado as E
             INNER JOIN RecursosHumanos.HistorialAsistencia as A ON E.EmpleadoId = A.EmpleadoId
             INNER JOIN Personas.Persona P ON E.PersonaId = P.PersonaId
             INNER JOIN Sucursales.Establecimiento as Es ON E.EstablecimientoId = Es.EstablecimientoId
    WHERE A.fecha_entrada >= @fecha_inicio AND A.fecha_entrada <= @fecha_fin
    RETURN
END
GO
/****** Object:  UserDefinedFunction [RecursosHumanos].[FC_TotalAsistenciasEmpleados]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--         SCALABLE FUNCTION. -
-- 1.- Total de asistencias
CREATE FUNCTION [RecursosHumanos].[FC_TotalAsistenciasEmpleados]
(@EmpleadoID BIGINT) returns BIGINT AS
BEGIN
    DECLARE @Asistencias BIGINT
    SET @Asistencias = (SELECT COUNT(*) FROM RecursosHumanos.Empleado
                        WHERE RecursosHumanos.Empleado.EmpleadoId = @EmpleadoID);
    RETURN @Asistencias
END
GO
/****** Object:  UserDefinedFunction [RecursosHumanos].[FC_TotalRetardosEmp]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 3.- Total de retardos
CREATE FUNCTION [RecursosHumanos].[FC_TotalRetardosEmp]
(@EmpleadoID BIGINT) returns INT AS
BEGIN
    DECLARE @TotalRetardos INT
    DECLARE @Asistencia DATETIME
    SET @Asistencia = (SELECT RecursosHumanos.HistorialAsistencia.fecha_entrada
                       FROM RecursosHumanos.HistorialAsistencia
                       WHERE RecursosHumanos.HistorialAsistencia.EmpleadoId = @EmpleadoID )
    IF @EmpleadoID IS NOT NULL
        BEGIN
            SET @TotalRetardos = (SELECT COUNT(*) FROM RecursosHumanos.HistorialAsistencia
                                  WHERE RecursosHumanos.HistorialAsistencia.EmpleadoId =
                                        @EmpleadoID AND (DATEDIFF(HOUR,@Asistencia,'07:00')) < 0)
        END
    ELSE
        SET @TotalRetardos = 0;
    RETURN @TotalRetardos
END
GO
/****** Object:  UserDefinedFunction [RecursosHumanos].[N_EmpleadoContrato]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- FUNCTION WITH VALUES TABLE
-- 1.- Numero de Empleados/contrato especifico
CREATE FUNCTION [RecursosHumanos].[N_EmpleadoContrato] ()
    RETURNS @ContratoEmpleado TABLE (
                                        NtipoContrato INT ,
                                        tipo_contrato CHAR(3) --SIN ->Sindicalizado CON->Confianza EVE->Eventuales
                                    )
AS
BEGIN
    INSERT @ContratoEmpleado
    SELECT COUNT(*),RecursosHumanos.ContratoEmpleado.tipo_contrato
    FROM RecursosHumanos.Empleado INNER JOIN RecursosHumanos.ContratoEmpleado
                                             ON RecursosHumanos.Empleado.ContratoId = RecursosHumanos.ContratoEmpleado.ContratoId
    GROUP BY RecursosHumanos.ContratoEmpleado.tipo_contrato
    RETURN
END
GO
/****** Object:  Table [Sucursales].[Establecimiento]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sucursales].[Establecimiento](
                                               [EstablecimientoId] [bigint] IDENTITY(1,1) NOT NULL,
                                               [nombre] [varchar](50) NOT NULL,
                                               [TipoEstablecimientoId] [bigint] NOT NULL,
                                               [DomicilioId] [bigint] NOT NULL,
                                               [RedId] [int] NOT NULL,
                                               [DepartamentoId] [int] NOT NULL,
                                               [fecha_mod] [date] NOT NULL,
                                               PRIMARY KEY CLUSTERED
                                                   (
                                                    [EstablecimientoId] ASC
                                                       )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Personas].[Persona]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Personas].[Persona](
                                     [PersonaId] [bigint] IDENTITY(1,1) NOT NULL,
                                     [nombre] [varchar](50) NOT NULL,
                                     [apellido1] [varchar](50) NULL,
                                     [apellido2] [varchar](50) NULL,
                                     [tipo_persona] [varchar](1) NOT NULL,
                                     [EmailId] [bigint] NULL,
                                     [NumeroTelId] [bigint] NULL,
                                     [DomicilioId] [bigint] NULL,
                                     [fecha_mod] [datetime] NOT NULL,
                                     PRIMARY KEY CLUSTERED
                                         (
                                          [PersonaId] ASC
                                             )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [RecursosHumanos].[Empleado]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RecursosHumanos].[Empleado](
                                             [EmpleadoId] [int] IDENTITY(1,1) NOT NULL,
                                             [nss] [varchar](11) NOT NULL,
                                             [rfc] [varchar](13) NOT NULL,
                                             [ContratoId] [int] NOT NULL,
                                             [PuestoId] [smallint] NOT NULL,
                                             [edo_civil] [varchar](3) NOT NULL,
                                             [fecha_nacimiento] [date] NOT NULL,
                                             [fecha_contratacion] [datetime] NOT NULL,
                                             [actividad] [char](1) NOT NULL,
                                             [fecha_mod] [datetime] NOT NULL,
                                             [PersonaId] [bigint] NOT NULL,
                                             [TurnoId] [tinyint] NOT NULL,
                                             [NominaId] [int] NOT NULL,
                                             [EstablecimientoId] [bigint] NOT NULL,
                                             PRIMARY KEY CLUSTERED
                                                 (
                                                  [EmpleadoId] ASC
                                                     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [RecursosHumanos].[ContratoEmpleado]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RecursosHumanos].[ContratoEmpleado](
                                                     [ContratoId] [int] IDENTITY(1,1) NOT NULL,
                                                     [tipo_contrato] [varchar](3) NOT NULL,
                                                     [fecha_contrato] [datetime] NOT NULL,
                                                     [fecha_vencimiento] [datetime] NOT NULL,
                                                     [enlace_documento] [varchar](50) NOT NULL,
                                                     [fecha_mod] [datetime] NOT NULL,
                                                     PRIMARY KEY CLUSTERED
                                                         (
                                                          [ContratoId] ASC
                                                             )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [RecursosHumanos].[Puesto]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RecursosHumanos].[Puesto](
                                           [PuestoId] [smallint] IDENTITY(1,1) NOT NULL,
                                           [descripcion] [varchar](50) NOT NULL,
                                           [salario_base] [money] NOT NULL,
                                           [bonos] [money] NOT NULL,
                                           [fecha_mod] [datetime] NOT NULL,
                                           PRIMARY KEY CLUSTERED
                                               (
                                                [PuestoId] ASC
                                                   )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [RecursosHumanos].[V8_EmpleadosSindicato]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--8 - 10.-Lista empleados (tipo de contrato) *3
CREATE VIEW [RecursosHumanos].[V8_EmpleadosSindicato] AS
SELECT emp.EmpleadoId,
       emp.PersonaId,
       per.apellido1,
       per.apellido2,
       per.nombre,
       emp.edo_civil,
       suc.EstablecimientoId,
       suc.nombre AS Establecimiento,
       suc.DomicilioId,
       emp.fecha_contratacion,
       ctemp.fecha_vencimiento,
       pst.PuestoId,
       pst.salario_base,
       pst.bonos
FROM RecursosHumanos.Empleado emp
         INNER JOIN Personas.Persona per ON emp.PersonaId = emp.PersonaId
         INNER JOIN Sucursales.Establecimiento suc ON emp.EstablecimientoId = suc.EstablecimientoId
         INNER JOIN RecursosHumanos.ContratoEmpleado ctemp ON emp.ContratoId = ctemp.ContratoId
         INNER JOIN RecursosHumanos.Puesto pst ON emp.PuestoId = pst.PuestoId
WHERE ctemp.tipo_contrato = 'SIN'
GO
/****** Object:  View [RecursosHumanos].[V9_EmpleadosConfianza]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [RecursosHumanos].[V9_EmpleadosConfianza] AS
SELECT emp.EmpleadoId,
       emp.PersonaId,
       per.apellido1,
       per.apellido2,
       per.nombre,
       emp.edo_civil,
       suc.EstablecimientoId,
       suc.nombre AS Establecimiento,
       suc.DomicilioId,
       emp.fecha_contratacion,
       ctemp.fecha_vencimiento,
       pst.PuestoId,
       pst.salario_base,
       pst.bonos
FROM RecursosHumanos.Empleado emp
         INNER JOIN Personas.Persona per ON emp.PersonaId = emp.PersonaId
         INNER JOIN Sucursales.Establecimiento suc ON emp.EstablecimientoId = suc.EstablecimientoId
         INNER JOIN RecursosHumanos.ContratoEmpleado ctemp ON emp.ContratoId = ctemp.ContratoId
         INNER JOIN RecursosHumanos.Puesto pst ON emp.PuestoId = pst.PuestoId
WHERE ctemp.tipo_contrato = 'CON'
GO
/****** Object:  View [RecursosHumanos].[V10_EmpleadosEventuaales]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [RecursosHumanos].[V10_EmpleadosEventuaales] AS
SELECT emp.EmpleadoId,
       emp.PersonaId,
       per.apellido1,
       per.apellido2,
       per.nombre,
       emp.edo_civil,
       suc.EstablecimientoId,
       suc.nombre AS Establecimiento,
       suc.DomicilioId,
       emp.fecha_contratacion,
       ctemp.fecha_vencimiento,
       pst.PuestoId,
       pst.salario_base,
       pst.bonos
FROM RecursosHumanos.Empleado emp
         INNER JOIN Personas.Persona per ON emp.PersonaId = emp.PersonaId
         INNER JOIN Sucursales.Establecimiento suc ON emp.EstablecimientoId = suc.EstablecimientoId
         INNER JOIN RecursosHumanos.ContratoEmpleado ctemp ON emp.ContratoId = ctemp.ContratoId
         INNER JOIN RecursosHumanos.Puesto pst ON emp.PuestoId = pst.PuestoId
WHERE ctemp.tipo_contrato = 'EVE'
GO
/****** Object:  Table [Servicios].[CartaNoAdeudos]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Servicios].[CartaNoAdeudos](
                                             [CartaId] [bigint] IDENTITY(1,1) NOT NULL,
                                             [enlace_documento] [varchar](50) NOT NULL,
                                             [fecha_mod] [date] NOT NULL,
                                             PRIMARY KEY CLUSTERED
                                                 (
                                                  [CartaId] ASC
                                                     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clientes].[Cliente]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clientes].[Cliente](
                                     [ClienteId] [bigint] IDENTITY(1,1) NOT NULL,
                                     [PersonaId] [bigint] NOT NULL,
                                     [fecha_corte] [date] NOT NULL,
                                     [ContratoId] [bigint] NOT NULL,
                                     [actividad] [char](1) NULL,
                                     [fecha_mod] [date] NOT NULL,
                                     PRIMARY KEY CLUSTERED
                                         (
                                          [ClienteId] ASC
                                             )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Servicios].[TicketServicio]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Servicios].[TicketServicio](
                                             [ServicioId] [bigint] IDENTITY(1,1) NOT NULL,
                                             [ClienteId] [bigint] NOT NULL,
                                             [SuspensionId] [bigint] NULL,
                                             [ReporteProblema] [bigint] NULL,
                                             [ProgramaDescuento] [bigint] NULL,
                                             [CartaNoAdeudos] [bigint] NULL,
                                             [fecha_mod] [date] NOT NULL,
                                             PRIMARY KEY CLUSTERED
                                                 (
                                                  [ServicioId] ASC
                                                     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Servicios].[V11_ListaClientesCartaNoAdeudos]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Servicios].[V11_ListaClientesCartaNoAdeudos] AS
SELECT cli.ClienteId,
       P.nombre,
       P.apellido1,
       P.apellido2,
       crt.CartaId,
       crt.enlace_documento
FROM Servicios.TicketServicio tser
         INNER JOIN Servicios.CartaNoAdeudos crt ON tser.CartaNoAdeudos = crt.CartaId
         INNER JOIN Clientes.Cliente cli ON tser.ClienteId = cli.ClienteId
         INNER JOIN Personas.Persona P ON cli.PersonaId = P.PersonaId
GO
/****** Object:  Table [Servicios].[SuspensionServicio]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Servicios].[SuspensionServicio](
                                                 [SuspensionId] [bigint] IDENTITY(1,1) NOT NULL,
                                                 [actividad] [char](1) NULL,
                                                 [descricpion] [varchar](50) NOT NULL,
                                                 [fecha_suspension] [date] NOT NULL,
                                                 [enlace_documento] [varchar](50) NOT NULL,
                                                 [fecha_mod] [date] NOT NULL,
                                                 PRIMARY KEY CLUSTERED
                                                     (
                                                      [SuspensionId] ASC
                                                         )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clientes].[Contrato]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clientes].[Contrato](
                                      [ContratoId] [bigint] IDENTITY(1,1) NOT NULL,
                                      [fecha_contrato] [date] NOT NULL,
                                      [enlace_documento] [varchar](50) NOT NULL,
                                      [TipoTarifaId] [bigint] NOT NULL,
                                      [medidor] [varchar](12) NOT NULL,
                                      [fecha_mod] [date] NOT NULL,
                                      PRIMARY KEY CLUSTERED
                                          (
                                           [ContratoId] ASC
                                              )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Servicios].[V12_ListaClientesSuspension]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--12.-Lista clientes suspension (info solicitud)
CREATE VIEW [Servicios].[V12_ListaClientesSuspension] AS
SELECT cli.ClienteId,
       per.apellido1,
       per.apellido2,
       per.nombre       AS Persona,
       per.NumeroTelId,
       per.EmailId,
       sser.descricpion AS SuspensionServicio,
       sser.SuspensionId,
       sser.fecha_suspension,
       ctr.ContratoId,
       ctr.fecha_contrato,
       ctr.medidor
FROM Servicios.TicketServicio ticket
         INNER JOIN Clientes.Cliente cli ON ticket.ClienteId = cli.ClienteId
         INNER JOIN Clientes.Contrato ctr ON cli.ContratoId = ctr.ContratoId
         INNER JOIN Personas.Persona per ON cli.PersonaId = per.PersonaId
         INNER JOIN Servicios.SuspensionServicio sser ON ticket.SuspensionId = sser.SuspensionId
GO
/****** Object:  Table [Inventarios].[Vehiculo]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventarios].[Vehiculo](
                                         [VehiculoId] [int] IDENTITY(1,1) NOT NULL,
                                         [TipoVehiculoId] [int] NULL,
                                         [matricula] [varchar](20) NOT NULL,
                                         [actividad] [varchar](1) NOT NULL,
                                         [EstablecimientoId] [bigint] NULL,
                                         [fecha_mod] [datetime] NOT NULL,
                                         PRIMARY KEY CLUSTERED
                                             (
                                              [VehiculoId] ASC
                                                 )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventarios].[TipoVehiculo]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventarios].[TipoVehiculo](
                                             [TipoVehiculoId] [int] IDENTITY(1,1) NOT NULL,
                                             [nombre] [varchar](50) NOT NULL,
                                             [fecha_mod] [datetime] NOT NULL,
                                             PRIMARY KEY CLUSTERED
                                                 (
                                                  [TipoVehiculoId] ASC
                                                     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Inventarios].[V13_ListaVehiculosSucursal]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--13.-Lista vehiculos (por sucursal)
CREATE VIEW [Inventarios].[V13_ListaVehiculosSucursal] AS
SELECT veh.VehiculoId,
       veh.TipoVehiculoId,
       veh.matricula,
       tveh.nombre,
       veh.actividad,
       veh.EstablecimientoId,
       veh.fecha_mod,
       suc.TipoEstablecimientoId,
       suc.DomicilioId
FROM Inventarios.Vehiculo veh
         INNER JOIN Sucursales.Establecimiento suc ON veh.EstablecimientoId = suc.EstablecimientoId
         INNER JOIN Inventarios.TipoVehiculo tveh ON veh.TipoVehiculoId = tveh.TipoVehiculoId
GO
/****** Object:  Table [RecursosHumanos].[Turno]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RecursosHumanos].[Turno](
                                          [TurnoId] [tinyint] IDENTITY(1,1) NOT NULL,
                                          [tipo] [char](3) NOT NULL,
                                          [duracion] [tinyint] NOT NULL,
                                          [hora_entrada] [time](0) NOT NULL,
                                          [hora_salida] [time](0) NOT NULL,
                                          [fecha_mod] [datetime] NOT NULL,
                                          PRIMARY KEY CLUSTERED
                                              (
                                               [TurnoId] ASC
                                                  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [RecursosHumanos].[V14_ListaEmpleadoMatutino]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--14 - 16.-Lista empleados (por turno especifico) *3 (solo activos)
CREATE VIEW [RecursosHumanos].[V14_ListaEmpleadoMatutino] AS
SELECT emp.EmpleadoId,
       per.apellido1,
       per.apellido2,
       per.nombre AS Persona,
       emp.TurnoId,
       etrn.tipo,
       etrn.duracion,
       etrn.hora_entrada,
       etrn.hora_salida
FROM RecursosHumanos.Empleado emp
         INNER JOIN RecursosHumanos.Turno etrn ON emp.TurnoId = etrn.TurnoId
         INNER JOIN Personas.Persona per ON emp.PersonaId = per.PersonaId
WHERE etrn.tipo = 'MAT'
GO
/****** Object:  View [RecursosHumanos].[V15_ListaEmpleadoVespertino]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [RecursosHumanos].[V15_ListaEmpleadoVespertino] AS
SELECT emp.EmpleadoId,
       per.apellido1,
       per.apellido2,
       per.nombre AS Persona,
       emp.TurnoId,
       etrn.tipo,
       etrn.duracion,
       etrn.hora_entrada,
       etrn.hora_salida
FROM RecursosHumanos.Empleado emp
         INNER JOIN RecursosHumanos.Turno etrn ON emp.TurnoId = etrn.TurnoId
         INNER JOIN Personas.Persona per ON emp.PersonaId = per.PersonaId
WHERE etrn.tipo = 'VES'
GO
/****** Object:  View [RecursosHumanos].[V16_ListaEmpleadoNocturno]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [RecursosHumanos].[V16_ListaEmpleadoNocturno] AS
SELECT emp.EmpleadoId,
       per.apellido1,
       per.apellido2,
       per.nombre AS Persona,
       emp.TurnoId,
       etrn.tipo,
       etrn.duracion,
       etrn.hora_entrada,
       etrn.hora_salida
FROM RecursosHumanos.Empleado emp
         INNER JOIN RecursosHumanos.Turno etrn ON emp.TurnoId = etrn.TurnoId
         INNER JOIN Personas.Persona per ON emp.PersonaId = per.PersonaId
WHERE etrn.tipo = 'NOC'
GO
/****** Object:  Table [Sucursales].[Departamento]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sucursales].[Departamento](
                                            [DepartamentoId] [int] IDENTITY(1,1) NOT NULL,
                                            [descripcion] [varchar](50) NOT NULL,
                                            [segmento_red] [varchar](16) NOT NULL,
                                            [fecha_mod] [date] NOT NULL,
                                            PRIMARY KEY CLUSTERED
                                                (
                                                 [DepartamentoId] ASC
                                                    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [RecursosHumanos].[V1_ListaEmpleadosActivos]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--1.-Lista empleados Activos
CREATE VIEW [RecursosHumanos].[V1_ListaEmpleadosActivos] AS
SELECT e.EmpleadoId,
       e.ContratoId,
       e.PuestoId,
       e.fecha_contratacion,
       e.TurnoId,
       e.rfc,
       d.DepartamentoId,
       c.tipo_contrato
FROM RecursosHumanos.Empleado e
         INNER JOIN Personas.Persona p ON e.PersonaId = p.PersonaId
         INNER JOIN Sucursales.Departamento d ON e.ContratoId = d.DepartamentoId
         INNER JOIN RecursosHumanos.ContratoEmpleado c ON e.ContratoId = c.ContratoId
WHERE e.Actividad = 'A'
GO
/****** Object:  View [Clientes].[V2_ListaClientes]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--2.-Lista clientes Activos
CREATE VIEW [Clientes].[V2_ListaClientes] AS
SELECT c.ClienteId,
       p.PersonaId,
       p.apellido1,
       p.apellido2,
       p.nombre,
       p.tipo_persona,
       c.ContratoId
FROM Clientes.Cliente c
         INNER JOIN Personas.Persona p ON c.PersonaId = p.PersonaId
GO
/****** Object:  View [Servicios].[V3_ContratosActivos]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--3.-Contratos activos
CREATE VIEW [Servicios].[V3_ContratosActivos] AS
SELECT ts.ClienteId,
       cl.PersonaId,
       cl.ContratoId,
       cnt.TipoTarifaId,
       ss.actividad,
       cl.fecha_corte,
       ss.fecha_suspension,
       cnt.fecha_contrato,
       cnt.medidor
FROM Servicios.TicketServicio ts
         INNER JOIN Servicios.SuspensionServicio ss ON ts.SuspensionId = ss.SuspensionId
         INNER JOIN Clientes.Cliente cl ON ts.ClienteId = cl.ClienteId
         INNER JOIN Clientes.Contrato cnt ON ts.ClienteId = cnt.ContratoId
WHERE ss.actividad IS NULL
GO
/****** Object:  Table [Inventarios].[Material]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventarios].[Material](
                                         [MaterialId] [int] IDENTITY(1,1) NOT NULL,
                                         [nombre] [varchar](50) NOT NULL,
                                         [descripcion] [varchar](50) NULL,
                                         [actividad] [varchar](1) NOT NULL,
                                         [TipoMaterialId] [int] NULL,
                                         [fecha_mod] [datetime] NOT NULL,
                                         PRIMARY KEY CLUSTERED
                                             (
                                              [MaterialId] ASC
                                                 )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventarios].[Mobiliario]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventarios].[Mobiliario](
                                           [MobiliarioId] [int] IDENTITY(1,1) NOT NULL,
                                           [nombre] [varchar](50) NOT NULL,
                                           [descripcion] [varchar](50) NOT NULL,
                                           [actividad] [varchar](1) NOT NULL,
                                           [TipoMobiliarioId] [int] NULL,
                                           [fecha_mod] [datetime] NOT NULL,
                                           PRIMARY KEY CLUSTERED
                                               (
                                                [MobiliarioId] ASC
                                                   )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventarios].[Inventario]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventarios].[Inventario](
                                           [ProductoId] [int] IDENTITY(1,1) NOT NULL,
                                           [MaterialId] [int] NULL,
                                           [MobiliarioId] [int] NULL,
                                           [VehiculoId] [int] NULL,
                                           [cantidad] [int] NOT NULL,
                                           [fecha_mod] [datetime] NOT NULL,
                                           PRIMARY KEY CLUSTERED
                                               (
                                                [ProductoId] ASC
                                                   )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Inventarios].[V4_ListaInventarioActual]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--4.-Lista inventario actual
CREATE VIEW [Inventarios].[V4_ListaInventarioActual] AS
SELECT inv.ProductoId,
       inv.MaterialId,
       inv.MobiliarioId,
       inv.VehiculoId,
       mat.TipoMaterialId,
       mat.descripcion AS Material,
       mat.actividad   AS mat,
       mob.TipoMobiliarioId,
       mob.descripcion AS Mobiliario,
       mob.actividad   AS mob,
       veh.TipoVehiculoId,
       veh.matricula,
       veh.EstablecimientoId,
       veh.actividad   AS veh
FROM Inventarios.Inventario inv
         INNER JOIN Inventarios.Material mat ON inv.MaterialId = mat.MaterialId
         INNER JOIN Inventarios.Mobiliario mob ON inv.MobiliarioId = mob.MobiliarioId
         INNER JOIN Inventarios.Vehiculo veh ON inv.VehiculoId = veh.VehiculoId
GO
/****** Object:  Table [Inventarios].[Proveedor]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventarios].[Proveedor](
                                          [ProveedorId] [int] IDENTITY(1,1) NOT NULL,
                                          [PersonaId] [bigint] NULL,
                                          [fecha_mod] [datetime] NOT NULL,
                                          PRIMARY KEY CLUSTERED
                                              (
                                               [ProveedorId] ASC
                                                  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Inventarios].[V5_ListaProveedores]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--5.-Lista proveedores
CREATE VIEW [Inventarios].[V5_ListaProveedores] AS
SELECT pro.ProveedorId,
       pro.PersonaId,
       per.apellido1,
       per.apellido2,
       per.nombre,
       per.tipo_persona,
       per.NumeroTelId,
       per.EmailId
FROM Inventarios.Proveedor pro
         INNER JOIN Personas.Persona per ON pro.PersonaId = per.PersonaId
GO
/****** Object:  Table [Personas].[Domicilio]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Personas].[Domicilio](
                                       [DomicilioId] [bigint] IDENTITY(1,1) NOT NULL,
                                       [domicilio_linea1] [varchar](100) NOT NULL,
                                       [domicilio_linea2] [varchar](100) NULL,
                                       [cod_postal] [varchar](5) NOT NULL,
                                       [LocalidadId] [int] NOT NULL,
                                       [TipoDomicilioId] [int] NOT NULL,
                                       [fecha_mod] [datetime] NOT NULL,
                                       [SectorId] [int] NULL,
                                       PRIMARY KEY CLUSTERED
                                           (
                                            [DomicilioId] ASC
                                               )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Servicios].[ReporteProblema]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Servicios].[ReporteProblema](
                                              [ReporteId] [bigint] IDENTITY(1,1) NOT NULL,
                                              [descripcion] [varchar](50) NOT NULL,
                                              [fecha_reporte] [date] NOT NULL,
                                              [EmpleadoId] [bigint] NOT NULL,
                                              [seguimiento] [varchar](50) NOT NULL,
                                              [DepartamentoId] [bigint] NOT NULL,
                                              [observaciones] [varchar](50) NULL,
                                              [fecha_mod] [date] NOT NULL,
                                              PRIMARY KEY CLUSTERED
                                                  (
                                                   [ReporteId] ASC
                                                      )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Servicios].[V6_ListaReportes]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--6.-Historial reportes (cliente y donde fue)
CREATE VIEW [Servicios].[V6_ListaReportes] AS
SELECT --cliente y donde fue
       rp.ReporteId,
       ticket.ClienteId,
       rp.descripcion,
       rp.DepartamentoId,
       rp.fecha_reporte,
       dom.DomicilioId,
       dom.LocalidadId,
       dom.domicilio_linea1,
       dom.domicilio_linea2,
       dom.cod_postal
FROM Servicios.TicketServicio ticket
         INNER JOIN Servicios.ReporteProblema AS rp ON ticket.ReporteProblema = rp.ReporteId
         INNER JOIN Clientes.Cliente cli ON ticket.ClienteId = cli.ClienteId
         INNER JOIN Sucursales.Departamento dpa ON rp.DepartamentoId = dpa.DepartamentoId
         INNER JOIN Personas.Domicilio dom ON cli.ClienteId = dom.DomicilioId
GO
/****** Object:  Table [Sucursales].[TipoEstablecimiento]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sucursales].[TipoEstablecimiento](
                                                   [TipoEstablecimientId] [bigint] IDENTITY(1,1) NOT NULL,
                                                   [nombre] [varchar](50) NOT NULL,
                                                   [fecha_mod] [date] NOT NULL,
                                                   PRIMARY KEY CLUSTERED
                                                       (
                                                        [TipoEstablecimientId] ASC
                                                           )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Sucursales].[V7_ListaSucursaleTipo]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--7.-Lista sucursales (por tipo)
CREATE VIEW [Sucursales].[V7_ListaSucursaleTipo] AS
SELECT suc.EstablecimientoId,
       suc.nombre  AS Establecimiento,
       suc.TipoEstablecimientoId,
       tsuc.nombre AS TipoEstablecimiento,
       dom.DomicilioId,
       dom.LocalidadId,
       dom.domicilio_linea1,
       dom.domicilio_linea2,
       dom.cod_postal,
       dpa.DepartamentoId,
       dpa.descripcion
FROM Sucursales.Establecimiento suc
         INNER JOIN Sucursales.TipoEstablecimiento tsuc ON suc.TipoEstablecimientoId = tsuc.TipoEstablecimientId
         INNER JOIN Personas.Domicilio dom ON suc.DomicilioId = dom.DomicilioId
         INNER JOIN Sucursales.Departamento dpa ON suc.DepartamentoId = dpa.DepartamentoId
GO
/****** Object:  Table [Auditoria].[BitacoraModificaciones]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auditoria].[BitacoraModificaciones](
                                                     [BitacoraId] [bigint] IDENTITY(1,1) NOT NULL,
                                                     [Esquema] [varchar](50) NOT NULL,
                                                     [Tabla] [varchar](50) NOT NULL,
                                                     [PrimaryKeyColumn] [varchar](25) NOT NULL,
                                                     [PrimaryKeyValue] [varchar](50) NOT NULL,
                                                     [Usuario] [varchar](128) NOT NULL,
                                                     [FechaModificacion] [datetime] NOT NULL,
                                                     PRIMARY KEY CLUSTERED
                                                         (
                                                          [BitacoraId] ASC
                                                             )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auditoria].[HistorialModSueldos]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auditoria].[HistorialModSueldos](
                                                  [ModId] [int] IDENTITY(1,1) NOT NULL,
                                                  [PuestoId] [smallint] NOT NULL,
                                                  [fecha] [date] NOT NULL,
                                                  [sueldo_anterior] [money] NOT NULL,
                                                  [sueldo_nuevo] [money] NOT NULL,
                                                  PRIMARY KEY CLUSTERED
                                                      (
                                                       [ModId] ASC
                                                          )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auditoria].[HistorialMovsEstructura]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auditoria].[HistorialMovsEstructura](
                                                      [MovimientoId] [int] IDENTITY(1,1) NOT NULL,
                                                      [tipo_mov] [nvarchar](50) NULL,
                                                      [nom_obj] [nvarchar](50) NULL,
                                                      [tipo_obj] [nvarchar](25) NULL,
                                                      [fecha] [datetime] NULL,
                                                      [usuario] [nvarchar](25) NULL,
                                                      PRIMARY KEY CLUSTERED
                                                          (
                                                           [MovimientoId] ASC
                                                              )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auditoria].[ModificacionInventario]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auditoria].[ModificacionInventario](
                                                     [ModId] [bigint] IDENTITY(1,1) NOT NULL,
                                                     [ProductId] [int] NOT NULL,
                                                     [cantidad_anterior] [int] NOT NULL,
                                                     [cantidad_nueva] [int] NOT NULL,
                                                     [fecha] [date] NOT NULL,
                                                     PRIMARY KEY CLUSTERED
                                                         (
                                                          [ModId] ASC
                                                             )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Auditoria].[RegistroAccesoBD]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Auditoria].[RegistroAccesoBD](
                                               [AccesoId] [bigint] IDENTITY(1,1) NOT NULL,
                                               [usuario] [varchar](128) NULL,
                                               [fecha_acceso] [datetime] NULL,
                                               PRIMARY KEY CLUSTERED
                                                   (
                                                    [AccesoId] ASC
                                                       )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clientes].[Adeudos]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clientes].[Adeudos](
                                     [AdeudoId] [bigint] IDENTITY(1,1) NOT NULL,
                                     [EstablecimientoId] [bigint] NOT NULL,
                                     [ClienteId] [bigint] NOT NULL,
                                     [ConsumoId] [bigint] NOT NULL,
                                     [CargoId] [bigint] NOT NULL,
                                     [adeudo_anterior] [money] NOT NULL,
                                     [adeudo_actual] [money] NOT NULL,
                                     [IVA] [money] NOT NULL,
                                     [fecha_vencimiento] [date] NOT NULL,
                                     [fecha_mod] [date] NOT NULL,
                                     PRIMARY KEY CLUSTERED
                                         (
                                          [AdeudoId] ASC
                                             )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clientes].[CargoServicio]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clientes].[CargoServicio](
                                           [CargoId] [bigint] IDENTITY(1,1) NOT NULL,
                                           [descripcion] [varchar](50) NOT NULL,
                                           [monto] [money] NOT NULL,
                                           [fecha_mod] [date] NOT NULL,
                                           PRIMARY KEY CLUSTERED
                                               (
                                                [CargoId] ASC
                                                   )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clientes].[Comprobante]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clientes].[Comprobante](
                                         [ComprobanteId] [bigint] IDENTITY(1,1) NOT NULL,
                                         [PagoId] [bigint] NOT NULL,
                                         [folio] [varchar](20) NOT NULL,
                                         [serie] [varchar](5) NULL,
                                         [fecha_emision] [datetime] NOT NULL,
                                         [subtotal] [money] NOT NULL,
                                         [iva] [money] NOT NULL,
                                         [total] [money] NOT NULL,
                                         [enlace_documento] [varchar](100) NULL,
                                         [fecha_mod] [datetime] NOT NULL,
                                         PRIMARY KEY CLUSTERED
                                             (
                                              [ComprobanteId] ASC
                                                 )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clientes].[Consumo]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clientes].[Consumo](
                                     [ConsumoId] [bigint] IDENTITY(1,1) NOT NULL,
                                     [lectura_anterior] [money] NOT NULL,
                                     [lectura_actual] [money] NOT NULL,
                                     [consumo_m3] [int] NOT NULL,
                                     [facturado_m3] [money] NOT NULL,
                                     [periodo_lectura] [date] NOT NULL,
                                     [costo_saneamiento] [int] NOT NULL,
                                     [costo_drenaje] [int] NOT NULL,
                                     [fecha_mod] [date] NOT NULL,
                                     CONSTRAINT [PK__Consumo__206D9D26C0082C16] PRIMARY KEY CLUSTERED
                                         (
                                          [ConsumoId] ASC
                                             )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clientes].[EstatusPago]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clientes].[EstatusPago](
                                         [EstatusId] [int] IDENTITY(1,1) NOT NULL,
                                         [nombre] [varchar](30) NOT NULL,
                                         [descripcion] [varchar](100) NULL,
                                         [fecha_mod] [datetime] NOT NULL,
                                         PRIMARY KEY CLUSTERED
                                             (
                                              [EstatusId] ASC
                                                 )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clientes].[MetodoPago]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clientes].[MetodoPago](
                                        [MetodoPagoId] [int] IDENTITY(1,1) NOT NULL,
                                        [nombre] [varchar](50) NOT NULL,
                                        [descripcion] [varchar](100) NULL,
                                        [activo] [bit] NOT NULL,
                                        [requiere_comprobante] [bit] NOT NULL,
                                        [fecha_mod] [datetime] NOT NULL,
                                        PRIMARY KEY CLUSTERED
                                            (
                                             [MetodoPagoId] ASC
                                                )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clientes].[Pago]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clientes].[Pago](
                                  [PagoId] [bigint] IDENTITY(1,1) NOT NULL,
                                  [ClienteId] [bigint] NOT NULL,
                                  [AdeudoId] [bigint] NOT NULL,
                                  [monto] [money] NOT NULL,
                                  [fecha_pago] [datetime] NOT NULL,
                                  [MetodoPagoId] [int] NOT NULL,
                                  [EstablecimientoId] [bigint] NOT NULL,
                                  [EmpleadoId] [int] NULL,
                                  [referencia_pago] [varchar](50) NULL,
                                  [fecha_mod] [datetime] NOT NULL,
                                  PRIMARY KEY CLUSTERED
                                      (
                                       [PagoId] ASC
                                          )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clientes].[PagoDetalle]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clientes].[PagoDetalle](
                                         [PagoDetalleId] [bigint] IDENTITY(1,1) NOT NULL,
                                         [PagoId] [bigint] NOT NULL,
                                         [AdeudoId] [bigint] NOT NULL,
                                         [monto_aplicado] [money] NOT NULL,
                                         [fecha_mod] [datetime] NOT NULL,
                                         PRIMARY KEY CLUSTERED
                                             (
                                              [PagoDetalleId] ASC
                                                 )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clientes].[PagoEstatus]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clientes].[PagoEstatus](
                                         [PagoEstatusId] [bigint] IDENTITY(1,1) NOT NULL,
                                         [PagoId] [bigint] NOT NULL,
                                         [EstatusId] [int] NOT NULL,
                                         [comentario] [varchar](200) NULL,
                                         [fecha_cambio] [datetime] NOT NULL,
                                         [EmpleadoId] [int] NULL,
                                         [fecha_mod] [datetime] NOT NULL,
                                         PRIMARY KEY CLUSTERED
                                             (
                                              [PagoEstatusId] ASC
                                                 )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clientes].[Tarifa]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clientes].[Tarifa](
                                    [TarifaId] [bigint] IDENTITY(1,1) NOT NULL,
                                    [precio_base] [money] NOT NULL,
                                    [base_agua] [money] NOT NULL,
                                    [base_drenaje] [money] NOT NULL,
                                    [base_saneamiento] [money] NOT NULL,
                                    [max_m3] [int] NOT NULL,
                                    [fecha_mod] [date] NOT NULL,
                                    PRIMARY KEY CLUSTERED
                                        (
                                         [TarifaId] ASC
                                            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Clientes].[TipoTarifa]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Clientes].[TipoTarifa](
                                        [TipoTarifaId] [bigint] IDENTITY(1,1) NOT NULL,
                                        [nombre] [varchar](50) NOT NULL,
                                        [TarifaId] [bigint] NOT NULL,
                                        [fecha_mod] [date] NOT NULL,
                                        PRIMARY KEY CLUSTERED
                                            (
                                             [TipoTarifaId] ASC
                                                )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventarios].[Compra]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventarios].[Compra](
                                       [CompraId] [bigint] IDENTITY(1,1) NOT NULL,
                                       [ProductoId] [int] NULL,
                                       [FacturaId] [bigint] NULL,
                                       [ProveedorId] [int] NULL,
                                       [fecha_compra] [datetime] NOT NULL,
                                       [monto] [money] NOT NULL,
                                       [cantidad] [int] NOT NULL,
                                       [fecha_mod] [datetime] NULL,
                                       PRIMARY KEY CLUSTERED
                                           (
                                            [CompraId] ASC
                                               )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventarios].[Facturacion]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventarios].[Facturacion](
                                            [FacturaId] [bigint] IDENTITY(1,1) NOT NULL,
                                            [EstablecimientoId] [bigint] NULL,
                                            [fecha_factura] [datetime] NOT NULL,
                                            [enlace_documento] [varchar](100) NOT NULL,
                                            [fecha_mod] [datetime] NOT NULL,
                                            PRIMARY KEY CLUSTERED
                                                (
                                                 [FacturaId] ASC
                                                    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventarios].[ReporteVehiculo]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventarios].[ReporteVehiculo](
                                                [ReporteId] [bigint] IDENTITY(1,1) NOT NULL,
                                                [VehiculoId] [int] NULL,
                                                [TallerId] [int] NULL,
                                                [descripcion] [varchar](100) NOT NULL,
                                                [fecha_reporte] [datetime] NOT NULL,
                                                [fecha_mod] [datetime] NOT NULL,
                                                PRIMARY KEY CLUSTERED
                                                    (
                                                     [ReporteId] ASC
                                                        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventarios].[TallerVehiculo]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventarios].[TallerVehiculo](
                                               [TallerId] [int] IDENTITY(1,1) NOT NULL,
                                               [PersonaId] [bigint] NULL,
                                               [fecha_mod] [datetime] NOT NULL,
                                               PRIMARY KEY CLUSTERED
                                                   (
                                                    [TallerId] ASC
                                                       )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventarios].[TipoMaterial]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventarios].[TipoMaterial](
                                             [TipoMaterialId] [int] IDENTITY(1,1) NOT NULL,
                                             [descripcion] [varchar](50) NULL,
                                             [fecha_mod] [datetime] NOT NULL,
                                             PRIMARY KEY CLUSTERED
                                                 (
                                                  [TipoMaterialId] ASC
                                                     )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Inventarios].[TipoMobiliario]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inventarios].[TipoMobiliario](
                                               [TipoMobiliarioId] [int] IDENTITY(1,1) NOT NULL,
                                               [descripcion] [varchar](50) NOT NULL,
                                               [fecha_mod] [datetime] NOT NULL,
                                               PRIMARY KEY CLUSTERED
                                                   (
                                                    [TipoMobiliarioId] ASC
                                                       )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Personas].[Email]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Personas].[Email](
                                   [EmailId] [bigint] IDENTITY(1,1) NOT NULL,
                                   [correo] [varchar](50) NOT NULL,
                                   [fecha_mod] [datetime] NOT NULL,
                                   PRIMARY KEY CLUSTERED
                                       (
                                        [EmailId] ASC
                                           )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Personas].[Localidad]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Personas].[Localidad](
                                       [LocalidadId] [int] IDENTITY(1,1) NOT NULL,
                                       [nombre] [varchar](50) NOT NULL,
                                       [fecha_mod] [datetime] NOT NULL,
                                       PRIMARY KEY CLUSTERED
                                           (
                                            [LocalidadId] ASC
                                               )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Personas].[NumeroTelefonico]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Personas].[NumeroTelefonico](
                                              [NumeroTelId] [bigint] IDENTITY(1,1) NOT NULL,
                                              [numero] [varchar](10) NOT NULL,
                                              [TipoNumeroId] [int] NULL,
                                              [fecha_mod] [datetime] NOT NULL,
                                              PRIMARY KEY CLUSTERED
                                                  (
                                                   [NumeroTelId] ASC
                                                      )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Personas].[Sector]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Personas].[Sector](
                                    [SectorId] [int] IDENTITY(1,1) NOT NULL,
                                    [nombre] [varchar](50) NOT NULL,
                                    [descripcion] [varchar](200) NULL,
                                    [TipoSectorId] [int] NULL,
                                    [LocalidadId] [int] NULL,
                                    [area_km2] [decimal](10, 2) NULL,
                                    [poblacion] [int] NULL,
                                    [fecha_mod] [datetime] NOT NULL,
                                    PRIMARY KEY CLUSTERED
                                        (
                                         [SectorId] ASC
                                            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Personas].[TipoDomicilio]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Personas].[TipoDomicilio](
                                           [TipoDomicilioId] [int] IDENTITY(1,1) NOT NULL,
                                           [descripcion] [varchar](50) NOT NULL,
                                           [fecha_mod] [datetime] NOT NULL,
                                           PRIMARY KEY CLUSTERED
                                               (
                                                [TipoDomicilioId] ASC
                                                   )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Personas].[TipoNumero]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Personas].[TipoNumero](
                                        [TipoNumeroId] [int] IDENTITY(1,1) NOT NULL,
                                        [descripcion] [varchar](50) NOT NULL,
                                        [fecha_mod] [datetime] NOT NULL,
                                        PRIMARY KEY CLUSTERED
                                            (
                                             [TipoNumeroId] ASC
                                                )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Personas].[TipoSector]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Personas].[TipoSector](
                                        [TipoSectorId] [int] IDENTITY(1,1) NOT NULL,
                                        [descripcion] [varchar](50) NOT NULL,
                                        [fecha_mod] [datetime] NOT NULL,
                                        PRIMARY KEY CLUSTERED
                                            (
                                             [TipoSectorId] ASC
                                                )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [RecursosHumanos].[Banco]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RecursosHumanos].[Banco](
                                          [BancoId] [int] IDENTITY(1,1) NOT NULL,
                                          [nombre] [varchar](50) NOT NULL,
                                          [fecha_mod] [datetime] NOT NULL,
                                          PRIMARY KEY CLUSTERED
                                              (
                                               [BancoId] ASC
                                                  )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [RecursosHumanos].[HistorialAsistencia]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RecursosHumanos].[HistorialAsistencia](
                                                        [AsistenciaId] [int] IDENTITY(1,1) NOT NULL,
                                                        [EmpleadoId] [int] NOT NULL,
                                                        [fecha_entrada] [datetime] NOT NULL,
                                                        [fecha_salida] [datetime] NOT NULL,
                                                        [fecha_mod] [datetime] NOT NULL,
                                                        PRIMARY KEY CLUSTERED
                                                            (
                                                             [AsistenciaId] ASC
                                                                )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [RecursosHumanos].[Nomina]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RecursosHumanos].[Nomina](
                                           [NominaId] [int] IDENTITY(1,1) NOT NULL,
                                           [clabe] [varchar](18) NOT NULL,
                                           [BancoId] [int] NOT NULL,
                                           [fecha_mod] [datetime] NOT NULL,
                                           PRIMARY KEY CLUSTERED
                                               (
                                                [NominaId] ASC
                                                   )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [RecursosHumanos].[PuestoSindicato]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RecursosHumanos].[PuestoSindicato](
                                                    [PuestoSindicatoId] [smallint] IDENTITY(1,1) NOT NULL,
                                                    [nombre] [char](50) NOT NULL,
                                                    [estatus] [varchar](1) NOT NULL,
                                                    [fecha_mod] [datetime] NOT NULL,
                                                    PRIMARY KEY CLUSTERED
                                                        (
                                                         [PuestoSindicatoId] ASC
                                                            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [RecursosHumanos].[Sindicato]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RecursosHumanos].[Sindicato](
                                              [SindicatoId] [int] IDENTITY(1,1) NOT NULL,
                                              [EmpleadoId] [int] NOT NULL,
                                              [fecha_afiliacion] [datetime] NOT NULL,
                                              [PuestoSindicatoId] [smallint] NOT NULL,
                                              [fecha_mod] [datetime] NOT NULL,
                                              PRIMARY KEY CLUSTERED
                                                  (
                                                   [SindicatoId] ASC
                                                      )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Servicios].[ProgramaDescuento]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Servicios].[ProgramaDescuento](
                                                [ProgramaId] [bigint] IDENTITY(1,1) NOT NULL,
                                                [descricpion] [varchar](50) NOT NULL,
                                                [porcentaje_aplicado] [float] NOT NULL,
                                                [fecha_inicio] [date] NOT NULL,
                                                [fecha_final] [date] NOT NULL,
                                                [fecha_mod] [date] NOT NULL,
                                                PRIMARY KEY CLUSTERED
                                                    (
                                                     [ProgramaId] ASC
                                                        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sucursales].[CajeroAutomatico]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sucursales].[CajeroAutomatico](
                                                [CajeroId] [bigint] IDENTITY(1,1) NOT NULL,
                                                [EstablecimientoId] [bigint] NOT NULL,
                                                [actividad] [char](1) NOT NULL,
                                                [fecha_inicio] [date] NOT NULL,
                                                [fecha_cierre] [date] NOT NULL,
                                                [horario] [varchar](20) NOT NULL,
                                                [BancoId] [int] NOT NULL,
                                                [fecha_mod] [date] NOT NULL,
                                                PRIMARY KEY CLUSTERED
                                                    (
                                                     [CajeroId] ASC
                                                        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Sucursales].[Red]    Script Date: 31/05/2025 12:55:37 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sucursales].[Red](
                                   [RedId] [int] IDENTITY(1,1) NOT NULL,
                                   [compania_red] [varchar](50) NOT NULL,
                                   [segmento_red] [varchar](16) NOT NULL,
                                   [fecha_mod] [date] NOT NULL,
                                   PRIMARY KEY CLUSTERED
                                       (
                                        [RedId] ASC
                                           )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [Auditoria].[HistorialMovsEstructura] ON
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (1, N'CREATE_TABLE', N'RegistroAccesoBD', N'TABLE', CAST(N'2025-04-28T02:22:56.160' AS DateTime), N'MSI_B550M_PRO\eladi')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (2, N'CREATE_TABLE', N'Tmp_Consumo', N'TABLE', CAST(N'2025-05-28T03:20:27.763' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (3, N'ALTER_TABLE', N'Tmp_Consumo', N'TABLE', CAST(N'2025-05-28T03:20:27.770' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (4, N'ALTER_TABLE', N'Adeudos', N'TABLE', CAST(N'2025-05-28T03:20:27.783' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (5, N'DROP_TABLE', N'Consumo', N'TABLE', CAST(N'2025-05-28T03:20:27.790' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (6, N'ALTER_TABLE', N'Consumo', N'TABLE', CAST(N'2025-05-28T03:20:28.203' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (7, N'ALTER_TABLE', N'Adeudos', N'TABLE', CAST(N'2025-05-28T03:20:28.370' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (8, N'ALTER_TABLE', N'Adeudos', N'TABLE', CAST(N'2025-05-28T03:20:28.370' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (9, N'CREATE_TABLE', N'Tmp_Consumo', N'TABLE', CAST(N'2025-05-28T03:24:35.977' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (10, N'ALTER_TABLE', N'Tmp_Consumo', N'TABLE', CAST(N'2025-05-28T03:24:35.980' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (11, N'ALTER_TABLE', N'Adeudos', N'TABLE', CAST(N'2025-05-28T03:24:35.987' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (12, N'DROP_TABLE', N'Consumo', N'TABLE', CAST(N'2025-05-28T03:24:35.990' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (13, N'ALTER_TABLE', N'Consumo', N'TABLE', CAST(N'2025-05-28T03:24:36.013' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (14, N'ALTER_TABLE', N'Adeudos', N'TABLE', CAST(N'2025-05-28T03:24:36.147' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (15, N'ALTER_TABLE', N'Adeudos', N'TABLE', CAST(N'2025-05-28T03:24:36.150' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (16, N'CREATE_TABLE', N'MetodoPago', N'TABLE', CAST(N'2025-05-31T00:23:37.467' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (17, N'CREATE_TABLE', N'Pago', N'TABLE', CAST(N'2025-05-31T00:23:37.487' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (18, N'CREATE_TABLE', N'EstatusPago', N'TABLE', CAST(N'2025-05-31T00:23:37.490' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (19, N'CREATE_TABLE', N'PagoEstatus', N'TABLE', CAST(N'2025-05-31T00:23:37.493' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (20, N'CREATE_TABLE', N'Comprobante', N'TABLE', CAST(N'2025-05-31T00:23:37.497' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (21, N'CREATE_TABLE', N'PagoDetalle', N'TABLE', CAST(N'2025-05-31T00:23:37.500' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (22, N'ALTER_TABLE', N'Pago', N'TABLE', CAST(N'2025-05-31T00:23:37.513' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (23, N'ALTER_TABLE', N'Pago', N'TABLE', CAST(N'2025-05-31T00:23:37.517' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (24, N'ALTER_TABLE', N'Pago', N'TABLE', CAST(N'2025-05-31T00:23:37.520' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (25, N'ALTER_TABLE', N'PagoEstatus', N'TABLE', CAST(N'2025-05-31T00:23:37.523' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (26, N'ALTER_TABLE', N'PagoEstatus', N'TABLE', CAST(N'2025-05-31T00:23:37.523' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (27, N'ALTER_TABLE', N'Comprobante', N'TABLE', CAST(N'2025-05-31T00:23:37.530' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (28, N'ALTER_TABLE', N'PagoDetalle', N'TABLE', CAST(N'2025-05-31T00:23:37.530' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (29, N'ALTER_TABLE', N'PagoDetalle', N'TABLE', CAST(N'2025-05-31T00:23:37.533' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (30, N'CREATE_TABLE', N'TipoSector', N'TABLE', CAST(N'2025-05-31T00:28:39.930' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (31, N'CREATE_TABLE', N'Sector', N'TABLE', CAST(N'2025-05-31T00:28:39.940' AS DateTime), N'LATITUDE-5520\Suspect')
GO
INSERT [Auditoria].[HistorialMovsEstructura] ([MovimientoId], [tipo_mov], [nom_obj], [tipo_obj], [fecha], [usuario]) VALUES (32, N'ALTER_TABLE', N'Domicilio', N'TABLE', CAST(N'2025-05-31T00:28:39.973' AS DateTime), N'LATITUDE-5520\Suspect')
GO
SET IDENTITY_INSERT [Auditoria].[HistorialMovsEstructura] OFF
GO
SET IDENTITY_INSERT [Clientes].[Adeudos] ON
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (1, 1, 1, 1, 1, 0.0000, 150.0000, 24.0000, CAST(N'2024-02-15' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (2, 1, 1, 2, 4, 150.0000, 290.0000, 46.4000, CAST(N'2024-03-15' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (3, 1, 1, 3, 2, 290.0000, 460.0000, 73.6000, CAST(N'2024-04-15' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (4, 1, 2, 4, 1, 0.0000, 160.0000, 25.6000, CAST(N'2024-02-20' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (5, 1, 2, 5, 4, 160.0000, 320.0000, 51.2000, CAST(N'2024-03-20' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (6, 1, 2, 6, 2, 320.0000, 470.0000, 75.2000, CAST(N'2024-04-20' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (7, 1, 3, 7, 1, 0.0000, 140.0000, 22.4000, CAST(N'2024-03-01' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (8, 1, 3, 8, 4, 140.0000, 310.0000, 49.6000, CAST(N'2024-04-01' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (9, 1, 3, 9, 2, 310.0000, 480.0000, 76.8000, CAST(N'2024-05-01' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (10, 1, 4, 10, 1, 0.0000, 180.0000, 28.8000, CAST(N'2024-03-15' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (11, 1, 4, 11, 4, 180.0000, 350.0000, 56.0000, CAST(N'2024-04-15' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (12, 1, 4, 12, 2, 350.0000, 520.0000, 83.2000, CAST(N'2024-05-15' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (13, 1, 5, 13, 1, 0.0000, 150.0000, 24.0000, CAST(N'2024-03-01' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (14, 1, 5, 14, 4, 150.0000, 320.0000, 51.2000, CAST(N'2024-04-01' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (15, 1, 5, 15, 2, 320.0000, 470.0000, 75.2000, CAST(N'2024-05-01' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (16, 1, 6, 16, 1, 0.0000, 450.0000, 72.0000, CAST(N'2024-02-10' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (17, 1, 6, 17, 4, 450.0000, 930.0000, 148.8000, CAST(N'2024-03-10' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (18, 1, 6, 18, 2, 930.0000, 1420.0000, 227.2000, CAST(N'2024-04-10' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (19, 1, 7, 19, 1, 0.0000, 520.0000, 83.2000, CAST(N'2024-02-25' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (20, 1, 7, 20, 4, 520.0000, 1010.0000, 161.6000, CAST(N'2024-03-25' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (21, 1, 7, 21, 2, 1010.0000, 1540.0000, 246.4000, CAST(N'2024-04-25' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (22, 1, 8, 22, 1, 0.0000, 490.0000, 78.4000, CAST(N'2024-03-05' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (23, 1, 8, 23, 4, 490.0000, 970.0000, 155.2000, CAST(N'2024-04-05' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (24, 1, 8, 24, 2, 970.0000, 1470.0000, 235.2000, CAST(N'2024-05-05' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (25, 1, 9, 25, 1, 0.0000, 540.0000, 86.4000, CAST(N'2024-03-20' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (26, 1, 9, 26, 4, 540.0000, 1040.0000, 166.4000, CAST(N'2024-04-20' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (27, 1, 9, 27, 2, 1040.0000, 1570.0000, 251.2000, CAST(N'2024-05-20' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (28, 1, 10, 28, 1, 0.0000, 480.0000, 76.8000, CAST(N'2024-03-05' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (29, 1, 10, 29, 4, 480.0000, 980.0000, 156.8000, CAST(N'2024-04-05' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (30, 1, 10, 30, 2, 980.0000, 1480.0000, 236.8000, CAST(N'2024-05-05' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (31, 1, 1, 1, 1, 0.0000, 150.0000, 24.0000, CAST(N'2024-02-15' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (32, 1, 1, 2, 4, 150.0000, 290.0000, 46.4000, CAST(N'2024-03-15' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (33, 1, 1, 3, 2, 290.0000, 460.0000, 73.6000, CAST(N'2024-04-15' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (34, 1, 2, 4, 1, 0.0000, 160.0000, 25.6000, CAST(N'2024-02-20' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (35, 1, 2, 5, 4, 160.0000, 320.0000, 51.2000, CAST(N'2024-03-20' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (36, 1, 2, 6, 2, 320.0000, 470.0000, 75.2000, CAST(N'2024-04-20' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (37, 1, 3, 7, 1, 0.0000, 140.0000, 22.4000, CAST(N'2024-03-01' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (38, 1, 3, 8, 4, 140.0000, 310.0000, 49.6000, CAST(N'2024-04-01' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (39, 1, 3, 9, 2, 310.0000, 480.0000, 76.8000, CAST(N'2024-05-01' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (40, 1, 4, 10, 1, 0.0000, 180.0000, 28.8000, CAST(N'2024-03-15' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (41, 1, 4, 11, 4, 180.0000, 350.0000, 56.0000, CAST(N'2024-04-15' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (42, 1, 4, 12, 2, 350.0000, 520.0000, 83.2000, CAST(N'2024-05-15' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (43, 1, 5, 13, 1, 0.0000, 150.0000, 24.0000, CAST(N'2024-03-01' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (44, 1, 5, 14, 4, 150.0000, 320.0000, 51.2000, CAST(N'2024-04-01' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (45, 1, 5, 15, 2, 320.0000, 470.0000, 75.2000, CAST(N'2024-05-01' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (46, 1, 6, 16, 1, 0.0000, 450.0000, 72.0000, CAST(N'2024-02-10' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (47, 1, 6, 17, 4, 450.0000, 930.0000, 148.8000, CAST(N'2024-03-10' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (48, 1, 6, 18, 2, 930.0000, 1420.0000, 227.2000, CAST(N'2024-04-10' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (49, 1, 7, 19, 1, 0.0000, 520.0000, 83.2000, CAST(N'2024-02-25' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (50, 1, 7, 20, 4, 520.0000, 1010.0000, 161.6000, CAST(N'2024-03-25' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (51, 1, 7, 21, 2, 1010.0000, 1540.0000, 246.4000, CAST(N'2024-04-25' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (52, 1, 8, 22, 1, 0.0000, 490.0000, 78.4000, CAST(N'2024-03-05' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (53, 1, 8, 23, 4, 490.0000, 970.0000, 155.2000, CAST(N'2024-04-05' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (54, 1, 8, 24, 2, 970.0000, 1470.0000, 235.2000, CAST(N'2024-05-05' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (55, 1, 9, 25, 1, 0.0000, 540.0000, 86.4000, CAST(N'2024-03-20' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (56, 1, 9, 26, 4, 540.0000, 1040.0000, 166.4000, CAST(N'2024-04-20' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (57, 1, 9, 27, 2, 1040.0000, 1570.0000, 251.2000, CAST(N'2024-05-20' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (58, 1, 10, 28, 1, 0.0000, 480.0000, 76.8000, CAST(N'2024-03-05' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (59, 1, 10, 29, 4, 480.0000, 980.0000, 156.8000, CAST(N'2024-04-05' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Adeudos] ([AdeudoId], [EstablecimientoId], [ClienteId], [ConsumoId], [CargoId], [adeudo_anterior], [adeudo_actual], [IVA], [fecha_vencimiento], [fecha_mod]) VALUES (60, 1, 10, 30, 2, 980.0000, 1480.0000, 236.8000, CAST(N'2024-05-05' AS Date), CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Clientes].[Adeudos] OFF
GO
SET IDENTITY_INSERT [Clientes].[CargoServicio] ON
GO
INSERT [Clientes].[CargoServicio] ([CargoId], [descripcion], [monto], [fecha_mod]) VALUES (1, N'Reconexión', 500.0000, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[CargoServicio] ([CargoId], [descripcion], [monto], [fecha_mod]) VALUES (2, N'Cargo por pago tardío', 200.0000, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[CargoServicio] ([CargoId], [descripcion], [monto], [fecha_mod]) VALUES (3, N'Instalación medidor', 1000.0000, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[CargoServicio] ([CargoId], [descripcion], [monto], [fecha_mod]) VALUES (4, N'Mantenimiento red', 150.0000, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[CargoServicio] ([CargoId], [descripcion], [monto], [fecha_mod]) VALUES (5, N'Verificación medidor', 300.0000, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[CargoServicio] ([CargoId], [descripcion], [monto], [fecha_mod]) VALUES (6, N'Reconexión', 500.0000, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[CargoServicio] ([CargoId], [descripcion], [monto], [fecha_mod]) VALUES (7, N'Cargo por pago tardío', 200.0000, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[CargoServicio] ([CargoId], [descripcion], [monto], [fecha_mod]) VALUES (8, N'Instalación medidor', 1000.0000, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[CargoServicio] ([CargoId], [descripcion], [monto], [fecha_mod]) VALUES (9, N'Mantenimiento red', 150.0000, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[CargoServicio] ([CargoId], [descripcion], [monto], [fecha_mod]) VALUES (10, N'Verificación medidor', 300.0000, CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Clientes].[CargoServicio] OFF
GO
SET IDENTITY_INSERT [Clientes].[Cliente] ON
GO
INSERT [Clientes].[Cliente] ([ClienteId], [PersonaId], [fecha_corte], [ContratoId], [actividad], [fecha_mod]) VALUES (1, 1, CAST(N'2024-04-15' AS Date), 1, N'A', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Cliente] ([ClienteId], [PersonaId], [fecha_corte], [ContratoId], [actividad], [fecha_mod]) VALUES (2, 2, CAST(N'2024-04-20' AS Date), 2, N'A', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Cliente] ([ClienteId], [PersonaId], [fecha_corte], [ContratoId], [actividad], [fecha_mod]) VALUES (3, 3, CAST(N'2024-05-01' AS Date), 3, N'A', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Cliente] ([ClienteId], [PersonaId], [fecha_corte], [ContratoId], [actividad], [fecha_mod]) VALUES (4, 4, CAST(N'2024-05-15' AS Date), 4, N'A', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Cliente] ([ClienteId], [PersonaId], [fecha_corte], [ContratoId], [actividad], [fecha_mod]) VALUES (5, 5, CAST(N'2024-06-01' AS Date), 5, N'A', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Cliente] ([ClienteId], [PersonaId], [fecha_corte], [ContratoId], [actividad], [fecha_mod]) VALUES (6, 16, CAST(N'2024-04-10' AS Date), 6, N'A', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Cliente] ([ClienteId], [PersonaId], [fecha_corte], [ContratoId], [actividad], [fecha_mod]) VALUES (7, 17, CAST(N'2024-04-25' AS Date), 7, N'A', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Cliente] ([ClienteId], [PersonaId], [fecha_corte], [ContratoId], [actividad], [fecha_mod]) VALUES (8, 18, CAST(N'2024-05-05' AS Date), 8, N'A', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Cliente] ([ClienteId], [PersonaId], [fecha_corte], [ContratoId], [actividad], [fecha_mod]) VALUES (9, 19, CAST(N'2024-05-20' AS Date), 9, N'A', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Cliente] ([ClienteId], [PersonaId], [fecha_corte], [ContratoId], [actividad], [fecha_mod]) VALUES (10, 20, CAST(N'2024-06-05' AS Date), 10, N'A', CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Clientes].[Cliente] OFF
GO
SET IDENTITY_INSERT [Clientes].[Consumo] ON
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (1, 0.0000, 8.0000, 8, 150.0000, CAST(N'2024-01-31' AS Date), 17, 16, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (2, 8.0000, 15.0000, 7, 140.0000, CAST(N'2024-02-29' AS Date), 17, 17, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (3, 15.0000, 24.0000, 9, 170.0000, CAST(N'2024-03-31' AS Date), 17, 15, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (4, 0.0000, 9.0000, 9, 160.0000, CAST(N'2024-01-31' AS Date), 17, 22, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (5, 9.0000, 18.0000, 9, 160.0000, CAST(N'2024-02-29' AS Date), 17, 6, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (6, 18.0000, 26.0000, 8, 150.0000, CAST(N'2024-03-31' AS Date), 17, 7, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (7, 0.0000, 7.0000, 7, 140.0000, CAST(N'2024-01-31' AS Date), 17, 8, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (8, 7.0000, 16.0000, 9, 170.0000, CAST(N'2024-02-29' AS Date), 17, 9, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (9, 16.0000, 25.0000, 9, 170.0000, CAST(N'2024-03-31' AS Date), 17, 5, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (10, 0.0000, 10.0000, 10, 180.0000, CAST(N'2024-01-31' AS Date), 17, 15, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (11, 10.0000, 19.0000, 9, 170.0000, CAST(N'2024-02-29' AS Date), 17, 12, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (12, 19.0000, 28.0000, 9, 170.0000, CAST(N'2024-03-31' AS Date), 17, 16, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (13, 0.0000, 8.0000, 8, 150.0000, CAST(N'2024-01-31' AS Date), 18, 19, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (14, 8.0000, 17.0000, 9, 170.0000, CAST(N'2024-02-29' AS Date), 15, 18, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (15, 17.0000, 25.0000, 8, 150.0000, CAST(N'2024-03-31' AS Date), 17, 17, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (16, 0.0000, 25.0000, 25, 450.0000, CAST(N'2024-01-31' AS Date), 16, 15, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (17, 25.0000, 52.0000, 27, 480.0000, CAST(N'2024-02-29' AS Date), 17, 14, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (18, 52.0000, 80.0000, 28, 490.0000, CAST(N'2024-03-31' AS Date), 19, 16, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (19, 0.0000, 30.0000, 30, 520.0000, CAST(N'2024-01-31' AS Date), 22, 15, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (20, 30.0000, 58.0000, 28, 490.0000, CAST(N'2024-02-29' AS Date), 14, 19, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (21, 58.0000, 89.0000, 31, 530.0000, CAST(N'2024-03-31' AS Date), 13, 18, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (22, 0.0000, 28.0000, 28, 490.0000, CAST(N'2024-01-31' AS Date), 11, 17, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (23, 28.0000, 55.0000, 27, 480.0000, CAST(N'2024-02-29' AS Date), 22, 19, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (24, 55.0000, 84.0000, 29, 500.0000, CAST(N'2024-03-31' AS Date), 11, 15, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (25, 0.0000, 32.0000, 32, 540.0000, CAST(N'2024-01-31' AS Date), 15, 13, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (26, 32.0000, 61.0000, 29, 500.0000, CAST(N'2024-02-29' AS Date), 17, 18, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (27, 61.0000, 92.0000, 31, 530.0000, CAST(N'2024-03-31' AS Date), 16, 15, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (28, 0.0000, 27.0000, 27, 480.0000, CAST(N'2024-01-31' AS Date), 13, 16, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (29, 27.0000, 56.0000, 29, 500.0000, CAST(N'2024-02-29' AS Date), 19, 19, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (30, 56.0000, 85.0000, 29, 500.0000, CAST(N'2024-03-31' AS Date), 25, 17, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (31, 0.0000, 8.0000, 8, 150.0000, CAST(N'2024-01-31' AS Date), 13, 16, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (32, 8.0000, 15.0000, 7, 140.0000, CAST(N'2024-02-29' AS Date), 14, 15, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (33, 15.0000, 24.0000, 9, 170.0000, CAST(N'2024-03-31' AS Date), 19, 14, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (34, 0.0000, 9.0000, 9, 160.0000, CAST(N'2024-01-31' AS Date), 16, 16, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (35, 9.0000, 18.0000, 9, 160.0000, CAST(N'2024-02-29' AS Date), 15, 16, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (36, 18.0000, 26.0000, 8, 150.0000, CAST(N'2024-03-31' AS Date), 25, 15, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (37, 0.0000, 7.0000, 7, 140.0000, CAST(N'2024-01-31' AS Date), 6, 19, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (38, 7.0000, 16.0000, 9, 170.0000, CAST(N'2024-02-29' AS Date), 3, 15, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (39, 16.0000, 25.0000, 9, 170.0000, CAST(N'2024-03-31' AS Date), 5, 16, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (40, 0.0000, 10.0000, 10, 180.0000, CAST(N'2024-01-31' AS Date), 9, 16, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (41, 10.0000, 19.0000, 9, 170.0000, CAST(N'2024-02-29' AS Date), 8, 18, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (42, 19.0000, 28.0000, 9, 170.0000, CAST(N'2024-03-31' AS Date), 8, 17, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (43, 0.0000, 8.0000, 8, 150.0000, CAST(N'2024-01-31' AS Date), 8, 16, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (44, 8.0000, 17.0000, 9, 170.0000, CAST(N'2024-02-29' AS Date), 8, 13, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (45, 17.0000, 25.0000, 8, 150.0000, CAST(N'2024-03-31' AS Date), 2, 22, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (46, 0.0000, 25.0000, 25, 450.0000, CAST(N'2024-01-31' AS Date), 1, 21, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (47, 25.0000, 52.0000, 27, 480.0000, CAST(N'2024-02-29' AS Date), 7, 23, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (48, 52.0000, 80.0000, 28, 490.0000, CAST(N'2024-03-31' AS Date), 8, 26, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (49, 0.0000, 30.0000, 30, 520.0000, CAST(N'2024-01-31' AS Date), 9, 15, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (50, 30.0000, 58.0000, 28, 490.0000, CAST(N'2024-02-29' AS Date), 11, 17, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (51, 58.0000, 89.0000, 31, 530.0000, CAST(N'2024-03-31' AS Date), 15, 16, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (52, 0.0000, 28.0000, 28, 490.0000, CAST(N'2024-01-31' AS Date), 22, 18, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (53, 28.0000, 55.0000, 27, 480.0000, CAST(N'2024-02-29' AS Date), 14, 15, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (54, 55.0000, 84.0000, 29, 500.0000, CAST(N'2024-03-31' AS Date), 16, 19, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (55, 0.0000, 32.0000, 32, 540.0000, CAST(N'2024-01-31' AS Date), 19, 17, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (56, 32.0000, 61.0000, 29, 500.0000, CAST(N'2024-02-29' AS Date), 18, 14, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (57, 61.0000, 92.0000, 31, 530.0000, CAST(N'2024-03-31' AS Date), 17, 12, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (58, 0.0000, 27.0000, 27, 480.0000, CAST(N'2024-01-31' AS Date), 17, 16, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (59, 27.0000, 56.0000, 29, 500.0000, CAST(N'2024-02-29' AS Date), 13, 17, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Consumo] ([ConsumoId], [lectura_anterior], [lectura_actual], [consumo_m3], [facturado_m3], [periodo_lectura], [costo_saneamiento], [costo_drenaje], [fecha_mod]) VALUES (60, 56.0000, 85.0000, 29, 500.0000, CAST(N'2024-03-31' AS Date), 15, 11, CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Clientes].[Consumo] OFF
GO
SET IDENTITY_INSERT [Clientes].[Contrato] ON
GO
INSERT [Clientes].[Contrato] ([ContratoId], [fecha_contrato], [enlace_documento], [TipoTarifaId], [medidor], [fecha_mod]) VALUES (1, CAST(N'2024-01-15' AS Date), N'contratos/dom/2024/001.pdf', 1, N'DOM001202401', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Contrato] ([ContratoId], [fecha_contrato], [enlace_documento], [TipoTarifaId], [medidor], [fecha_mod]) VALUES (2, CAST(N'2024-01-20' AS Date), N'contratos/dom/2024/002.pdf', 1, N'DOM002202401', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Contrato] ([ContratoId], [fecha_contrato], [enlace_documento], [TipoTarifaId], [medidor], [fecha_mod]) VALUES (3, CAST(N'2024-02-01' AS Date), N'contratos/dom/2024/003.pdf', 1, N'DOM003202402', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Contrato] ([ContratoId], [fecha_contrato], [enlace_documento], [TipoTarifaId], [medidor], [fecha_mod]) VALUES (4, CAST(N'2024-02-15' AS Date), N'contratos/dom/2024/004.pdf', 1, N'DOM004202402', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Contrato] ([ContratoId], [fecha_contrato], [enlace_documento], [TipoTarifaId], [medidor], [fecha_mod]) VALUES (5, CAST(N'2024-03-01' AS Date), N'contratos/dom/2024/005.pdf', 1, N'DOM005202403', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Contrato] ([ContratoId], [fecha_contrato], [enlace_documento], [TipoTarifaId], [medidor], [fecha_mod]) VALUES (6, CAST(N'2024-01-10' AS Date), N'contratos/com/2024/001.pdf', 2, N'COM001202401', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Contrato] ([ContratoId], [fecha_contrato], [enlace_documento], [TipoTarifaId], [medidor], [fecha_mod]) VALUES (7, CAST(N'2024-01-25' AS Date), N'contratos/com/2024/002.pdf', 2, N'COM002202401', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Contrato] ([ContratoId], [fecha_contrato], [enlace_documento], [TipoTarifaId], [medidor], [fecha_mod]) VALUES (8, CAST(N'2024-02-05' AS Date), N'contratos/com/2024/003.pdf', 2, N'COM003202402', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Contrato] ([ContratoId], [fecha_contrato], [enlace_documento], [TipoTarifaId], [medidor], [fecha_mod]) VALUES (9, CAST(N'2024-02-20' AS Date), N'contratos/com/2024/004.pdf', 2, N'COM004202402', CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Contrato] ([ContratoId], [fecha_contrato], [enlace_documento], [TipoTarifaId], [medidor], [fecha_mod]) VALUES (10, CAST(N'2024-03-05' AS Date), N'contratos/com/2024/005.pdf', 2, N'COM005202403', CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Clientes].[Contrato] OFF
GO
SET IDENTITY_INSERT [Clientes].[EstatusPago] ON
GO
INSERT [Clientes].[EstatusPago] ([EstatusId], [nombre], [descripcion], [fecha_mod]) VALUES (1, N'Pendiente', N'El pago está pendiente de procesamiento', CAST(N'2025-05-31T00:23:37.577' AS DateTime))
GO
INSERT [Clientes].[EstatusPago] ([EstatusId], [nombre], [descripcion], [fecha_mod]) VALUES (2, N'Procesando', N'El pago está siendo procesado', CAST(N'2025-05-31T00:23:37.577' AS DateTime))
GO
INSERT [Clientes].[EstatusPago] ([EstatusId], [nombre], [descripcion], [fecha_mod]) VALUES (3, N'Completado', N'El pago ha sido completado y aplicado', CAST(N'2025-05-31T00:23:37.577' AS DateTime))
GO
INSERT [Clientes].[EstatusPago] ([EstatusId], [nombre], [descripcion], [fecha_mod]) VALUES (4, N'Rechazado', N'El pago fue rechazado por la entidad financiera', CAST(N'2025-05-31T00:23:37.577' AS DateTime))
GO
INSERT [Clientes].[EstatusPago] ([EstatusId], [nombre], [descripcion], [fecha_mod]) VALUES (5, N'Cancelado', N'El pago fue cancelado por el usuario o administrador', CAST(N'2025-05-31T00:23:37.577' AS DateTime))
GO
INSERT [Clientes].[EstatusPago] ([EstatusId], [nombre], [descripcion], [fecha_mod]) VALUES (6, N'Reembolsado', N'El monto del pago fue devuelto al cliente', CAST(N'2025-05-31T00:23:37.577' AS DateTime))
GO
SET IDENTITY_INSERT [Clientes].[EstatusPago] OFF
GO
SET IDENTITY_INSERT [Clientes].[MetodoPago] ON
GO
INSERT [Clientes].[MetodoPago] ([MetodoPagoId], [nombre], [descripcion], [activo], [requiere_comprobante], [fecha_mod]) VALUES (1, N'Efectivo', N'Pago en efectivo en cajas', 1, 0, CAST(N'2025-05-31T00:23:37.580' AS DateTime))
GO
INSERT [Clientes].[MetodoPago] ([MetodoPagoId], [nombre], [descripcion], [activo], [requiere_comprobante], [fecha_mod]) VALUES (2, N'Tarjeta de crédito/débito', N'Pago con tarjeta en terminal', 1, 1, CAST(N'2025-05-31T00:23:37.580' AS DateTime))
GO
INSERT [Clientes].[MetodoPago] ([MetodoPagoId], [nombre], [descripcion], [activo], [requiere_comprobante], [fecha_mod]) VALUES (3, N'Transferencia bancaria', N'Pago por transferencia electrónica', 1, 1, CAST(N'2025-05-31T00:23:37.580' AS DateTime))
GO
INSERT [Clientes].[MetodoPago] ([MetodoPagoId], [nombre], [descripcion], [activo], [requiere_comprobante], [fecha_mod]) VALUES (4, N'Depósito bancario', N'Pago por depósito en banco', 1, 1, CAST(N'2025-05-31T00:23:37.580' AS DateTime))
GO
INSERT [Clientes].[MetodoPago] ([MetodoPagoId], [nombre], [descripcion], [activo], [requiere_comprobante], [fecha_mod]) VALUES (5, N'Pago en línea', N'Pago a través del portal web', 1, 0, CAST(N'2025-05-31T00:23:37.580' AS DateTime))
GO
INSERT [Clientes].[MetodoPago] ([MetodoPagoId], [nombre], [descripcion], [activo], [requiere_comprobante], [fecha_mod]) VALUES (6, N'Cheque', N'Pago con cheque', 1, 1, CAST(N'2025-05-31T00:23:37.580' AS DateTime))
GO
SET IDENTITY_INSERT [Clientes].[MetodoPago] OFF
GO
SET IDENTITY_INSERT [Clientes].[Tarifa] ON
GO
INSERT [Clientes].[Tarifa] ([TarifaId], [precio_base], [base_agua], [base_drenaje], [base_saneamiento], [max_m3], [fecha_mod]) VALUES (1, 150.0000, 80.0000, 40.0000, 30.0000, 10, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[Tarifa] ([TarifaId], [precio_base], [base_agua], [base_drenaje], [base_saneamiento], [max_m3], [fecha_mod]) VALUES (2, 300.0000, 160.0000, 80.0000, 60.0000, 20, CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Clientes].[Tarifa] OFF
GO
SET IDENTITY_INSERT [Clientes].[TipoTarifa] ON
GO
INSERT [Clientes].[TipoTarifa] ([TipoTarifaId], [nombre], [TarifaId], [fecha_mod]) VALUES (1, N'Doméstica', 1, CAST(N'2025-04-28' AS Date))
GO
INSERT [Clientes].[TipoTarifa] ([TipoTarifaId], [nombre], [TarifaId], [fecha_mod]) VALUES (2, N'Comercial', 2, CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Clientes].[TipoTarifa] OFF
GO
SET IDENTITY_INSERT [Inventarios].[Inventario] ON
GO
INSERT [Inventarios].[Inventario] ([ProductoId], [MaterialId], [MobiliarioId], [VehiculoId], [cantidad], [fecha_mod]) VALUES (1, 1, NULL, NULL, 100, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Inventario] ([ProductoId], [MaterialId], [MobiliarioId], [VehiculoId], [cantidad], [fecha_mod]) VALUES (2, 2, NULL, NULL, 500, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Inventario] ([ProductoId], [MaterialId], [MobiliarioId], [VehiculoId], [cantidad], [fecha_mod]) VALUES (3, 3, NULL, NULL, 20, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Inventario] ([ProductoId], [MaterialId], [MobiliarioId], [VehiculoId], [cantidad], [fecha_mod]) VALUES (4, 4, NULL, NULL, 200, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Inventario] ([ProductoId], [MaterialId], [MobiliarioId], [VehiculoId], [cantidad], [fecha_mod]) VALUES (5, 5, NULL, NULL, 50, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Inventario] ([ProductoId], [MaterialId], [MobiliarioId], [VehiculoId], [cantidad], [fecha_mod]) VALUES (6, NULL, 1, NULL, 10, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Inventario] ([ProductoId], [MaterialId], [MobiliarioId], [VehiculoId], [cantidad], [fecha_mod]) VALUES (7, NULL, 2, NULL, 30, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Inventario] ([ProductoId], [MaterialId], [MobiliarioId], [VehiculoId], [cantidad], [fecha_mod]) VALUES (8, NULL, 3, NULL, 15, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Inventario] ([ProductoId], [MaterialId], [MobiliarioId], [VehiculoId], [cantidad], [fecha_mod]) VALUES (9, NULL, NULL, 1, 1, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Inventario] ([ProductoId], [MaterialId], [MobiliarioId], [VehiculoId], [cantidad], [fecha_mod]) VALUES (10, NULL, NULL, 2, 1, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
SET IDENTITY_INSERT [Inventarios].[Inventario] OFF
GO
SET IDENTITY_INSERT [Inventarios].[Material] ON
GO
INSERT [Inventarios].[Material] ([MaterialId], [nombre], [descripcion], [actividad], [TipoMaterialId], [fecha_mod]) VALUES (1, N'Tubo PVC 4"', N'Tubo PVC hidráulico', N'A', 1, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[Material] ([MaterialId], [nombre], [descripcion], [actividad], [TipoMaterialId], [fecha_mod]) VALUES (2, N'Cable 12AWG', N'Cable eléctrico negro', N'A', 2, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[Material] ([MaterialId], [nombre], [descripcion], [actividad], [TipoMaterialId], [fecha_mod]) VALUES (3, N'Martillo', N'Martillo de bola 2lb', N'A', 3, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[Material] ([MaterialId], [nombre], [descripcion], [actividad], [TipoMaterialId], [fecha_mod]) VALUES (4, N'Cemento', N'Cemento gris 50kg', N'A', 4, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[Material] ([MaterialId], [nombre], [descripcion], [actividad], [TipoMaterialId], [fecha_mod]) VALUES (5, N'Válvula 2"', N'Válvula de compuerta', N'A', 5, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[Material] ([MaterialId], [nombre], [descripcion], [actividad], [TipoMaterialId], [fecha_mod]) VALUES (6, N'Medidor 1/2"', N'Medidor doméstico', N'A', 6, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[Material] ([MaterialId], [nombre], [descripcion], [actividad], [TipoMaterialId], [fecha_mod]) VALUES (7, N'Codo 90° 3"', N'Codo PVC hidráulico', N'A', 7, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[Material] ([MaterialId], [nombre], [descripcion], [actividad], [TipoMaterialId], [fecha_mod]) VALUES (8, N'Papel', N'Papel bond carta', N'A', 8, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[Material] ([MaterialId], [nombre], [descripcion], [actividad], [TipoMaterialId], [fecha_mod]) VALUES (9, N'Cloro', N'Hipoclorito de sodio', N'A', 9, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[Material] ([MaterialId], [nombre], [descripcion], [actividad], [TipoMaterialId], [fecha_mod]) VALUES (10, N'Bomba 5HP', N'Bomba sumergible', N'A', 10, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
SET IDENTITY_INSERT [Inventarios].[Material] OFF
GO
SET IDENTITY_INSERT [Inventarios].[Mobiliario] ON
GO
INSERT [Inventarios].[Mobiliario] ([MobiliarioId], [nombre], [descripcion], [actividad], [TipoMobiliarioId], [fecha_mod]) VALUES (1, N'Escritorio Ejecutivo', N'Escritorio en L con cajones', N'A', 1, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Mobiliario] ([MobiliarioId], [nombre], [descripcion], [actividad], [TipoMobiliarioId], [fecha_mod]) VALUES (2, N'Silla Ergonómica', N'Silla giratoria con brazos', N'A', 2, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Mobiliario] ([MobiliarioId], [nombre], [descripcion], [actividad], [TipoMobiliarioId], [fecha_mod]) VALUES (3, N'Archivero 4G', N'Archivero metálico 4 gavetas', N'A', 3, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Mobiliario] ([MobiliarioId], [nombre], [descripcion], [actividad], [TipoMobiliarioId], [fecha_mod]) VALUES (4, N'Mesa Juntas', N'Mesa sala juntas 8 personas', N'A', 4, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Mobiliario] ([MobiliarioId], [nombre], [descripcion], [actividad], [TipoMobiliarioId], [fecha_mod]) VALUES (5, N'Gabinete Metal', N'Gabinete herramientas', N'A', 5, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Mobiliario] ([MobiliarioId], [nombre], [descripcion], [actividad], [TipoMobiliarioId], [fecha_mod]) VALUES (6, N'Estante Industrial', N'Estante almacén 5 niveles', N'A', 6, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Mobiliario] ([MobiliarioId], [nombre], [descripcion], [actividad], [TipoMobiliarioId], [fecha_mod]) VALUES (7, N'Mostrador Atención', N'Mostrador recepción', N'A', 7, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Mobiliario] ([MobiliarioId], [nombre], [descripcion], [actividad], [TipoMobiliarioId], [fecha_mod]) VALUES (8, N'Locker 6P', N'Locker 6 puertas personal', N'A', 8, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Mobiliario] ([MobiliarioId], [nombre], [descripcion], [actividad], [TipoMobiliarioId], [fecha_mod]) VALUES (9, N'Banco Trabajo', N'Banco taller alto', N'A', 9, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Mobiliario] ([MobiliarioId], [nombre], [descripcion], [actividad], [TipoMobiliarioId], [fecha_mod]) VALUES (10, N'Librero Oficina', N'Librero 5 repisas', N'A', 10, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
SET IDENTITY_INSERT [Inventarios].[Mobiliario] OFF
GO
SET IDENTITY_INSERT [Inventarios].[Proveedor] ON
GO
INSERT [Inventarios].[Proveedor] ([ProveedorId], [PersonaId], [fecha_mod]) VALUES (1, 16, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Proveedor] ([ProveedorId], [PersonaId], [fecha_mod]) VALUES (2, 17, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Proveedor] ([ProveedorId], [PersonaId], [fecha_mod]) VALUES (3, 18, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Proveedor] ([ProveedorId], [PersonaId], [fecha_mod]) VALUES (4, 19, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Proveedor] ([ProveedorId], [PersonaId], [fecha_mod]) VALUES (5, 20, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Proveedor] ([ProveedorId], [PersonaId], [fecha_mod]) VALUES (6, 21, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Proveedor] ([ProveedorId], [PersonaId], [fecha_mod]) VALUES (7, 22, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Proveedor] ([ProveedorId], [PersonaId], [fecha_mod]) VALUES (8, 23, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Proveedor] ([ProveedorId], [PersonaId], [fecha_mod]) VALUES (9, 24, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Proveedor] ([ProveedorId], [PersonaId], [fecha_mod]) VALUES (10, 25, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
SET IDENTITY_INSERT [Inventarios].[Proveedor] OFF
GO
SET IDENTITY_INSERT [Inventarios].[ReporteVehiculo] ON
GO
INSERT [Inventarios].[ReporteVehiculo] ([ReporteId], [VehiculoId], [TallerId], [descripcion], [fecha_reporte], [fecha_mod]) VALUES (1, 1, 1, N'Mantenimiento preventivo', CAST(N'2024-03-01T00:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[ReporteVehiculo] ([ReporteId], [VehiculoId], [TallerId], [descripcion], [fecha_reporte], [fecha_mod]) VALUES (2, 2, 2, N'Cambio de aceite', CAST(N'2024-03-02T00:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[ReporteVehiculo] ([ReporteId], [VehiculoId], [TallerId], [descripcion], [fecha_reporte], [fecha_mod]) VALUES (3, 3, 3, N'Reparación frenos', CAST(N'2024-03-03T00:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[ReporteVehiculo] ([ReporteId], [VehiculoId], [TallerId], [descripcion], [fecha_reporte], [fecha_mod]) VALUES (4, 4, 4, N'Revisión general', CAST(N'2024-03-04T00:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[ReporteVehiculo] ([ReporteId], [VehiculoId], [TallerId], [descripcion], [fecha_reporte], [fecha_mod]) VALUES (5, 5, 5, N'Cambio llantas', CAST(N'2024-03-05T00:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[ReporteVehiculo] ([ReporteId], [VehiculoId], [TallerId], [descripcion], [fecha_reporte], [fecha_mod]) VALUES (6, 6, 6, N'Alineación y balanceo', CAST(N'2024-03-06T00:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[ReporteVehiculo] ([ReporteId], [VehiculoId], [TallerId], [descripcion], [fecha_reporte], [fecha_mod]) VALUES (7, 7, 7, N'Reparación suspensión', CAST(N'2024-03-07T00:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[ReporteVehiculo] ([ReporteId], [VehiculoId], [TallerId], [descripcion], [fecha_reporte], [fecha_mod]) VALUES (8, 8, 8, N'Diagnóstico motor', CAST(N'2024-03-08T00:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[ReporteVehiculo] ([ReporteId], [VehiculoId], [TallerId], [descripcion], [fecha_reporte], [fecha_mod]) VALUES (9, 9, 9, N'Servicio completo', CAST(N'2024-03-09T00:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[ReporteVehiculo] ([ReporteId], [VehiculoId], [TallerId], [descripcion], [fecha_reporte], [fecha_mod]) VALUES (10, 10, 10, N'Reparación sistema hidráulico', CAST(N'2024-03-10T00:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
SET IDENTITY_INSERT [Inventarios].[ReporteVehiculo] OFF
GO
SET IDENTITY_INSERT [Inventarios].[TallerVehiculo] ON
GO
INSERT [Inventarios].[TallerVehiculo] ([TallerId], [PersonaId], [fecha_mod]) VALUES (1, 1, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TallerVehiculo] ([TallerId], [PersonaId], [fecha_mod]) VALUES (2, 2, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TallerVehiculo] ([TallerId], [PersonaId], [fecha_mod]) VALUES (3, 3, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TallerVehiculo] ([TallerId], [PersonaId], [fecha_mod]) VALUES (4, 4, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TallerVehiculo] ([TallerId], [PersonaId], [fecha_mod]) VALUES (5, 5, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TallerVehiculo] ([TallerId], [PersonaId], [fecha_mod]) VALUES (6, 6, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TallerVehiculo] ([TallerId], [PersonaId], [fecha_mod]) VALUES (7, 7, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TallerVehiculo] ([TallerId], [PersonaId], [fecha_mod]) VALUES (8, 8, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TallerVehiculo] ([TallerId], [PersonaId], [fecha_mod]) VALUES (9, 9, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TallerVehiculo] ([TallerId], [PersonaId], [fecha_mod]) VALUES (10, 10, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
SET IDENTITY_INSERT [Inventarios].[TallerVehiculo] OFF
GO
SET IDENTITY_INSERT [Inventarios].[TipoMaterial] ON
GO
INSERT [Inventarios].[TipoMaterial] ([TipoMaterialId], [descripcion], [fecha_mod]) VALUES (1, N'Tubería PVC', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMaterial] ([TipoMaterialId], [descripcion], [fecha_mod]) VALUES (2, N'Material Eléctrico', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMaterial] ([TipoMaterialId], [descripcion], [fecha_mod]) VALUES (3, N'Herramientas', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMaterial] ([TipoMaterialId], [descripcion], [fecha_mod]) VALUES (4, N'Material de Construcción', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMaterial] ([TipoMaterialId], [descripcion], [fecha_mod]) VALUES (5, N'Válvulas', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMaterial] ([TipoMaterialId], [descripcion], [fecha_mod]) VALUES (6, N'Medidores', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMaterial] ([TipoMaterialId], [descripcion], [fecha_mod]) VALUES (7, N'Conexiones', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMaterial] ([TipoMaterialId], [descripcion], [fecha_mod]) VALUES (8, N'Material de Oficina', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMaterial] ([TipoMaterialId], [descripcion], [fecha_mod]) VALUES (9, N'Químicos para Tratamiento', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMaterial] ([TipoMaterialId], [descripcion], [fecha_mod]) VALUES (10, N'Repuestos', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
SET IDENTITY_INSERT [Inventarios].[TipoMaterial] OFF
GO
SET IDENTITY_INSERT [Inventarios].[TipoMobiliario] ON
GO
INSERT [Inventarios].[TipoMobiliario] ([TipoMobiliarioId], [descripcion], [fecha_mod]) VALUES (1, N'Escritorio', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMobiliario] ([TipoMobiliarioId], [descripcion], [fecha_mod]) VALUES (2, N'Silla', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMobiliario] ([TipoMobiliarioId], [descripcion], [fecha_mod]) VALUES (3, N'Archivero', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMobiliario] ([TipoMobiliarioId], [descripcion], [fecha_mod]) VALUES (4, N'Mesa', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMobiliario] ([TipoMobiliarioId], [descripcion], [fecha_mod]) VALUES (5, N'Gabinete', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMobiliario] ([TipoMobiliarioId], [descripcion], [fecha_mod]) VALUES (6, N'Estante', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMobiliario] ([TipoMobiliarioId], [descripcion], [fecha_mod]) VALUES (7, N'Mostrador', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMobiliario] ([TipoMobiliarioId], [descripcion], [fecha_mod]) VALUES (8, N'Locker', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMobiliario] ([TipoMobiliarioId], [descripcion], [fecha_mod]) VALUES (9, N'Banco', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [Inventarios].[TipoMobiliario] ([TipoMobiliarioId], [descripcion], [fecha_mod]) VALUES (10, N'Librero', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
SET IDENTITY_INSERT [Inventarios].[TipoMobiliario] OFF
GO
SET IDENTITY_INSERT [Inventarios].[TipoVehiculo] ON
GO
INSERT [Inventarios].[TipoVehiculo] ([TipoVehiculoId], [nombre], [fecha_mod]) VALUES (1, N'Camioneta Pick-up', CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TipoVehiculo] ([TipoVehiculoId], [nombre], [fecha_mod]) VALUES (2, N'Sedan', CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TipoVehiculo] ([TipoVehiculoId], [nombre], [fecha_mod]) VALUES (3, N'Camión Pipa', CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TipoVehiculo] ([TipoVehiculoId], [nombre], [fecha_mod]) VALUES (4, N'Retroexcavadora', CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TipoVehiculo] ([TipoVehiculoId], [nombre], [fecha_mod]) VALUES (5, N'Motocicleta', CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TipoVehiculo] ([TipoVehiculoId], [nombre], [fecha_mod]) VALUES (6, N'Camión Volteo', CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TipoVehiculo] ([TipoVehiculoId], [nombre], [fecha_mod]) VALUES (7, N'Van', CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TipoVehiculo] ([TipoVehiculoId], [nombre], [fecha_mod]) VALUES (8, N'Grúa', CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TipoVehiculo] ([TipoVehiculoId], [nombre], [fecha_mod]) VALUES (9, N'Camión Vactor', CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[TipoVehiculo] ([TipoVehiculoId], [nombre], [fecha_mod]) VALUES (10, N'Tractor', CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
SET IDENTITY_INSERT [Inventarios].[TipoVehiculo] OFF
GO
SET IDENTITY_INSERT [Inventarios].[Vehiculo] ON
GO
INSERT [Inventarios].[Vehiculo] ([VehiculoId], [TipoVehiculoId], [matricula], [actividad], [EstablecimientoId], [fecha_mod]) VALUES (1, 1, N'JAP-001', N'A', 1, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Vehiculo] ([VehiculoId], [TipoVehiculoId], [matricula], [actividad], [EstablecimientoId], [fecha_mod]) VALUES (2, 2, N'JAP-002', N'A', 1, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Vehiculo] ([VehiculoId], [TipoVehiculoId], [matricula], [actividad], [EstablecimientoId], [fecha_mod]) VALUES (3, 3, N'JAP-003', N'A', 2, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Vehiculo] ([VehiculoId], [TipoVehiculoId], [matricula], [actividad], [EstablecimientoId], [fecha_mod]) VALUES (4, 4, N'JAP-004', N'A', 2, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Vehiculo] ([VehiculoId], [TipoVehiculoId], [matricula], [actividad], [EstablecimientoId], [fecha_mod]) VALUES (5, 5, N'JAP-005', N'A', 3, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Vehiculo] ([VehiculoId], [TipoVehiculoId], [matricula], [actividad], [EstablecimientoId], [fecha_mod]) VALUES (6, 6, N'JAP-006', N'A', 3, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Vehiculo] ([VehiculoId], [TipoVehiculoId], [matricula], [actividad], [EstablecimientoId], [fecha_mod]) VALUES (7, 7, N'JAP-007', N'A', 4, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Vehiculo] ([VehiculoId], [TipoVehiculoId], [matricula], [actividad], [EstablecimientoId], [fecha_mod]) VALUES (8, 8, N'JAP-008', N'A', 4, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Vehiculo] ([VehiculoId], [TipoVehiculoId], [matricula], [actividad], [EstablecimientoId], [fecha_mod]) VALUES (9, 9, N'JAP-009', N'A', 5, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
INSERT [Inventarios].[Vehiculo] ([VehiculoId], [TipoVehiculoId], [matricula], [actividad], [EstablecimientoId], [fecha_mod]) VALUES (10, 10, N'JAP-010', N'A', 5, CAST(N'2025-04-28T01:50:30.253' AS DateTime))
GO
SET IDENTITY_INSERT [Inventarios].[Vehiculo] OFF
GO
SET IDENTITY_INSERT [Personas].[Domicilio] ON
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (1, N'Calle Principal 123', N'Colonia Centro', N'81200', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (2, N'Av. Independencia 456', N'Colonia Libertad', N'81210', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (3, N'Calle Reforma 789', N'Colonia Progreso', N'81220', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (4, N'Blvd. Centenario 234', N'Colonia Modern', N'81230', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (5, N'Av. Álamos 567', N'Colonia Jardines', N'81240', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (6, N'Calle Pino 890', N'Colonia Bosques', N'81250', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (7, N'Av. Rosales 123', N'Colonia Flores', N'81260', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (8, N'Calle Juárez 456', N'Colonia Centro', N'81270', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (9, N'Av. Hidalgo 789', N'Colonia Reforma', N'81280', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (10, N'Calle Morelos 012', N'Colonia Victoria', N'81290', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (11, N'Blvd. Zaragoza 345', N'Colonia Nueva', N'81300', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (12, N'Av. Sinaloa 678', N'Colonia Estado', N'81310', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (13, N'Calle Sonora 901', N'Colonia Norte', N'81320', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (14, N'Av. Chihuahua 234', N'Colonia Sur', N'81330', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (15, N'Calle Durango 567', N'Colonia Este', N'81340', 1, 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (16, N'Zona Industrial 100', N'Parque Industrial', N'81400', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (17, N'Av. Comercial 200', N'Zona Comercial', N'81410', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (18, N'Blvd. Industrial 300', N'Sector 1', N'81420', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (19, N'Carretera Nacional 400', N'Km 5', N'81430', 2, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (20, N'Av. Empresarial 500', N'Zona Dorada', N'81440', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (21, N'Calle Comercio 600', N'Centro', N'81450', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (22, N'Av. Negocios 700', N'Plaza Principal', N'81460', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (23, N'Blvd. Corporativo 800', N'Torre A', N'81470', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (24, N'Carretera Internacional 900', N'Km 10', N'81480', 3, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (25, N'Av. Industrial 1000', N'Parque 2', N'81490', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (26, N'Zona Comercial 1100', N'Local 1', N'81500', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (27, N'Av. Principal 1200', N'Plaza Norte', N'81510', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (28, N'Blvd. Empresas 1300', N'Edificio B', N'81520', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (29, N'Calle Industria 1400', N'Nave 3', N'81530', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (30, N'Av. Comercios 1500', N'Local 100', N'81540', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (31, N'Zona Industrial 1600', N'Bodega 5', N'81550', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (32, N'Av. Corporativa 1700', N'Piso 2', N'81560', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (33, N'Blvd. Negocios 1800', N'Suite 300', N'81570', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (34, N'Calle Empresarial 1900', N'Oficina 4', N'81580', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (35, N'Av. Industrial 2000', N'Planta 1', N'81590', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (36, N'Zona Comercial 2100', N'Local 200', N'81600', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (37, N'Av. Empresas 2200', N'Edificio C', N'81610', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (38, N'Blvd. Industrial 2300', N'Nave 7', N'81620', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (39, N'Calle Negocios 2400', N'Torre B', N'81630', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (40, N'Av. Corporativo 2500', N'Piso 5', N'81640', 1, 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (41, N'Av. Insurgentes 2600', N'Residencial Las Palmas', N'81650', 1, 1, CAST(N'2025-04-28T01:50:30.243' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (42, N'Calle Girasoles 2700', N'Fraccionamiento Las Flores', N'81660', 1, 1, CAST(N'2025-04-28T01:50:30.243' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (43, N'Blvd. Alameda 2800', N'Colonia Los Pinos', N'81670', 1, 1, CAST(N'2025-04-28T01:50:30.243' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (44, N'Paseo del Mar 2900', N'Residencial Costa Azul', N'81680', 3, 1, CAST(N'2025-04-28T01:50:30.243' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (45, N'Calle Nogal 3000', N'Colonia Las Arboledas', N'81690', 1, 1, CAST(N'2025-04-28T01:50:30.243' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (46, N'Av. Universidad 3100', N'Colonia Educación', N'81700', 1, 2, CAST(N'2025-04-28T01:50:30.243' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (47, N'Blvd. Las Torres 3200', N'Torre Ejecutiva', N'81710', 1, 2, CAST(N'2025-04-28T01:50:30.243' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (48, N'Carretera Vieja 3300', N'Parque Industrial Sur', N'81720', 2, 2, CAST(N'2025-04-28T01:50:30.243' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (49, N'Av. Las Américas 3400', N'Plaza Comercial', N'81730', 1, 2, CAST(N'2025-04-28T01:50:30.243' AS DateTime), NULL)
GO
INSERT [Personas].[Domicilio] ([DomicilioId], [domicilio_linea1], [domicilio_linea2], [cod_postal], [LocalidadId], [TipoDomicilioId], [fecha_mod], [SectorId]) VALUES (50, N'Calle Victoria 3500', N'Centro Histórico', N'81740', 1, 2, CAST(N'2025-04-28T01:50:30.243' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [Personas].[Domicilio] OFF
GO
SET IDENTITY_INSERT [Personas].[Email] ON
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (1, N'juan.perez@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (2, N'maria.lopez@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (3, N'carlos.ruiz@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (4, N'ana.garcia@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (5, N'pedro.martinez@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (6, N'laura.sanchez@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (7, N'jose.rodriguez@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (8, N'carmen.torres@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (9, N'francisco.ramirez@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (10, N'sofia.morales@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (11, N'miguel.castro@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (12, N'patricia.flores@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (13, N'roberto.diaz@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (14, N'isabel.vazquez@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (15, N'david.mendoza@mail.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (16, N'contacto@constructoraxa.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (17, N'info@industriasmx.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (18, N'ventas@comercialnorte.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (19, N'admin@transportessinaloa.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (20, N'info@manufacturasahome.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (21, N'contacto@serviciostopo.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (22, N'ventas@distribuidoradelnorte.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (23, N'info@agricoladelvalle.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (24, N'contacto@pescaderiamar.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (25, N'admin@logisticamochis.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (26, N'info@materiales_construccion.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (27, N'ventas@ferreterianorte.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (28, N'contacto@alimentospacifico.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (29, N'info@ganaderanorte.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (30, N'admin@aceroshome.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (31, N'contacto@pinturasmx.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (32, N'info@electricanorte.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (33, N'ventas@plomeriapro.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (34, N'admin@refrigeraciontotal.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (35, N'contacto@maquinariapesada.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (36, N'info@herramientasplus.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (37, N'admin@tuberiaindustrial.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (38, N'ventas@bombasagua.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (39, N'contacto@valvulaspro.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Email] ([EmailId], [correo], [fecha_mod]) VALUES (40, N'info@medidoresagua.com', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
SET IDENTITY_INSERT [Personas].[Email] OFF
GO
SET IDENTITY_INSERT [Personas].[Localidad] ON
GO
INSERT [Personas].[Localidad] ([LocalidadId], [nombre], [fecha_mod]) VALUES (1, N'Los Mochis', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Localidad] ([LocalidadId], [nombre], [fecha_mod]) VALUES (2, N'Ahome', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Localidad] ([LocalidadId], [nombre], [fecha_mod]) VALUES (3, N'Topolobampo', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
SET IDENTITY_INSERT [Personas].[Localidad] OFF
GO
SET IDENTITY_INSERT [Personas].[NumeroTelefonico] ON
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (1, N'6681234567', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (2, N'6682345678', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (3, N'6683456789', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (4, N'6684567890', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (5, N'6685678901', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (6, N'6686789012', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (7, N'6687890123', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (8, N'6688901234', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (9, N'6689012345', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (10, N'6680123456', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (11, N'6681122334', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (12, N'6682233445', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (13, N'6683344556', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (14, N'6684455667', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (15, N'6685566778', 1, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (16, N'6689876543', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (17, N'6688765432', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (18, N'6687654321', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (19, N'6686543210', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (20, N'6685432109', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (21, N'6684321098', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (22, N'6683210987', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (23, N'6682109876', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (24, N'6681098765', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (25, N'6680987654', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (26, N'6689988776', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (27, N'6688877665', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (28, N'6687766554', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (29, N'6686655443', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (30, N'6685544332', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (31, N'6684433221', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (32, N'6683322110', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (33, N'6682211009', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (34, N'6681100998', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (35, N'6680099887', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (36, N'6689999888', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (37, N'6688888777', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (38, N'6687777666', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (39, N'6686666555', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
INSERT [Personas].[NumeroTelefonico] ([NumeroTelId], [numero], [TipoNumeroId], [fecha_mod]) VALUES (40, N'6685555444', 2, CAST(N'2025-04-28T01:50:30.240' AS DateTime))
GO
SET IDENTITY_INSERT [Personas].[NumeroTelefonico] OFF
GO
SET IDENTITY_INSERT [Personas].[Persona] ON
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (1, N'Juan', N'Pérez', N'Gómez', N'F', 1, 1, 1, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (2, N'María', N'López', N'Sánchez', N'F', 2, 2, 2, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (3, N'Carlos', N'Ruiz', N'Torres', N'F', 3, 3, 3, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (4, N'Ana', N'García', N'Ramírez', N'F', 4, 4, 4, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (5, N'Pedro', N'Martínez', N'Castro', N'F', 5, 5, 5, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (6, N'Laura', N'Sánchez', N'Flores', N'F', 6, 6, 6, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (7, N'José', N'Rodríguez', N'Díaz', N'F', 7, 7, 7, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (8, N'Carmen', N'Torres', N'Vázquez', N'F', 8, 8, 8, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (9, N'Francisco', N'Ramírez', N'Mendoza', N'F', 9, 9, 9, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (10, N'Sofía', N'Morales', N'Luna', N'F', 10, 10, 10, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (11, N'Miguel', N'Castro', N'Reyes', N'F', 11, 11, 11, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (12, N'Patricia', N'Flores', N'Silva', N'F', 12, 12, 12, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (13, N'Roberto', N'Díaz', N'Ortiz', N'F', 13, 13, 13, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (14, N'Isabel', N'Vázquez', N'Cruz', N'F', 14, 14, 14, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (15, N'David', N'Mendoza', N'Ríos', N'F', 15, 15, 15, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (16, N'Constructora XA', NULL, NULL, N'M', 16, 16, 16, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (17, N'Industrias MX', NULL, NULL, N'M', 17, 17, 17, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (18, N'Comercial del Norte', NULL, NULL, N'M', 18, 18, 18, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (19, N'Transportes Sinaloa', NULL, NULL, N'M', 19, 19, 19, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (20, N'Manufacturas Ahome', NULL, NULL, N'M', 20, 20, 20, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (21, N'Servicios Topo', NULL, NULL, N'M', 21, 21, 21, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (22, N'Distribuidora del Norte', NULL, NULL, N'M', 22, 22, 22, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (23, N'Agrícola del Valle', NULL, NULL, N'M', 23, 23, 23, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (24, N'Pescadería Mar', NULL, NULL, N'M', 24, 24, 24, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (25, N'Logística Mochis', NULL, NULL, N'M', 25, 25, 25, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (26, N'Materiales Construcción', NULL, NULL, N'M', 26, 26, 26, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (27, N'Ferretería Norte', NULL, NULL, N'M', 27, 27, 27, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (28, N'Alimentos Pacífico', NULL, NULL, N'M', 28, 28, 28, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (29, N'Ganadera Norte', NULL, NULL, N'M', 29, 29, 29, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (30, N'Aceros Home', NULL, NULL, N'M', 30, 30, 30, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (31, N'Pinturas MX', NULL, NULL, N'M', 31, 31, 31, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (32, N'Eléctrica Norte', NULL, NULL, N'M', 32, 32, 32, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (33, N'Plomería Pro', NULL, NULL, N'M', 33, 33, 33, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (34, N'Refrigeración Total', NULL, NULL, N'M', 34, 34, 34, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (35, N'Maquinaria Pesada', NULL, NULL, N'M', 35, 35, 35, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (36, N'Herramientas Plus', NULL, NULL, N'M', 36, 36, 36, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (37, N'Tubería Industrial', NULL, NULL, N'M', 37, 37, 37, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (38, N'Bombas Agua', NULL, NULL, N'M', 38, 38, 38, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (39, N'Válvulas Pro', NULL, NULL, N'M', 39, 39, 39, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[Persona] ([PersonaId], [nombre], [apellido1], [apellido2], [tipo_persona], [EmailId], [NumeroTelId], [DomicilioId], [fecha_mod]) VALUES (40, N'Medidores Agua', NULL, NULL, N'M', 40, 40, 40, CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
SET IDENTITY_INSERT [Personas].[Persona] OFF
GO
SET IDENTITY_INSERT [Personas].[TipoDomicilio] ON
GO
INSERT [Personas].[TipoDomicilio] ([TipoDomicilioId], [descripcion], [fecha_mod]) VALUES (1, N'Residencial', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[TipoDomicilio] ([TipoDomicilioId], [descripcion], [fecha_mod]) VALUES (2, N'Comercial', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[TipoDomicilio] ([TipoDomicilioId], [descripcion], [fecha_mod]) VALUES (3, N'Industrial', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
SET IDENTITY_INSERT [Personas].[TipoDomicilio] OFF
GO
SET IDENTITY_INSERT [Personas].[TipoNumero] ON
GO
INSERT [Personas].[TipoNumero] ([TipoNumeroId], [descripcion], [fecha_mod]) VALUES (1, N'Celular', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[TipoNumero] ([TipoNumeroId], [descripcion], [fecha_mod]) VALUES (2, N'Oficina', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
INSERT [Personas].[TipoNumero] ([TipoNumeroId], [descripcion], [fecha_mod]) VALUES (3, N'Casa', CAST(N'2025-04-28T01:50:30.237' AS DateTime))
GO
SET IDENTITY_INSERT [Personas].[TipoNumero] OFF
GO
SET IDENTITY_INSERT [RecursosHumanos].[Banco] ON
GO
INSERT [RecursosHumanos].[Banco] ([BancoId], [nombre], [fecha_mod]) VALUES (1, N'BBVA', CAST(N'2025-04-28T01:50:30.243' AS DateTime))
GO
INSERT [RecursosHumanos].[Banco] ([BancoId], [nombre], [fecha_mod]) VALUES (2, N'Santander', CAST(N'2025-04-28T01:50:30.243' AS DateTime))
GO
INSERT [RecursosHumanos].[Banco] ([BancoId], [nombre], [fecha_mod]) VALUES (3, N'Banorte', CAST(N'2025-04-28T01:50:30.243' AS DateTime))
GO
INSERT [RecursosHumanos].[Banco] ([BancoId], [nombre], [fecha_mod]) VALUES (4, N'HSBC', CAST(N'2025-04-28T01:50:30.243' AS DateTime))
GO
INSERT [RecursosHumanos].[Banco] ([BancoId], [nombre], [fecha_mod]) VALUES (5, N'Scotiabank', CAST(N'2025-04-28T01:50:30.243' AS DateTime))
GO
INSERT [RecursosHumanos].[Banco] ([BancoId], [nombre], [fecha_mod]) VALUES (6, N'Banamex', CAST(N'2025-04-28T01:50:30.243' AS DateTime))
GO
INSERT [RecursosHumanos].[Banco] ([BancoId], [nombre], [fecha_mod]) VALUES (7, N'Banco Azteca', CAST(N'2025-04-28T01:50:30.243' AS DateTime))
GO
INSERT [RecursosHumanos].[Banco] ([BancoId], [nombre], [fecha_mod]) VALUES (8, N'BanBajío', CAST(N'2025-04-28T01:50:30.243' AS DateTime))
GO
INSERT [RecursosHumanos].[Banco] ([BancoId], [nombre], [fecha_mod]) VALUES (9, N'Inbursa', CAST(N'2025-04-28T01:50:30.243' AS DateTime))
GO
INSERT [RecursosHumanos].[Banco] ([BancoId], [nombre], [fecha_mod]) VALUES (10, N'Bancoppel', CAST(N'2025-04-28T01:50:30.243' AS DateTime))
GO
SET IDENTITY_INSERT [RecursosHumanos].[Banco] OFF
GO
SET IDENTITY_INSERT [RecursosHumanos].[ContratoEmpleado] ON
GO
INSERT [RecursosHumanos].[ContratoEmpleado] ([ContratoId], [tipo_contrato], [fecha_contrato], [fecha_vencimiento], [enlace_documento], [fecha_mod]) VALUES (1, N'SIN', CAST(N'2024-01-01T00:00:00.000' AS DateTime), CAST(N'2025-01-01T00:00:00.000' AS DateTime), N'contratos/2024/SIN001.pdf', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[ContratoEmpleado] ([ContratoId], [tipo_contrato], [fecha_contrato], [fecha_vencimiento], [enlace_documento], [fecha_mod]) VALUES (2, N'SIN', CAST(N'2024-01-15T00:00:00.000' AS DateTime), CAST(N'2025-01-15T00:00:00.000' AS DateTime), N'contratos/2024/SIN002.pdf', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[ContratoEmpleado] ([ContratoId], [tipo_contrato], [fecha_contrato], [fecha_vencimiento], [enlace_documento], [fecha_mod]) VALUES (3, N'CON', CAST(N'2024-02-01T00:00:00.000' AS DateTime), CAST(N'2025-02-01T00:00:00.000' AS DateTime), N'contratos/2024/CON001.pdf', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[ContratoEmpleado] ([ContratoId], [tipo_contrato], [fecha_contrato], [fecha_vencimiento], [enlace_documento], [fecha_mod]) VALUES (4, N'CON', CAST(N'2024-02-15T00:00:00.000' AS DateTime), CAST(N'2025-02-15T00:00:00.000' AS DateTime), N'contratos/2024/CON002.pdf', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[ContratoEmpleado] ([ContratoId], [tipo_contrato], [fecha_contrato], [fecha_vencimiento], [enlace_documento], [fecha_mod]) VALUES (5, N'Eve', CAST(N'2024-03-01T00:00:00.000' AS DateTime), CAST(N'2024-09-01T00:00:00.000' AS DateTime), N'contratos/2024/EVE001.pdf', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[ContratoEmpleado] ([ContratoId], [tipo_contrato], [fecha_contrato], [fecha_vencimiento], [enlace_documento], [fecha_mod]) VALUES (6, N'Eve', CAST(N'2024-03-15T00:00:00.000' AS DateTime), CAST(N'2024-09-15T00:00:00.000' AS DateTime), N'contratos/2024/EVE002.pdf', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[ContratoEmpleado] ([ContratoId], [tipo_contrato], [fecha_contrato], [fecha_vencimiento], [enlace_documento], [fecha_mod]) VALUES (7, N'SIN', CAST(N'2024-01-01T00:00:00.000' AS DateTime), CAST(N'2025-01-01T00:00:00.000' AS DateTime), N'contratos/2024/SIN003.pdf', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[ContratoEmpleado] ([ContratoId], [tipo_contrato], [fecha_contrato], [fecha_vencimiento], [enlace_documento], [fecha_mod]) VALUES (8, N'CON', CAST(N'2024-01-01T00:00:00.000' AS DateTime), CAST(N'2025-01-01T00:00:00.000' AS DateTime), N'contratos/2024/CON003.pdf', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[ContratoEmpleado] ([ContratoId], [tipo_contrato], [fecha_contrato], [fecha_vencimiento], [enlace_documento], [fecha_mod]) VALUES (9, N'Eve', CAST(N'2024-01-01T00:00:00.000' AS DateTime), CAST(N'2024-07-01T00:00:00.000' AS DateTime), N'contratos/2024/EVE003.pdf', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[ContratoEmpleado] ([ContratoId], [tipo_contrato], [fecha_contrato], [fecha_vencimiento], [enlace_documento], [fecha_mod]) VALUES (10, N'SIN', CAST(N'2024-02-01T00:00:00.000' AS DateTime), CAST(N'2025-02-01T00:00:00.000' AS DateTime), N'contratos/2024/SIN004.pdf', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
SET IDENTITY_INSERT [RecursosHumanos].[ContratoEmpleado] OFF
GO
SET IDENTITY_INSERT [RecursosHumanos].[Empleado] ON
GO
INSERT [RecursosHumanos].[Empleado] ([EmpleadoId], [nss], [rfc], [ContratoId], [PuestoId], [edo_civil], [fecha_nacimiento], [fecha_contratacion], [actividad], [fecha_mod], [PersonaId], [TurnoId], [NominaId], [EstablecimientoId]) VALUES (1, N'12345678901', N'XAXX010101000', 1, 1, N'CAS', CAST(N'1980-01-15' AS Date), CAST(N'2024-01-01T00:00:00.000' AS DateTime), N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime), 1, 1, 1, 1)
GO
INSERT [RecursosHumanos].[Empleado] ([EmpleadoId], [nss], [rfc], [ContratoId], [PuestoId], [edo_civil], [fecha_nacimiento], [fecha_contratacion], [actividad], [fecha_mod], [PersonaId], [TurnoId], [NominaId], [EstablecimientoId]) VALUES (2, N'23456789012', N'XAXX020202000', 2, 2, N'SOL', CAST(N'1985-02-20' AS Date), CAST(N'2024-01-15T00:00:00.000' AS DateTime), N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime), 2, 2, 2, 1)
GO
INSERT [RecursosHumanos].[Empleado] ([EmpleadoId], [nss], [rfc], [ContratoId], [PuestoId], [edo_civil], [fecha_nacimiento], [fecha_contratacion], [actividad], [fecha_mod], [PersonaId], [TurnoId], [NominaId], [EstablecimientoId]) VALUES (3, N'34567890123', N'XAXX030303000', 3, 3, N'CAS', CAST(N'1982-03-25' AS Date), CAST(N'2024-02-01T00:00:00.000' AS DateTime), N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime), 3, 3, 3, 2)
GO
INSERT [RecursosHumanos].[Empleado] ([EmpleadoId], [nss], [rfc], [ContratoId], [PuestoId], [edo_civil], [fecha_nacimiento], [fecha_contratacion], [actividad], [fecha_mod], [PersonaId], [TurnoId], [NominaId], [EstablecimientoId]) VALUES (4, N'45678901234', N'XAXX040404000', 4, 4, N'DIV', CAST(N'1988-04-10' AS Date), CAST(N'2024-02-15T00:00:00.000' AS DateTime), N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime), 4, 4, 4, 2)
GO
INSERT [RecursosHumanos].[Empleado] ([EmpleadoId], [nss], [rfc], [ContratoId], [PuestoId], [edo_civil], [fecha_nacimiento], [fecha_contratacion], [actividad], [fecha_mod], [PersonaId], [TurnoId], [NominaId], [EstablecimientoId]) VALUES (5, N'56789012345', N'XAXX050505000', 5, 5, N'SOL', CAST(N'1990-05-05' AS Date), CAST(N'2024-03-01T00:00:00.000' AS DateTime), N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime), 5, 5, 5, 3)
GO
INSERT [RecursosHumanos].[Empleado] ([EmpleadoId], [nss], [rfc], [ContratoId], [PuestoId], [edo_civil], [fecha_nacimiento], [fecha_contratacion], [actividad], [fecha_mod], [PersonaId], [TurnoId], [NominaId], [EstablecimientoId]) VALUES (6, N'67890123456', N'XAXX060606000', 6, 6, N'CAS', CAST(N'1987-06-15' AS Date), CAST(N'2024-03-15T00:00:00.000' AS DateTime), N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime), 6, 6, 6, 3)
GO
INSERT [RecursosHumanos].[Empleado] ([EmpleadoId], [nss], [rfc], [ContratoId], [PuestoId], [edo_civil], [fecha_nacimiento], [fecha_contratacion], [actividad], [fecha_mod], [PersonaId], [TurnoId], [NominaId], [EstablecimientoId]) VALUES (7, N'78901234567', N'XAXX070707000', 7, 7, N'SOL', CAST(N'1992-07-20' AS Date), CAST(N'2024-01-01T00:00:00.000' AS DateTime), N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime), 7, 7, 7, 4)
GO
INSERT [RecursosHumanos].[Empleado] ([EmpleadoId], [nss], [rfc], [ContratoId], [PuestoId], [edo_civil], [fecha_nacimiento], [fecha_contratacion], [actividad], [fecha_mod], [PersonaId], [TurnoId], [NominaId], [EstablecimientoId]) VALUES (8, N'89012345678', N'XAXX080808000', 8, 8, N'CAS', CAST(N'1986-08-25' AS Date), CAST(N'2024-01-01T00:00:00.000' AS DateTime), N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime), 8, 8, 8, 4)
GO
INSERT [RecursosHumanos].[Empleado] ([EmpleadoId], [nss], [rfc], [ContratoId], [PuestoId], [edo_civil], [fecha_nacimiento], [fecha_contratacion], [actividad], [fecha_mod], [PersonaId], [TurnoId], [NominaId], [EstablecimientoId]) VALUES (9, N'90123456789', N'XAXX090909000', 9, 9, N'VIU', CAST(N'1983-09-30' AS Date), CAST(N'2024-01-01T00:00:00.000' AS DateTime), N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime), 9, 9, 9, 5)
GO
INSERT [RecursosHumanos].[Empleado] ([EmpleadoId], [nss], [rfc], [ContratoId], [PuestoId], [edo_civil], [fecha_nacimiento], [fecha_contratacion], [actividad], [fecha_mod], [PersonaId], [TurnoId], [NominaId], [EstablecimientoId]) VALUES (10, N'01234567890', N'XAXX101010000', 10, 10, N'SOL', CAST(N'1991-10-05' AS Date), CAST(N'2024-02-01T00:00:00.000' AS DateTime), N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime), 10, 10, 10, 5)
GO
SET IDENTITY_INSERT [RecursosHumanos].[Empleado] OFF
GO
SET IDENTITY_INSERT [RecursosHumanos].[HistorialAsistencia] ON
GO
INSERT [RecursosHumanos].[HistorialAsistencia] ([AsistenciaId], [EmpleadoId], [fecha_entrada], [fecha_salida], [fecha_mod]) VALUES (1, 1, CAST(N'2024-03-01T07:00:00.000' AS DateTime), CAST(N'2024-03-01T15:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[HistorialAsistencia] ([AsistenciaId], [EmpleadoId], [fecha_entrada], [fecha_salida], [fecha_mod]) VALUES (2, 2, CAST(N'2024-03-01T08:00:00.000' AS DateTime), CAST(N'2024-03-01T16:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[HistorialAsistencia] ([AsistenciaId], [EmpleadoId], [fecha_entrada], [fecha_salida], [fecha_mod]) VALUES (3, 3, CAST(N'2024-03-01T14:00:00.000' AS DateTime), CAST(N'2024-03-01T22:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[HistorialAsistencia] ([AsistenciaId], [EmpleadoId], [fecha_entrada], [fecha_salida], [fecha_mod]) VALUES (4, 4, CAST(N'2024-03-01T15:00:00.000' AS DateTime), CAST(N'2024-03-01T23:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[HistorialAsistencia] ([AsistenciaId], [EmpleadoId], [fecha_entrada], [fecha_salida], [fecha_mod]) VALUES (5, 5, CAST(N'2024-03-01T22:00:00.000' AS DateTime), CAST(N'2024-03-02T06:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[HistorialAsistencia] ([AsistenciaId], [EmpleadoId], [fecha_entrada], [fecha_salida], [fecha_mod]) VALUES (6, 6, CAST(N'2024-03-01T23:00:00.000' AS DateTime), CAST(N'2024-03-02T07:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[HistorialAsistencia] ([AsistenciaId], [EmpleadoId], [fecha_entrada], [fecha_salida], [fecha_mod]) VALUES (7, 7, CAST(N'2024-03-01T06:00:00.000' AS DateTime), CAST(N'2024-03-01T12:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[HistorialAsistencia] ([AsistenciaId], [EmpleadoId], [fecha_entrada], [fecha_salida], [fecha_mod]) VALUES (8, 8, CAST(N'2024-03-01T12:00:00.000' AS DateTime), CAST(N'2024-03-01T18:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[HistorialAsistencia] ([AsistenciaId], [EmpleadoId], [fecha_entrada], [fecha_salida], [fecha_mod]) VALUES (9, 9, CAST(N'2024-03-01T13:00:00.000' AS DateTime), CAST(N'2024-03-01T19:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[HistorialAsistencia] ([AsistenciaId], [EmpleadoId], [fecha_entrada], [fecha_salida], [fecha_mod]) VALUES (10, 10, CAST(N'2024-03-02T00:00:00.000' AS DateTime), CAST(N'2024-03-02T06:00:00.000' AS DateTime), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
SET IDENTITY_INSERT [RecursosHumanos].[HistorialAsistencia] OFF
GO
SET IDENTITY_INSERT [RecursosHumanos].[Nomina] ON
GO
INSERT [RecursosHumanos].[Nomina] ([NominaId], [clabe], [BancoId], [fecha_mod]) VALUES (1, N'012650001234567890', 1, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Nomina] ([NominaId], [clabe], [BancoId], [fecha_mod]) VALUES (2, N'014650002345678901', 2, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Nomina] ([NominaId], [clabe], [BancoId], [fecha_mod]) VALUES (3, N'072650003456789012', 3, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Nomina] ([NominaId], [clabe], [BancoId], [fecha_mod]) VALUES (4, N'021650004567890123', 4, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Nomina] ([NominaId], [clabe], [BancoId], [fecha_mod]) VALUES (5, N'044650005678901234', 5, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Nomina] ([NominaId], [clabe], [BancoId], [fecha_mod]) VALUES (6, N'002650006789012345', 6, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Nomina] ([NominaId], [clabe], [BancoId], [fecha_mod]) VALUES (7, N'127650007890123456', 7, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Nomina] ([NominaId], [clabe], [BancoId], [fecha_mod]) VALUES (8, N'030650008901234567', 8, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Nomina] ([NominaId], [clabe], [BancoId], [fecha_mod]) VALUES (9, N'036650009012345678', 9, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Nomina] ([NominaId], [clabe], [BancoId], [fecha_mod]) VALUES (10, N'137650000123456789', 10, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
SET IDENTITY_INSERT [RecursosHumanos].[Nomina] OFF
GO
SET IDENTITY_INSERT [RecursosHumanos].[Puesto] ON
GO
INSERT [RecursosHumanos].[Puesto] ([PuestoId], [descripcion], [salario_base], [bonos], [fecha_mod]) VALUES (1, N'Gerente General', 35000.0000, 5000.0000, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Puesto] ([PuestoId], [descripcion], [salario_base], [bonos], [fecha_mod]) VALUES (2, N'Jefe de Departamento', 25000.0000, 3000.0000, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Puesto] ([PuestoId], [descripcion], [salario_base], [bonos], [fecha_mod]) VALUES (3, N'Supervisor', 20000.0000, 2500.0000, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Puesto] ([PuestoId], [descripcion], [salario_base], [bonos], [fecha_mod]) VALUES (4, N'Técnico Especializado', 18000.0000, 2000.0000, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Puesto] ([PuestoId], [descripcion], [salario_base], [bonos], [fecha_mod]) VALUES (5, N'Operador', 15000.0000, 1500.0000, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Puesto] ([PuestoId], [descripcion], [salario_base], [bonos], [fecha_mod]) VALUES (6, N'Auxiliar Administrativo', 12000.0000, 1000.0000, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Puesto] ([PuestoId], [descripcion], [salario_base], [bonos], [fecha_mod]) VALUES (7, N'Almacenista', 11000.0000, 1000.0000, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Puesto] ([PuestoId], [descripcion], [salario_base], [bonos], [fecha_mod]) VALUES (8, N'Chofer', 10000.0000, 1500.0000, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Puesto] ([PuestoId], [descripcion], [salario_base], [bonos], [fecha_mod]) VALUES (9, N'Vigilante', 9000.0000, 1000.0000, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Puesto] ([PuestoId], [descripcion], [salario_base], [bonos], [fecha_mod]) VALUES (10, N'Intendente', 8000.0000, 800.0000, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
SET IDENTITY_INSERT [RecursosHumanos].[Puesto] OFF
GO
SET IDENTITY_INSERT [RecursosHumanos].[PuestoSindicato] ON
GO
INSERT [RecursosHumanos].[PuestoSindicato] ([PuestoSindicatoId], [nombre], [estatus], [fecha_mod]) VALUES (1, N'Secretario General                                ', N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[PuestoSindicato] ([PuestoSindicatoId], [nombre], [estatus], [fecha_mod]) VALUES (2, N'Secretario de Trabajo                             ', N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[PuestoSindicato] ([PuestoSindicatoId], [nombre], [estatus], [fecha_mod]) VALUES (3, N'Secretario de Finanzas                            ', N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[PuestoSindicato] ([PuestoSindicatoId], [nombre], [estatus], [fecha_mod]) VALUES (4, N'Secretario de Actas                               ', N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[PuestoSindicato] ([PuestoSindicatoId], [nombre], [estatus], [fecha_mod]) VALUES (5, N'Secretario de Organización                        ', N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[PuestoSindicato] ([PuestoSindicatoId], [nombre], [estatus], [fecha_mod]) VALUES (6, N'Delegado Sindical                                 ', N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[PuestoSindicato] ([PuestoSindicatoId], [nombre], [estatus], [fecha_mod]) VALUES (7, N'Comisionado de Vigilancia                         ', N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[PuestoSindicato] ([PuestoSindicatoId], [nombre], [estatus], [fecha_mod]) VALUES (8, N'Comisionado de Honor                              ', N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[PuestoSindicato] ([PuestoSindicatoId], [nombre], [estatus], [fecha_mod]) VALUES (9, N'Representante Laboral                             ', N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[PuestoSindicato] ([PuestoSindicatoId], [nombre], [estatus], [fecha_mod]) VALUES (10, N'Vocal                                             ', N'A', CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
SET IDENTITY_INSERT [RecursosHumanos].[PuestoSindicato] OFF
GO
SET IDENTITY_INSERT [RecursosHumanos].[Sindicato] ON
GO
INSERT [RecursosHumanos].[Sindicato] ([SindicatoId], [EmpleadoId], [fecha_afiliacion], [PuestoSindicatoId], [fecha_mod]) VALUES (1, 1, CAST(N'2024-01-01T00:00:00.000' AS DateTime), 1, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Sindicato] ([SindicatoId], [EmpleadoId], [fecha_afiliacion], [PuestoSindicatoId], [fecha_mod]) VALUES (2, 2, CAST(N'2024-01-15T00:00:00.000' AS DateTime), 2, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Sindicato] ([SindicatoId], [EmpleadoId], [fecha_afiliacion], [PuestoSindicatoId], [fecha_mod]) VALUES (3, 3, CAST(N'2024-02-01T00:00:00.000' AS DateTime), 3, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Sindicato] ([SindicatoId], [EmpleadoId], [fecha_afiliacion], [PuestoSindicatoId], [fecha_mod]) VALUES (4, 4, CAST(N'2024-02-15T00:00:00.000' AS DateTime), 4, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Sindicato] ([SindicatoId], [EmpleadoId], [fecha_afiliacion], [PuestoSindicatoId], [fecha_mod]) VALUES (5, 5, CAST(N'2024-03-01T00:00:00.000' AS DateTime), 5, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Sindicato] ([SindicatoId], [EmpleadoId], [fecha_afiliacion], [PuestoSindicatoId], [fecha_mod]) VALUES (6, 6, CAST(N'2024-03-15T00:00:00.000' AS DateTime), 6, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Sindicato] ([SindicatoId], [EmpleadoId], [fecha_afiliacion], [PuestoSindicatoId], [fecha_mod]) VALUES (7, 7, CAST(N'2024-01-01T00:00:00.000' AS DateTime), 7, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Sindicato] ([SindicatoId], [EmpleadoId], [fecha_afiliacion], [PuestoSindicatoId], [fecha_mod]) VALUES (8, 8, CAST(N'2024-01-01T00:00:00.000' AS DateTime), 8, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Sindicato] ([SindicatoId], [EmpleadoId], [fecha_afiliacion], [PuestoSindicatoId], [fecha_mod]) VALUES (9, 9, CAST(N'2024-01-01T00:00:00.000' AS DateTime), 9, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Sindicato] ([SindicatoId], [EmpleadoId], [fecha_afiliacion], [PuestoSindicatoId], [fecha_mod]) VALUES (10, 10, CAST(N'2024-02-01T00:00:00.000' AS DateTime), 10, CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
SET IDENTITY_INSERT [RecursosHumanos].[Sindicato] OFF
GO
SET IDENTITY_INSERT [RecursosHumanos].[Turno] ON
GO
INSERT [RecursosHumanos].[Turno] ([TurnoId], [tipo], [duracion], [hora_entrada], [hora_salida], [fecha_mod]) VALUES (1, N'MAT', 8, CAST(N'07:00:00' AS Time), CAST(N'15:00:00' AS Time), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Turno] ([TurnoId], [tipo], [duracion], [hora_entrada], [hora_salida], [fecha_mod]) VALUES (2, N'MAT', 8, CAST(N'08:00:00' AS Time), CAST(N'16:00:00' AS Time), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Turno] ([TurnoId], [tipo], [duracion], [hora_entrada], [hora_salida], [fecha_mod]) VALUES (3, N'VES', 8, CAST(N'14:00:00' AS Time), CAST(N'22:00:00' AS Time), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Turno] ([TurnoId], [tipo], [duracion], [hora_entrada], [hora_salida], [fecha_mod]) VALUES (4, N'VES', 8, CAST(N'15:00:00' AS Time), CAST(N'23:00:00' AS Time), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Turno] ([TurnoId], [tipo], [duracion], [hora_entrada], [hora_salida], [fecha_mod]) VALUES (5, N'NOC', 8, CAST(N'22:00:00' AS Time), CAST(N'06:00:00' AS Time), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Turno] ([TurnoId], [tipo], [duracion], [hora_entrada], [hora_salida], [fecha_mod]) VALUES (6, N'NOC', 8, CAST(N'23:00:00' AS Time), CAST(N'07:00:00' AS Time), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Turno] ([TurnoId], [tipo], [duracion], [hora_entrada], [hora_salida], [fecha_mod]) VALUES (7, N'MAT', 6, CAST(N'06:00:00' AS Time), CAST(N'12:00:00' AS Time), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Turno] ([TurnoId], [tipo], [duracion], [hora_entrada], [hora_salida], [fecha_mod]) VALUES (8, N'VES', 6, CAST(N'12:00:00' AS Time), CAST(N'18:00:00' AS Time), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Turno] ([TurnoId], [tipo], [duracion], [hora_entrada], [hora_salida], [fecha_mod]) VALUES (9, N'VES', 6, CAST(N'13:00:00' AS Time), CAST(N'19:00:00' AS Time), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
INSERT [RecursosHumanos].[Turno] ([TurnoId], [tipo], [duracion], [hora_entrada], [hora_salida], [fecha_mod]) VALUES (10, N'NOC', 6, CAST(N'00:00:00' AS Time), CAST(N'06:00:00' AS Time), CAST(N'2025-04-28T01:50:30.250' AS DateTime))
GO
SET IDENTITY_INSERT [RecursosHumanos].[Turno] OFF
GO
SET IDENTITY_INSERT [Servicios].[CartaNoAdeudos] ON
GO
INSERT [Servicios].[CartaNoAdeudos] ([CartaId], [enlace_documento], [fecha_mod]) VALUES (1, N'cartas/2024/CNA001.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[CartaNoAdeudos] ([CartaId], [enlace_documento], [fecha_mod]) VALUES (2, N'cartas/2024/CNA002.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[CartaNoAdeudos] ([CartaId], [enlace_documento], [fecha_mod]) VALUES (3, N'cartas/2024/CNA003.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[CartaNoAdeudos] ([CartaId], [enlace_documento], [fecha_mod]) VALUES (4, N'cartas/2024/CNA004.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[CartaNoAdeudos] ([CartaId], [enlace_documento], [fecha_mod]) VALUES (5, N'cartas/2024/CNA005.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[CartaNoAdeudos] ([CartaId], [enlace_documento], [fecha_mod]) VALUES (6, N'cartas/2024/CNA006.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[CartaNoAdeudos] ([CartaId], [enlace_documento], [fecha_mod]) VALUES (7, N'cartas/2024/CNA007.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[CartaNoAdeudos] ([CartaId], [enlace_documento], [fecha_mod]) VALUES (8, N'cartas/2024/CNA008.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[CartaNoAdeudos] ([CartaId], [enlace_documento], [fecha_mod]) VALUES (9, N'cartas/2024/CNA009.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[CartaNoAdeudos] ([CartaId], [enlace_documento], [fecha_mod]) VALUES (10, N'cartas/2024/CNA010.pdf', CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Servicios].[CartaNoAdeudos] OFF
GO
SET IDENTITY_INSERT [Servicios].[ProgramaDescuento] ON
GO
INSERT [Servicios].[ProgramaDescuento] ([ProgramaId], [descricpion], [porcentaje_aplicado], [fecha_inicio], [fecha_final], [fecha_mod]) VALUES (1, N'Pensionados IMSS', 50, CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ProgramaDescuento] ([ProgramaId], [descricpion], [porcentaje_aplicado], [fecha_inicio], [fecha_final], [fecha_mod]) VALUES (2, N'INAPAM', 40, CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ProgramaDescuento] ([ProgramaId], [descricpion], [porcentaje_aplicado], [fecha_inicio], [fecha_final], [fecha_mod]) VALUES (3, N'Pago anual anticipado', 15, CAST(N'2024-01-01' AS Date), CAST(N'2024-03-31' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ProgramaDescuento] ([ProgramaId], [descricpion], [porcentaje_aplicado], [fecha_inicio], [fecha_final], [fecha_mod]) VALUES (4, N'Escuelas públicas', 30, CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ProgramaDescuento] ([ProgramaId], [descricpion], [porcentaje_aplicado], [fecha_inicio], [fecha_final], [fecha_mod]) VALUES (5, N'Personas discapacidad', 45, CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ProgramaDescuento] ([ProgramaId], [descricpion], [porcentaje_aplicado], [fecha_inicio], [fecha_final], [fecha_mod]) VALUES (6, N'Madre soltera', 25, CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ProgramaDescuento] ([ProgramaId], [descricpion], [porcentaje_aplicado], [fecha_inicio], [fecha_final], [fecha_mod]) VALUES (7, N'Jubilados municipales', 35, CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ProgramaDescuento] ([ProgramaId], [descricpion], [porcentaje_aplicado], [fecha_inicio], [fecha_final], [fecha_mod]) VALUES (8, N'Casa hogar', 100, CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ProgramaDescuento] ([ProgramaId], [descricpion], [porcentaje_aplicado], [fecha_inicio], [fecha_final], [fecha_mod]) VALUES (9, N'Bomberos', 100, CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ProgramaDescuento] ([ProgramaId], [descricpion], [porcentaje_aplicado], [fecha_inicio], [fecha_final], [fecha_mod]) VALUES (10, N'Regularización', 20, CAST(N'2024-03-01' AS Date), CAST(N'2024-05-31' AS Date), CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Servicios].[ProgramaDescuento] OFF
GO
SET IDENTITY_INSERT [Servicios].[ReporteProblema] ON
GO
INSERT [Servicios].[ReporteProblema] ([ReporteId], [descripcion], [fecha_reporte], [EmpleadoId], [seguimiento], [DepartamentoId], [observaciones], [fecha_mod]) VALUES (1, N'Fuga en medidor', CAST(N'2024-03-01' AS Date), 1, N'En proceso', 3, N'Prioridad alta', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ReporteProblema] ([ReporteId], [descripcion], [fecha_reporte], [EmpleadoId], [seguimiento], [DepartamentoId], [observaciones], [fecha_mod]) VALUES (2, N'Sin servicio', CAST(N'2024-03-02' AS Date), 2, N'Resuelto', 3, N'Válvula cerrada', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ReporteProblema] ([ReporteId], [descripcion], [fecha_reporte], [EmpleadoId], [seguimiento], [DepartamentoId], [observaciones], [fecha_mod]) VALUES (3, N'Baja presión', CAST(N'2024-03-03' AS Date), 3, N'En revisión', 3, N'Zona alta', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ReporteProblema] ([ReporteId], [descripcion], [fecha_reporte], [EmpleadoId], [seguimiento], [DepartamentoId], [observaciones], [fecha_mod]) VALUES (4, N'Agua turbia', CAST(N'2024-03-04' AS Date), 4, N'En proceso', 9, N'Toma muestra', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ReporteProblema] ([ReporteId], [descripcion], [fecha_reporte], [EmpleadoId], [seguimiento], [DepartamentoId], [observaciones], [fecha_mod]) VALUES (5, N'Medidor dañado', CAST(N'2024-03-05' AS Date), 5, N'Programado', 8, N'Requiere cambio', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ReporteProblema] ([ReporteId], [descripcion], [fecha_reporte], [EmpleadoId], [seguimiento], [DepartamentoId], [observaciones], [fecha_mod]) VALUES (6, N'Fuga en calle', CAST(N'2024-03-06' AS Date), 6, N'En proceso', 3, N'Excavación mayor', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ReporteProblema] ([ReporteId], [descripcion], [fecha_reporte], [EmpleadoId], [seguimiento], [DepartamentoId], [observaciones], [fecha_mod]) VALUES (7, N'Drenaje tapado', CAST(N'2024-03-07' AS Date), 7, N'Pendiente', 3, N'Usar vactor', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ReporteProblema] ([ReporteId], [descripcion], [fecha_reporte], [EmpleadoId], [seguimiento], [DepartamentoId], [observaciones], [fecha_mod]) VALUES (8, N'Error lectura', CAST(N'2024-03-08' AS Date), 8, N'Resuelto', 8, N'Corregir sistema', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ReporteProblema] ([ReporteId], [descripcion], [fecha_reporte], [EmpleadoId], [seguimiento], [DepartamentoId], [observaciones], [fecha_mod]) VALUES (9, N'Reconexión', CAST(N'2024-03-09' AS Date), 9, N'Programado', 3, N'Pago verificado', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[ReporteProblema] ([ReporteId], [descripcion], [fecha_reporte], [EmpleadoId], [seguimiento], [DepartamentoId], [observaciones], [fecha_mod]) VALUES (10, N'Fuga matriz', CAST(N'2024-03-10' AS Date), 10, N'Urgente', 3, N'Corte general', CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Servicios].[ReporteProblema] OFF
GO
SET IDENTITY_INSERT [Servicios].[SuspensionServicio] ON
GO
INSERT [Servicios].[SuspensionServicio] ([SuspensionId], [actividad], [descricpion], [fecha_suspension], [enlace_documento], [fecha_mod]) VALUES (1, N'T', N'Falta de pago 3 meses', CAST(N'2024-03-01' AS Date), N'suspensiones/2024/SUS001.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[SuspensionServicio] ([SuspensionId], [actividad], [descricpion], [fecha_suspension], [enlace_documento], [fecha_mod]) VALUES (2, N'P', N'Baja definitiva', CAST(N'2024-03-02' AS Date), N'suspensiones/2024/SUS002.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[SuspensionServicio] ([SuspensionId], [actividad], [descricpion], [fecha_suspension], [enlace_documento], [fecha_mod]) VALUES (3, N'T', N'Mantenimiento red', CAST(N'2024-03-03' AS Date), N'suspensiones/2024/SUS003.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[SuspensionServicio] ([SuspensionId], [actividad], [descricpion], [fecha_suspension], [enlace_documento], [fecha_mod]) VALUES (4, N'T', N'Reparación línea', CAST(N'2024-03-04' AS Date), N'suspensiones/2024/SUS004.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[SuspensionServicio] ([SuspensionId], [actividad], [descricpion], [fecha_suspension], [enlace_documento], [fecha_mod]) VALUES (5, N'P', N'Demolición inmueble', CAST(N'2024-03-05' AS Date), N'suspensiones/2024/SUS005.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[SuspensionServicio] ([SuspensionId], [actividad], [descricpion], [fecha_suspension], [enlace_documento], [fecha_mod]) VALUES (6, N'T', N'Fuga mayor', CAST(N'2024-03-06' AS Date), N'suspensiones/2024/SUS006.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[SuspensionServicio] ([SuspensionId], [actividad], [descricpion], [fecha_suspension], [enlace_documento], [fecha_mod]) VALUES (7, N'T', N'Solicitud cliente', CAST(N'2024-03-07' AS Date), N'suspensiones/2024/SUS007.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[SuspensionServicio] ([SuspensionId], [actividad], [descricpion], [fecha_suspension], [enlace_documento], [fecha_mod]) VALUES (8, N'P', N'Cambio uso suelo', CAST(N'2024-03-08' AS Date), N'suspensiones/2024/SUS008.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[SuspensionServicio] ([SuspensionId], [actividad], [descricpion], [fecha_suspension], [enlace_documento], [fecha_mod]) VALUES (9, N'T', N'Trabajos viales', CAST(N'2024-03-09' AS Date), N'suspensiones/2024/SUS009.pdf', CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[SuspensionServicio] ([SuspensionId], [actividad], [descricpion], [fecha_suspension], [enlace_documento], [fecha_mod]) VALUES (10, N'T', N'Reconexión pendiente', CAST(N'2024-03-10' AS Date), N'suspensiones/2024/SUS010.pdf', CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Servicios].[SuspensionServicio] OFF
GO
SET IDENTITY_INSERT [Servicios].[TicketServicio] ON
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (31, 1, NULL, 1, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (32, 2, NULL, 2, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (33, 3, NULL, 3, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (34, 4, NULL, 4, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (35, 5, NULL, 5, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (36, 6, NULL, 6, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (37, 7, NULL, 7, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (38, 8, NULL, 8, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (39, 9, NULL, 9, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (40, 10, NULL, 10, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (41, 1, 1, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (42, 2, 2, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (43, 3, 3, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (44, 4, 4, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (45, 5, 5, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (46, 6, 6, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (47, 7, 7, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (48, 8, 8, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (49, 9, 9, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (50, 10, 10, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (61, 1, NULL, 1, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (62, 2, NULL, 2, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (63, 3, NULL, 3, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (64, 4, NULL, 4, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (65, 5, NULL, 5, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (66, 6, NULL, 6, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (67, 7, NULL, 7, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (68, 8, NULL, 8, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (69, 9, NULL, 9, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (70, 10, NULL, 10, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (71, 1, 1, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (72, 2, 2, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (73, 3, 3, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (74, 4, 4, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (75, 5, 5, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (76, 6, 6, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (77, 7, 7, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (78, 8, 8, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (79, 9, 9, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (80, 10, 10, NULL, NULL, NULL, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (81, 1, NULL, NULL, NULL, 1, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (82, 2, NULL, NULL, NULL, 2, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (83, 3, NULL, NULL, NULL, 3, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (84, 4, NULL, NULL, NULL, 4, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (85, 5, NULL, NULL, NULL, 5, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (86, 6, NULL, NULL, NULL, 6, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (87, 7, NULL, NULL, NULL, 7, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (88, 8, NULL, NULL, NULL, 8, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (89, 9, NULL, NULL, NULL, 9, CAST(N'2025-04-28' AS Date))
GO
INSERT [Servicios].[TicketServicio] ([ServicioId], [ClienteId], [SuspensionId], [ReporteProblema], [ProgramaDescuento], [CartaNoAdeudos], [fecha_mod]) VALUES (90, 10, NULL, NULL, NULL, 10, CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Servicios].[TicketServicio] OFF
GO
SET IDENTITY_INSERT [Sucursales].[CajeroAutomatico] ON
GO
INSERT [Sucursales].[CajeroAutomatico] ([CajeroId], [EstablecimientoId], [actividad], [fecha_inicio], [fecha_cierre], [horario], [BancoId], [fecha_mod]) VALUES (1, 1, N'A', CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), N'24/7', 1, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[CajeroAutomatico] ([CajeroId], [EstablecimientoId], [actividad], [fecha_inicio], [fecha_cierre], [horario], [BancoId], [fecha_mod]) VALUES (2, 2, N'A', CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), N'06:00-22:00', 2, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[CajeroAutomatico] ([CajeroId], [EstablecimientoId], [actividad], [fecha_inicio], [fecha_cierre], [horario], [BancoId], [fecha_mod]) VALUES (3, 3, N'A', CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), N'24/7', 3, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[CajeroAutomatico] ([CajeroId], [EstablecimientoId], [actividad], [fecha_inicio], [fecha_cierre], [horario], [BancoId], [fecha_mod]) VALUES (4, 4, N'A', CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), N'07:00-21:00', 4, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[CajeroAutomatico] ([CajeroId], [EstablecimientoId], [actividad], [fecha_inicio], [fecha_cierre], [horario], [BancoId], [fecha_mod]) VALUES (5, 5, N'A', CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), N'24/7', 5, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[CajeroAutomatico] ([CajeroId], [EstablecimientoId], [actividad], [fecha_inicio], [fecha_cierre], [horario], [BancoId], [fecha_mod]) VALUES (6, 6, N'I', CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), N'08:00-20:00', 1, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[CajeroAutomatico] ([CajeroId], [EstablecimientoId], [actividad], [fecha_inicio], [fecha_cierre], [horario], [BancoId], [fecha_mod]) VALUES (7, 7, N'A', CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), N'24/7', 2, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[CajeroAutomatico] ([CajeroId], [EstablecimientoId], [actividad], [fecha_inicio], [fecha_cierre], [horario], [BancoId], [fecha_mod]) VALUES (8, 8, N'S', CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), N'07:00-23:00', 3, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[CajeroAutomatico] ([CajeroId], [EstablecimientoId], [actividad], [fecha_inicio], [fecha_cierre], [horario], [BancoId], [fecha_mod]) VALUES (9, 9, N'A', CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), N'24/7', 4, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[CajeroAutomatico] ([CajeroId], [EstablecimientoId], [actividad], [fecha_inicio], [fecha_cierre], [horario], [BancoId], [fecha_mod]) VALUES (10, 10, N'A', CAST(N'2024-01-01' AS Date), CAST(N'2024-12-31' AS Date), N'06:00-22:00', 5, CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Sucursales].[CajeroAutomatico] OFF
GO
SET IDENTITY_INSERT [Sucursales].[Departamento] ON
GO
INSERT [Sucursales].[Departamento] ([DepartamentoId], [descripcion], [segmento_red], [fecha_mod]) VALUES (1, N'Atención al Cliente', N'192.168.1.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Departamento] ([DepartamentoId], [descripcion], [segmento_red], [fecha_mod]) VALUES (2, N'Cobranza', N'192.168.2.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Departamento] ([DepartamentoId], [descripcion], [segmento_red], [fecha_mod]) VALUES (3, N'Operaciones', N'192.168.3.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Departamento] ([DepartamentoId], [descripcion], [segmento_red], [fecha_mod]) VALUES (4, N'Mantenimiento', N'192.168.4.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Departamento] ([DepartamentoId], [descripcion], [segmento_red], [fecha_mod]) VALUES (5, N'Servicios Técnicos', N'192.168.5.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Departamento] ([DepartamentoId], [descripcion], [segmento_red], [fecha_mod]) VALUES (6, N'Contratos', N'192.168.6.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Departamento] ([DepartamentoId], [descripcion], [segmento_red], [fecha_mod]) VALUES (7, N'Facturación', N'192.168.7.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Departamento] ([DepartamentoId], [descripcion], [segmento_red], [fecha_mod]) VALUES (8, N'Medición', N'192.168.8.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Departamento] ([DepartamentoId], [descripcion], [segmento_red], [fecha_mod]) VALUES (9, N'Administración', N'192.168.9.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Departamento] ([DepartamentoId], [descripcion], [segmento_red], [fecha_mod]) VALUES (10, N'Calidad del Agua', N'192.168.10.0/24', CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Sucursales].[Departamento] OFF
GO
SET IDENTITY_INSERT [Sucursales].[Establecimiento] ON
GO
INSERT [Sucursales].[Establecimiento] ([EstablecimientoId], [nombre], [TipoEstablecimientoId], [DomicilioId], [RedId], [DepartamentoId], [fecha_mod]) VALUES (1, N'JAPAMA Central', 1, 36, 1, 1, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Establecimiento] ([EstablecimientoId], [nombre], [TipoEstablecimientoId], [DomicilioId], [RedId], [DepartamentoId], [fecha_mod]) VALUES (2, N'Sucursal Norte', 2, 37, 2, 2, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Establecimiento] ([EstablecimientoId], [nombre], [TipoEstablecimientoId], [DomicilioId], [RedId], [DepartamentoId], [fecha_mod]) VALUES (3, N'Módulo Plaza', 3, 38, 3, 3, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Establecimiento] ([EstablecimientoId], [nombre], [TipoEstablecimientoId], [DomicilioId], [RedId], [DepartamentoId], [fecha_mod]) VALUES (4, N'Centro de Pagos Costa', 4, 39, 4, 4, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Establecimiento] ([EstablecimientoId], [nombre], [TipoEstablecimientoId], [DomicilioId], [RedId], [DepartamentoId], [fecha_mod]) VALUES (5, N'Oficinas Ejecutivas', 5, 40, 5, 5, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Establecimiento] ([EstablecimientoId], [nombre], [TipoEstablecimientoId], [DomicilioId], [RedId], [DepartamentoId], [fecha_mod]) VALUES (6, N'Centro Operativo Sur', 6, 41, 6, 6, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Establecimiento] ([EstablecimientoId], [nombre], [TipoEstablecimientoId], [DomicilioId], [RedId], [DepartamentoId], [fecha_mod]) VALUES (7, N'Almacén General', 7, 42, 7, 7, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Establecimiento] ([EstablecimientoId], [nombre], [TipoEstablecimientoId], [DomicilioId], [RedId], [DepartamentoId], [fecha_mod]) VALUES (8, N'Laboratorio Central', 8, 43, 8, 8, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Establecimiento] ([EstablecimientoId], [nombre], [TipoEstablecimientoId], [DomicilioId], [RedId], [DepartamentoId], [fecha_mod]) VALUES (9, N'Taller Mecánico', 9, 44, 9, 9, CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Establecimiento] ([EstablecimientoId], [nombre], [TipoEstablecimientoId], [DomicilioId], [RedId], [DepartamentoId], [fecha_mod]) VALUES (10, N'Planta Tratadora Norte', 10, 45, 10, 10, CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Sucursales].[Establecimiento] OFF
GO
SET IDENTITY_INSERT [Sucursales].[Red] ON
GO
INSERT [Sucursales].[Red] ([RedId], [compania_red], [segmento_red], [fecha_mod]) VALUES (1, N'Telmex', N'10.10.1.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Red] ([RedId], [compania_red], [segmento_red], [fecha_mod]) VALUES (2, N'TotalPlay', N'10.10.2.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Red] ([RedId], [compania_red], [segmento_red], [fecha_mod]) VALUES (3, N'Megacable', N'10.10.3.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Red] ([RedId], [compania_red], [segmento_red], [fecha_mod]) VALUES (4, N'Izzi', N'10.10.4.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Red] ([RedId], [compania_red], [segmento_red], [fecha_mod]) VALUES (5, N'AT&T', N'10.10.5.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Red] ([RedId], [compania_red], [segmento_red], [fecha_mod]) VALUES (6, N'Axtel', N'10.10.6.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Red] ([RedId], [compania_red], [segmento_red], [fecha_mod]) VALUES (7, N'Alestra', N'10.10.7.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Red] ([RedId], [compania_red], [segmento_red], [fecha_mod]) VALUES (8, N'Telcel', N'10.10.8.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Red] ([RedId], [compania_red], [segmento_red], [fecha_mod]) VALUES (9, N'Movistar', N'10.10.9.0/24', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[Red] ([RedId], [compania_red], [segmento_red], [fecha_mod]) VALUES (10, N'Uninet', N'10.10.10.0/24', CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Sucursales].[Red] OFF
GO
SET IDENTITY_INSERT [Sucursales].[TipoEstablecimiento] ON
GO
INSERT [Sucursales].[TipoEstablecimiento] ([TipoEstablecimientId], [nombre], [fecha_mod]) VALUES (1, N'Oficina Principal', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[TipoEstablecimiento] ([TipoEstablecimientId], [nombre], [fecha_mod]) VALUES (2, N'Sucursal', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[TipoEstablecimiento] ([TipoEstablecimientId], [nombre], [fecha_mod]) VALUES (3, N'Módulo de Atención', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[TipoEstablecimiento] ([TipoEstablecimientId], [nombre], [fecha_mod]) VALUES (4, N'Centro de Pago', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[TipoEstablecimiento] ([TipoEstablecimientId], [nombre], [fecha_mod]) VALUES (5, N'Oficina Administrativa', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[TipoEstablecimiento] ([TipoEstablecimientId], [nombre], [fecha_mod]) VALUES (6, N'Centro Operativo', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[TipoEstablecimiento] ([TipoEstablecimientId], [nombre], [fecha_mod]) VALUES (7, N'Almacén', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[TipoEstablecimiento] ([TipoEstablecimientId], [nombre], [fecha_mod]) VALUES (8, N'Laboratorio', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[TipoEstablecimiento] ([TipoEstablecimientId], [nombre], [fecha_mod]) VALUES (9, N'Taller', CAST(N'2025-04-28' AS Date))
GO
INSERT [Sucursales].[TipoEstablecimiento] ([TipoEstablecimientId], [nombre], [fecha_mod]) VALUES (10, N'Planta de Tratamiento', CAST(N'2025-04-28' AS Date))
GO
SET IDENTITY_INSERT [Sucursales].[TipoEstablecimiento] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Email__2A586E0BA3388116]    Script Date: 31/05/2025 12:55:37 a. m. ******/
ALTER TABLE [Personas].[Email] ADD UNIQUE NONCLUSTERED
    (
     [correo] ASC
        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__NumeroTe__FC77F211C53218A2]    Script Date: 31/05/2025 12:55:37 a. m. ******/
ALTER TABLE [Personas].[NumeroTelefonico] ADD UNIQUE NONCLUSTERED
    (
     [numero] ASC
        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Empleado__C2B034940758BC18]    Script Date: 31/05/2025 12:55:37 a. m. ******/
ALTER TABLE [RecursosHumanos].[Empleado] ADD UNIQUE NONCLUSTERED
    (
     [rfc] ASC
        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Empleado__DF90FDB17D52935F]    Script Date: 31/05/2025 12:55:37 a. m. ******/
ALTER TABLE [RecursosHumanos].[Empleado] ADD UNIQUE NONCLUSTERED
    (
     [nss] ASC
        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_EMPLEADOS_ESTABLECIMIENTO]    Script Date: 31/05/2025 12:55:37 a. m. ******/
CREATE NONCLUSTERED INDEX [IX_EMPLEADOS_ESTABLECIMIENTO] ON [RecursosHumanos].[Empleado]
    (
     [EstablecimientoId] ASC
        )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [Auditoria].[BitacoraModificaciones] ADD  DEFAULT (getdate()) FOR [FechaModificacion]
GO
ALTER TABLE [Auditoria].[RegistroAccesoBD] ADD  DEFAULT (getdate()) FOR [fecha_acceso]
GO
ALTER TABLE [Clientes].[MetodoPago] ADD  DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [Clientes].[MetodoPago] ADD  DEFAULT ((0)) FOR [requiere_comprobante]
GO
ALTER TABLE [Auditoria].[HistorialModSueldos]  WITH CHECK ADD FOREIGN KEY([PuestoId])
    REFERENCES [RecursosHumanos].[Puesto] ([PuestoId])
GO
ALTER TABLE [Auditoria].[ModificacionInventario]  WITH CHECK ADD FOREIGN KEY([ProductId])
    REFERENCES [Inventarios].[Inventario] ([ProductoId])
GO
ALTER TABLE [Clientes].[Adeudos]  WITH CHECK ADD  CONSTRAINT [FK_Adeudo_Establecimiento] FOREIGN KEY([EstablecimientoId])
    REFERENCES [Sucursales].[Establecimiento] ([EstablecimientoId])
GO
ALTER TABLE [Clientes].[Adeudos] CHECK CONSTRAINT [FK_Adeudo_Establecimiento]
GO
ALTER TABLE [Clientes].[Adeudos]  WITH CHECK ADD  CONSTRAINT [FK_CargoId] FOREIGN KEY([CargoId])
    REFERENCES [Clientes].[CargoServicio] ([CargoId])
GO
ALTER TABLE [Clientes].[Adeudos] CHECK CONSTRAINT [FK_CargoId]
GO
ALTER TABLE [Clientes].[Adeudos]  WITH CHECK ADD  CONSTRAINT [FK_ClienteId] FOREIGN KEY([ClienteId])
    REFERENCES [Clientes].[Cliente] ([ClienteId])
GO
ALTER TABLE [Clientes].[Adeudos] CHECK CONSTRAINT [FK_ClienteId]
GO
ALTER TABLE [Clientes].[Adeudos]  WITH CHECK ADD  CONSTRAINT [FK_ConsumoId] FOREIGN KEY([ConsumoId])
    REFERENCES [Clientes].[Consumo] ([ConsumoId])
GO
ALTER TABLE [Clientes].[Adeudos] CHECK CONSTRAINT [FK_ConsumoId]
GO
ALTER TABLE [Clientes].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_Persona] FOREIGN KEY([PersonaId])
    REFERENCES [Personas].[Persona] ([PersonaId])
GO
ALTER TABLE [Clientes].[Cliente] CHECK CONSTRAINT [FK_Cliente_Persona]
GO
ALTER TABLE [Clientes].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_ContratoId] FOREIGN KEY([ContratoId])
    REFERENCES [Clientes].[Contrato] ([ContratoId])
GO
ALTER TABLE [Clientes].[Cliente] CHECK CONSTRAINT [FK_ContratoId]
GO
ALTER TABLE [Clientes].[Comprobante]  WITH CHECK ADD  CONSTRAINT [FK_Comprobante_Pago] FOREIGN KEY([PagoId])
    REFERENCES [Clientes].[Pago] ([PagoId])
GO
ALTER TABLE [Clientes].[Comprobante] CHECK CONSTRAINT [FK_Comprobante_Pago]
GO
ALTER TABLE [Clientes].[Contrato]  WITH CHECK ADD  CONSTRAINT [FK_TipoTarifaId] FOREIGN KEY([TipoTarifaId])
    REFERENCES [Clientes].[TipoTarifa] ([TipoTarifaId])
GO
ALTER TABLE [Clientes].[Contrato] CHECK CONSTRAINT [FK_TipoTarifaId]
GO
ALTER TABLE [Clientes].[Pago]  WITH CHECK ADD  CONSTRAINT [FK_Pago_Adeudo] FOREIGN KEY([AdeudoId])
    REFERENCES [Clientes].[Adeudos] ([AdeudoId])
GO
ALTER TABLE [Clientes].[Pago] CHECK CONSTRAINT [FK_Pago_Adeudo]
GO
ALTER TABLE [Clientes].[Pago]  WITH CHECK ADD  CONSTRAINT [FK_Pago_Cliente] FOREIGN KEY([ClienteId])
    REFERENCES [Clientes].[Cliente] ([ClienteId])
GO
ALTER TABLE [Clientes].[Pago] CHECK CONSTRAINT [FK_Pago_Cliente]
GO
ALTER TABLE [Clientes].[Pago]  WITH CHECK ADD  CONSTRAINT [FK_Pago_MetodoPago] FOREIGN KEY([MetodoPagoId])
    REFERENCES [Clientes].[MetodoPago] ([MetodoPagoId])
GO
ALTER TABLE [Clientes].[Pago] CHECK CONSTRAINT [FK_Pago_MetodoPago]
GO
ALTER TABLE [Clientes].[PagoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PagoDetalle_Adeudo] FOREIGN KEY([AdeudoId])
    REFERENCES [Clientes].[Adeudos] ([AdeudoId])
GO
ALTER TABLE [Clientes].[PagoDetalle] CHECK CONSTRAINT [FK_PagoDetalle_Adeudo]
GO
ALTER TABLE [Clientes].[PagoDetalle]  WITH CHECK ADD  CONSTRAINT [FK_PagoDetalle_Pago] FOREIGN KEY([PagoId])
    REFERENCES [Clientes].[Pago] ([PagoId])
GO
ALTER TABLE [Clientes].[PagoDetalle] CHECK CONSTRAINT [FK_PagoDetalle_Pago]
GO
ALTER TABLE [Clientes].[PagoEstatus]  WITH CHECK ADD  CONSTRAINT [FK_PagoEstatus_Estatus] FOREIGN KEY([EstatusId])
    REFERENCES [Clientes].[EstatusPago] ([EstatusId])
GO
ALTER TABLE [Clientes].[PagoEstatus] CHECK CONSTRAINT [FK_PagoEstatus_Estatus]
GO
ALTER TABLE [Clientes].[PagoEstatus]  WITH CHECK ADD  CONSTRAINT [FK_PagoEstatus_Pago] FOREIGN KEY([PagoId])
    REFERENCES [Clientes].[Pago] ([PagoId])
GO
ALTER TABLE [Clientes].[PagoEstatus] CHECK CONSTRAINT [FK_PagoEstatus_Pago]
GO
ALTER TABLE [Clientes].[TipoTarifa]  WITH CHECK ADD  CONSTRAINT [FK_TarifaId] FOREIGN KEY([TarifaId])
    REFERENCES [Clientes].[Tarifa] ([TarifaId])
GO
ALTER TABLE [Clientes].[TipoTarifa] CHECK CONSTRAINT [FK_TarifaId]
GO
ALTER TABLE [Inventarios].[Compra]  WITH CHECK ADD FOREIGN KEY([FacturaId])
    REFERENCES [Inventarios].[Facturacion] ([FacturaId])
GO
ALTER TABLE [Inventarios].[Compra]  WITH CHECK ADD FOREIGN KEY([ProductoId])
    REFERENCES [Inventarios].[Inventario] ([ProductoId])
GO
ALTER TABLE [Inventarios].[Compra]  WITH CHECK ADD FOREIGN KEY([ProveedorId])
    REFERENCES [Inventarios].[Proveedor] ([ProveedorId])
GO
ALTER TABLE [Inventarios].[Facturacion]  WITH CHECK ADD  CONSTRAINT [FK_Facturacion_Establecimiento] FOREIGN KEY([EstablecimientoId])
    REFERENCES [Sucursales].[Establecimiento] ([EstablecimientoId])
GO
ALTER TABLE [Inventarios].[Facturacion] CHECK CONSTRAINT [FK_Facturacion_Establecimiento]
GO
ALTER TABLE [Inventarios].[Inventario]  WITH CHECK ADD FOREIGN KEY([MaterialId])
    REFERENCES [Inventarios].[Material] ([MaterialId])
GO
ALTER TABLE [Inventarios].[Inventario]  WITH CHECK ADD FOREIGN KEY([MobiliarioId])
    REFERENCES [Inventarios].[Mobiliario] ([MobiliarioId])
GO
ALTER TABLE [Inventarios].[Inventario]  WITH CHECK ADD FOREIGN KEY([VehiculoId])
    REFERENCES [Inventarios].[Vehiculo] ([VehiculoId])
GO
ALTER TABLE [Inventarios].[Material]  WITH CHECK ADD FOREIGN KEY([TipoMaterialId])
    REFERENCES [Inventarios].[TipoMaterial] ([TipoMaterialId])
GO
ALTER TABLE [Inventarios].[Mobiliario]  WITH CHECK ADD FOREIGN KEY([TipoMobiliarioId])
    REFERENCES [Inventarios].[TipoMobiliario] ([TipoMobiliarioId])
GO
ALTER TABLE [Inventarios].[Proveedor]  WITH CHECK ADD  CONSTRAINT [FK_Proveedor_Persona] FOREIGN KEY([PersonaId])
    REFERENCES [Personas].[Persona] ([PersonaId])
GO
ALTER TABLE [Inventarios].[Proveedor] CHECK CONSTRAINT [FK_Proveedor_Persona]
GO
ALTER TABLE [Inventarios].[ReporteVehiculo]  WITH CHECK ADD FOREIGN KEY([TallerId])
    REFERENCES [Inventarios].[TallerVehiculo] ([TallerId])
GO
ALTER TABLE [Inventarios].[ReporteVehiculo]  WITH CHECK ADD FOREIGN KEY([VehiculoId])
    REFERENCES [Inventarios].[Vehiculo] ([VehiculoId])
GO
ALTER TABLE [Inventarios].[TallerVehiculo]  WITH CHECK ADD  CONSTRAINT [FK_Taller_Persona] FOREIGN KEY([PersonaId])
    REFERENCES [Personas].[Persona] ([PersonaId])
GO
ALTER TABLE [Inventarios].[TallerVehiculo] CHECK CONSTRAINT [FK_Taller_Persona]
GO
ALTER TABLE [Inventarios].[Vehiculo]  WITH CHECK ADD FOREIGN KEY([TipoVehiculoId])
    REFERENCES [Inventarios].[TipoVehiculo] ([TipoVehiculoId])
GO
ALTER TABLE [Inventarios].[Vehiculo]  WITH CHECK ADD  CONSTRAINT [FK_EstablecimientoId] FOREIGN KEY([EstablecimientoId])
    REFERENCES [Sucursales].[Establecimiento] ([EstablecimientoId])
GO
ALTER TABLE [Inventarios].[Vehiculo] CHECK CONSTRAINT [FK_EstablecimientoId]
GO
ALTER TABLE [Inventarios].[Vehiculo]  WITH CHECK ADD  CONSTRAINT [FK_Vehiculo_Establecimiento] FOREIGN KEY([EstablecimientoId])
    REFERENCES [Sucursales].[Establecimiento] ([EstablecimientoId])
GO
ALTER TABLE [Inventarios].[Vehiculo] CHECK CONSTRAINT [FK_Vehiculo_Establecimiento]
GO
ALTER TABLE [Personas].[Domicilio]  WITH CHECK ADD FOREIGN KEY([LocalidadId])
    REFERENCES [Personas].[Localidad] ([LocalidadId])
GO
ALTER TABLE [Personas].[Domicilio]  WITH CHECK ADD FOREIGN KEY([SectorId])
    REFERENCES [Personas].[Sector] ([SectorId])
GO
ALTER TABLE [Personas].[Domicilio]  WITH CHECK ADD FOREIGN KEY([TipoDomicilioId])
    REFERENCES [Personas].[TipoDomicilio] ([TipoDomicilioId])
GO
ALTER TABLE [Personas].[NumeroTelefonico]  WITH CHECK ADD FOREIGN KEY([TipoNumeroId])
    REFERENCES [Personas].[TipoNumero] ([TipoNumeroId])
GO
ALTER TABLE [Personas].[Persona]  WITH CHECK ADD FOREIGN KEY([EmailId])
    REFERENCES [Personas].[Email] ([EmailId])
GO
ALTER TABLE [Personas].[Persona]  WITH CHECK ADD FOREIGN KEY([NumeroTelId])
    REFERENCES [Personas].[NumeroTelefonico] ([NumeroTelId])
GO
ALTER TABLE [Personas].[Sector]  WITH CHECK ADD FOREIGN KEY([LocalidadId])
    REFERENCES [Personas].[Localidad] ([LocalidadId])
GO
ALTER TABLE [Personas].[Sector]  WITH CHECK ADD FOREIGN KEY([TipoSectorId])
    REFERENCES [Personas].[TipoSector] ([TipoSectorId])
GO
ALTER TABLE [RecursosHumanos].[Empleado]  WITH CHECK ADD FOREIGN KEY([ContratoId])
    REFERENCES [RecursosHumanos].[ContratoEmpleado] ([ContratoId])
GO
ALTER TABLE [RecursosHumanos].[Empleado]  WITH CHECK ADD FOREIGN KEY([NominaId])
    REFERENCES [RecursosHumanos].[Nomina] ([NominaId])
GO
ALTER TABLE [RecursosHumanos].[Empleado]  WITH CHECK ADD FOREIGN KEY([PuestoId])
    REFERENCES [RecursosHumanos].[Puesto] ([PuestoId])
GO
ALTER TABLE [RecursosHumanos].[Empleado]  WITH CHECK ADD FOREIGN KEY([TurnoId])
    REFERENCES [RecursosHumanos].[Turno] ([TurnoId])
GO
ALTER TABLE [RecursosHumanos].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_Persona] FOREIGN KEY([PersonaId])
    REFERENCES [Personas].[Persona] ([PersonaId])
GO
ALTER TABLE [RecursosHumanos].[Empleado] CHECK CONSTRAINT [FK_Empleado_Persona]
GO
ALTER TABLE [RecursosHumanos].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_EstablecimientoId] FOREIGN KEY([EstablecimientoId])
    REFERENCES [Sucursales].[Establecimiento] ([EstablecimientoId])
GO
ALTER TABLE [RecursosHumanos].[Empleado] CHECK CONSTRAINT [FK_EstablecimientoId]
GO
ALTER TABLE [RecursosHumanos].[HistorialAsistencia]  WITH CHECK ADD FOREIGN KEY([EmpleadoId])
    REFERENCES [RecursosHumanos].[Empleado] ([EmpleadoId])
GO
ALTER TABLE [RecursosHumanos].[Nomina]  WITH CHECK ADD FOREIGN KEY([BancoId])
    REFERENCES [RecursosHumanos].[Banco] ([BancoId])
GO
ALTER TABLE [RecursosHumanos].[Sindicato]  WITH CHECK ADD FOREIGN KEY([EmpleadoId])
    REFERENCES [RecursosHumanos].[Empleado] ([EmpleadoId])
GO
ALTER TABLE [RecursosHumanos].[Sindicato]  WITH CHECK ADD FOREIGN KEY([PuestoSindicatoId])
    REFERENCES [RecursosHumanos].[PuestoSindicato] ([PuestoSindicatoId])
GO
ALTER TABLE [Servicios].[TicketServicio]  WITH CHECK ADD  CONSTRAINT [FK_CartaNoAdeudos] FOREIGN KEY([CartaNoAdeudos])
    REFERENCES [Servicios].[CartaNoAdeudos] ([CartaId])
GO
ALTER TABLE [Servicios].[TicketServicio] CHECK CONSTRAINT [FK_CartaNoAdeudos]
GO
ALTER TABLE [Servicios].[TicketServicio]  WITH CHECK ADD  CONSTRAINT [FK_ProgramaDescuento] FOREIGN KEY([ProgramaDescuento])
    REFERENCES [Servicios].[ProgramaDescuento] ([ProgramaId])
GO
ALTER TABLE [Servicios].[TicketServicio] CHECK CONSTRAINT [FK_ProgramaDescuento]
GO
ALTER TABLE [Servicios].[TicketServicio]  WITH CHECK ADD  CONSTRAINT [FK_ReporteProblema] FOREIGN KEY([ReporteProblema])
    REFERENCES [Servicios].[ReporteProblema] ([ReporteId])
GO
ALTER TABLE [Servicios].[TicketServicio] CHECK CONSTRAINT [FK_ReporteProblema]
GO
ALTER TABLE [Servicios].[TicketServicio]  WITH CHECK ADD  CONSTRAINT [FK_ServicioId] FOREIGN KEY([SuspensionId])
    REFERENCES [Servicios].[SuspensionServicio] ([SuspensionId])
GO
ALTER TABLE [Servicios].[TicketServicio] CHECK CONSTRAINT [FK_ServicioId]
GO
ALTER TABLE [Servicios].[TicketServicio]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Cliente] FOREIGN KEY([ClienteId])
    REFERENCES [Clientes].[Cliente] ([ClienteId])
GO
ALTER TABLE [Servicios].[TicketServicio] CHECK CONSTRAINT [FK_Ticket_Cliente]
GO
ALTER TABLE [Sucursales].[CajeroAutomatico]  WITH CHECK ADD FOREIGN KEY([EstablecimientoId])
    REFERENCES [Sucursales].[Establecimiento] ([EstablecimientoId])
GO
ALTER TABLE [Sucursales].[CajeroAutomatico]  WITH CHECK ADD  CONSTRAINT [FK_Cajero_Banco] FOREIGN KEY([BancoId])
    REFERENCES [RecursosHumanos].[Banco] ([BancoId])
GO
ALTER TABLE [Sucursales].[CajeroAutomatico] CHECK CONSTRAINT [FK_Cajero_Banco]
GO
ALTER TABLE [Sucursales].[Establecimiento]  WITH CHECK ADD FOREIGN KEY([DepartamentoId])
    REFERENCES [Sucursales].[Departamento] ([DepartamentoId])
GO
ALTER TABLE [Sucursales].[Establecimiento]  WITH CHECK ADD FOREIGN KEY([RedId])
    REFERENCES [Sucursales].[Red] ([RedId])
GO
ALTER TABLE [Sucursales].[Establecimiento]  WITH CHECK ADD FOREIGN KEY([TipoEstablecimientoId])
    REFERENCES [Sucursales].[TipoEstablecimiento] ([TipoEstablecimientId])
GO
ALTER TABLE [Sucursales].[Establecimiento]  WITH CHECK ADD  CONSTRAINT [FK_Establecimiento_Domicilio] FOREIGN KEY([DomicilioId])
    REFERENCES [Personas].[Domicilio] ([DomicilioId])
GO
ALTER TABLE [Sucursales].[Establecimiento] CHECK CONSTRAINT [FK_Establecimiento_Domicilio]
GO
ALTER TABLE [Clientes].[Cliente]  WITH CHECK ADD  CONSTRAINT [actividad] CHECK  (([actividad]='P' OR [actividad]='T' OR [actividad]='A'))
GO
ALTER TABLE [Clientes].[Cliente] CHECK CONSTRAINT [actividad]
GO
ALTER TABLE [Servicios].[SuspensionServicio]  WITH CHECK ADD  CONSTRAINT [actividad] CHECK  (([actividad]='P' OR [actividad]='T'))
GO
ALTER TABLE [Servicios].[SuspensionServicio] CHECK CONSTRAINT [actividad]
GO
ALTER TABLE [Sucursales].[CajeroAutomatico]  WITH CHECK ADD  CONSTRAINT [actividad] CHECK  (([actividad]='S' OR [actividad]='I' OR [actividad]='A'))
GO
ALTER TABLE [Sucursales].[CajeroAutomatico] CHECK CONSTRAINT [actividad]
GO
/****** Object:  StoredProcedure [Auditoria].[Fecha_Mod_Trigger_ALL]    Script Date: 31/05/2025 12:55:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Auditoria].[Fecha_Mod_Trigger_ALL]
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
/****** Object:  StoredProcedure [Auditoria].[TR_BITACORA_MOD_ALL]    Script Date: 31/05/2025 12:55:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Auditoria].[TR_BITACORA_MOD_ALL]
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
/****** Object:  StoredProcedure [Clientes].[InsertarAdeudoConConsumo]    Script Date: 31/05/2025 12:55:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 8.- Insertar Adeudo
CREATE   PROCEDURE [Clientes].[InsertarAdeudoConConsumo]
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
/****** Object:  StoredProcedure [Clientes].[InsertarCliente]    Script Date: 31/05/2025 12:55:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 1.- Insertar clientes
CREATE   PROCEDURE [Clientes].[InsertarCliente]
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
/****** Object:  StoredProcedure [Inventarios].[InsertarCompra]    Script Date: 31/05/2025 12:55:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Inventarios].[InsertarCompra] @ProductoId INT, @FacturaId BIGINT, @ProveedorId INT, @Monto MONEY,
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
/****** Object:  StoredProcedure [Inventarios].[InsertarProducto]    Script Date: 31/05/2025 12:55:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 4.- Insertar producto
CREATE   PROCEDURE [Inventarios].[InsertarProducto] @Nombre varchar(50), @Descripcion varchar(50),
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
/****** Object:  StoredProcedure [Inventarios].[InsertarProveedor]    Script Date: 31/05/2025 12:55:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 3.- Insertar proveedor
CREATE   PROCEDURE [Inventarios].[InsertarProveedor]
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
/****** Object:  StoredProcedure [Inventarios].[InsertarReporteVehiculo]    Script Date: 31/05/2025 12:55:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 6.- Insertar reporteVehiculo
CREATE   PROCEDURE [Inventarios].[InsertarReporteVehiculo] @VehiculoId INT, @TallerId INT, @Descripcion VARCHAR(100)
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
/****** Object:  StoredProcedure [RecursosHumanos].[InsertarEmpleado]    Script Date: 31/05/2025 12:55:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- 2.- Insertar empleado
CREATE   PROCEDURE [RecursosHumanos].[InsertarEmpleado]
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
/****** Object:  StoredProcedure [Servicios].[InsertarTicketSoporte]    Script Date: 31/05/2025 12:55:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [Servicios].[InsertarTicketSoporte]
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
/****** Object:  DdlTrigger [TG_REGISTRO_MOVS]    Script Date: 31/05/2025 12:55:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [TG_REGISTRO_MOVS]
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

END
GO
ENABLE TRIGGER [TG_REGISTRO_MOVS] ON DATABASE
GO
USE [master]
GO
ALTER DATABASE [BD_JAPAMA] SET  READ_WRITE
GO
