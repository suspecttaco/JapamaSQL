USE BD_JAPAMA
GO
-- SYNONYMS
-- 1.- RH -> recursos humanos (recursos inhumanos)
CREATE SYNONYM RecursosHumanos.Trabajadores FOR RecursosHumanos.Empleado
-- 2.- Cliente -> Usuario
CREATE SYNONYM Clientes.Usuarios FOR Clientes.Cliente
-- Indice que permita agilizar alguna consulta **PENDIENTE**
-- 1.- Indice filtrar Empleados por establecimiento
CREATE NONCLUSTERED INDEX IX_EMPLEADOS_ESTABLECIMIENTO ON RecursosHumanos.Empleado (EstablecimientoId)
GO
