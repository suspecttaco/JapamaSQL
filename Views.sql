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

--1.-Lista empleados

--2.-Lista clientes

--3.-Contratos activos

--4.-Lista inventario actual

--5.-Lista proveedores

--6.-Historial reportes (cliente y donde fue)

--7.-Lista sucursales (por tipo)

--8.-Lista empleados (tipo de contrato)

--9.-Lista empledos sindicato

--10.-Lista clientes cartaNoAdeudos

--11.-Lista clientes suspension (info solicitud)

--12.-Lista vehiculos (por sucursal)

--13 - 15.-Lista empleados (por turno especifico) *3 (solo activos)