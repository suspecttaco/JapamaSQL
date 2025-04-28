--         SCALABLE FUNCTION. -
-- 1.- Total de asistencias
CREATE FUNCTION RecursosHumanos.FC_TotalAsistenciasEmpleados 
(@EmpleadoID BIGINT) returns BIGINT AS 
BEGIN
	DECLARE @Asistencias BIGINT
	SET @Asistencias = (SELECT COUNT(*) FROM RecursosHumanos.Empleado
	WHERE RecursosHumanos.Empleado.EmpleadoId = @EmpleadoID);
	RETURN @Asistencias
END;
GO
-- 2.- Total de usuarios activos
CREATE FUNCTION Clientes.FC_TotalUsuariosActivos() 
RETURNS BIGINT AS
BEGIN
	DECLARE @TotalActivos BIGINT
	SET @TotalActivos = (SELECT COUNT(*) FROM Clientes.Cliente
						WHERE Clientes.Cliente.actividad = 'A')
	RETURN @TotalActivos
END;
GO
-- 3.- Total de retardos
CREATE FUNCTION RecursosHumanos.FC_TotalRetardosEmp
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
END;
GO
-- 4.- Total de tipo de persona fisica/moral
CREATE FUNCTION Personas.FC_TotalPersonaFisicaMoral
(@tipo VARCHAR(1)) RETURNS INT AS
BEGIN
	DECLARE @TotalPersona INT
	SET @TotalPersona = (SELECT COUNT(*) FROM Personas.Persona 
	WHERE Personas.Persona.tipo_persona = @tipo);
	RETURN @TotalPersona
END;
GO

-- FUNCTION WITH VALUES TABLE
-- 1.- Numero de  Empleados/contrato especifico

-- 2.- Historial de asistencia detallado por periodo (fecha inicio -> fecha fin)