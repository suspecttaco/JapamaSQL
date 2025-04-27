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

