use BD_JAPAMA
go
-- SYNONYMS
-- 1.- RH -> recursos humanos (recursos inhumanos)
create synonym Trabajadores for RecursosHumanos.Empleado
-- 2.- Cliente -> Usuario
create synonym Usuarios for Clientes.Cliente
-- Indice que permita agilizar alguna consulta **PENDIENTE**
-- 1.- PENDIENTE