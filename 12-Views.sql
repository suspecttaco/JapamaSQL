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
CREATE VIEW RecursosHumanos.V1_ListaEmpleadosActivos AS
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
WHERE e.Actividad = 'A';
GO
--2.-Lista clientes Activos
CREATE VIEW Clientes.V2_ListaClientes AS
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
--3.-Contratos activos
CREATE VIEW Servicios.V3_ContratosActivos AS
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
--4.-Lista inventario actual
CREATE VIEW Inventarios.V4_ListaInventarioActual AS
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
--	INNER JOIN Inventarios.TipoMaterial tmat ON inv.MaterialId = tmat.TipoMaterialId
--	INNER JOIN Inventarios.TipoMobiliario tmob ON inv.MobiliarioId = tmob.TipoMobiliarioId
--	INNER JOIN Inventarios.TipoVehiculo tveh ON inv.VehiculoId = tveh.TipoVehiculoId
GO
--5.-Lista proveedores
CREATE VIEW Inventarios.V5_ListaProveedores AS
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
--	INNER JOIN Personas.NumeroTelefonico tel ON pro.PersonaId = tel.NumeroTelId
GO
--6.-Historial reportes (cliente y donde fue)
CREATE VIEW Servicios.V6_ListaReportes AS
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
--7.-Lista sucursales (por tipo)
CREATE VIEW Sucursales.V7_ListaSucursaleTipo AS
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
--8 - 10.-Lista empleados (tipo de contrato) *3
CREATE VIEW RecursosHumanos.V8_EmpleadosSindicato AS
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
WHERE ctemp.tipo_contrato = 'SIN';
GO

CREATE VIEW RecursosHumanos.V9_EmpleadosConfianza AS
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
WHERE ctemp.tipo_contrato = 'CON';
GO

CREATE VIEW RecursosHumanos.V10_EmpleadosEventuaales AS
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
WHERE ctemp.tipo_contrato = 'EVE';
GO
--11.-Lista clientes cartaNoAdeudos

CREATE VIEW Servicios.V11_ListaClientesCartaNoAdeudos AS
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
--12.-Lista clientes suspension (info solicitud)
CREATE VIEW Servicios.V12_ListaClientesSuspension AS
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
--13.-Lista vehiculos (por sucursal)
CREATE VIEW Inventarios.V13_ListaVehiculosSucursal AS
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
--14 - 16.-Lista empleados (por turno especifico) *3 (solo activos)
CREATE VIEW RecursosHumanos.V14_ListaEmpleadoMatutino AS
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
WHERE etrn.tipo = 'MAT';
GO
CREATE VIEW RecursosHumanos.V15_ListaEmpleadoVespertino AS
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
WHERE etrn.tipo = 'VES';
GO
CREATE VIEW RecursosHumanos.V16_ListaEmpleadoNocturno AS
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
WHERE etrn.tipo = 'NOC';
GO