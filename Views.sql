--- EJEMPLO

-- CREATE VIEW RH.vw_EmpleadosActivos
-- AS
-- SELECT
--     e.EmpleadoId,
--     e.rfc,
--     e.nss,
--     p.nombre,
--     p.apellido_paterno,
--     p.apellido_materno,
--     d.nombre AS Departamento,
--     pu.descripcion AS Puesto
-- FROM RecursosHumanos.Empleado e
--          INNER JOIN Personas.Persona p ON e.PersonaId = p.PersonaId
--          INNER JOIN RecursosHumanos.Departamento d ON e.DepartamentoId = d.DepartamentoId
--        INNER JOIN RecursosHumanos.Puesto pu ON e.PuestoId = pu.PuestoId
-- WHERE e.estatus = 'A';
-- GO

--1.-Lista empleados Activos
CREATE VIEW RecursosHumanos.V1_ListaEmpleadosActivos AS SELECT 
    e.EmpleadoId,
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
WHERE e.Actividad = 'A';
GO
--2.-Lista clientes Activos
CREATE VIEW Clientes.V2_ListaClientes AS SELECT
	c.ClienteId,
	p.PersonaId,
	p.apellido1,
	p.apellido2,
	p.nombre,
	p.tipo_persona,
	c.ContratoId
FROM Clientes.Cliente c
	INNER JOIN Personas.Persona p ON c.PersonaId = p.PersonaId
GO
--3.-Contratos activos
CREATE VIEW Servicios.V3_ContratosActivos AS SELECT
	ss.ClienteId,
	cl.PersonaId,
	cl.ContratoId,
	cnt.TipoTarifaId,
	ss.actividad,
	cl.fecha_corte,
	ss.fecha_suspension,
	cnt.fecha_contrato,
	cnt.medidor
FROM Servicios.SuspensionServicio ss
	INNER JOIN Clientes.Cliente cl ON ss.ClienteId = cl.ClienteId
	INNER JOIN Clientes.Contrato cnt ON ss.ClienteId = cnt.ContratoId
WHERE ss.actividad IS NULL
GO
--4.-Lista inventario actual
CREATE VIEW Inventarios.V4_ListaInventarioActual AS SELECT
	inv.ProductoId,
	inv.MaterialId,
	inv.MobiliarioId,
	inv.VehiculoId,
	mat.TipoMaterialId,
	mat.descripcion AS Material,
	mat.actividad AS mat,
	mob.TipoMobiliarioId,
	mob.descripcion AS Mobiliario,
	mob.actividad AS mob,
	veh.TipoVehiculoId,
	veh.matricula,
	veh.EstablecimientoId,
	veh.actividad AS veh
FROM Inventarios.Inventario inv
	INNER JOIN Inventarios.Material mat ON inv.MaterialId = mat.MaterialId
	INNER JOIN Inventarios.Mobiliario mob ON inv.MobiliarioId = mob.MobiliarioId
	INNER JOIN Inventarios.Vehiculo veh ON inv.VehiculoId = veh.VehiculoId
--	INNER JOIN Inventarios.TipoMaterial tmat ON inv.MaterialId = tmat.TipoMaterialId
--	INNER JOIN Inventarios.TipoMobiliario tmob ON inv.MobiliarioId = tmob.TipoMobiliarioId
--	INNER JOIN Inventarios.TipoVehiculo tveh ON inv.VehiculoId = tveh.TipoVehiculoId
GO
--5.-Lista proveedores

--6.-Historial reportes (cliente y donde fue)

--7.-Lista sucursales (por tipo)

--8.-Lista empleados (tipo de contrato)

--9.-Lista empledos sindicato

--10.-Lista clientes cartaNoAdeudos

--11.-Lista clientes suspension (info solicitud)

--12.-Lista vehiculos (por sucursal)

--13 - 15.-Lista empleados (por turno especifico) *3 (solo activos)