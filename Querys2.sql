-- 1. Obtener todos los clientes domésticos con sus consumos del último mes
SELECT p.nombre, p.apellido1, c.medidor, co.consumo_m3, co.periodo_lectura
FROM Clientes.Cliente cl
JOIN Personas.Persona p ON cl.PersonaId = p.PersonaId
JOIN Clientes.Contrato c ON cl.ContratoId = c.ContratoId
JOIN Clientes.Consumo co ON cl.ClienteId = co.ConsumoId
WHERE c.TipoTarifaId = 1
AND co.periodo_lectura = '2024-03-31';

-- 2. Listar empleados sindicalizados con sus puestos y salarios
SELECT p.nombre, p.apellido1, pu.descripcion, pu.salario_base, ps.nombre AS puesto_sindical
FROM RecursosHumanos.Empleado e
JOIN Personas.Persona p ON e.PersonaId = p.PersonaId
JOIN RecursosHumanos.Puesto pu ON e.PuestoId = pu.PuestoId
JOIN RecursosHumanos.Sindicato s ON e.EmpleadoId = s.EmpleadoId
JOIN RecursosHumanos.PuestoSindicato ps ON s.PuestoSindicatoId = ps.PuestoSindicatoId;

-- 3. Mostrar todos los vehículos con reportes de mantenimiento
SELECT v.matricula, tv.nombre AS tipo, rv.descripcion, rv.fecha_reporte
FROM Inventarios.Vehiculo v
JOIN Inventarios.TipoVehiculo tv ON v.TipoVehiculoId = tv.TipoVehiculoId
JOIN Inventarios.ReporteVehiculo rv ON v.VehiculoId = rv.VehiculoId;

-- 4. Obtener total de adeudos por cliente
SELECT p.nombre, p.apellido1, SUM(a.adeudo_actual) as total_adeudo
FROM Clientes.Adeudos a
JOIN Clientes.Cliente c ON a.ClienteId = c.ClienteId
JOIN Personas.Persona p ON c.PersonaId = p.PersonaId
GROUP BY p.nombre, p.apellido1;

-- 5. Listar establecimientos con sus cajeros automáticos
SELECT e.nombre AS establecimiento, b.nombre AS banco, ca.horario
FROM Sucursales.Establecimiento e
JOIN Sucursales.CajeroAutomatico ca ON e.EstablecimientoId = ca.EstablecimientoId
JOIN RecursosHumanos.Banco b ON ca.BancoId = b.BancoId;

-- 6. Mostrar inventario de materiales bajo stock (menos de 50 unidades)
SELECT m.nombre, tm.descripcion, i.cantidad
FROM Inventarios.Inventario i
JOIN Inventarios.Material m ON i.MaterialId = m.MaterialId
JOIN Inventarios.TipoMaterial tm ON m.TipoMaterialId = tm.TipoMaterialId
WHERE i.cantidad < 50;

-- 7. Obtener reportes de problemas pendientes por departamento
SELECT d.descripcion AS departamento, rp.descripcion, rp.fecha_reporte, rp.seguimiento
FROM Servicios.ReporteProblema rp
JOIN Sucursales.Departamento d ON rp.DepartamentoId = d.DepartamentoId
WHERE rp.seguimiento IN ('Pendiente', 'En proceso');

-- 8. Listar suspensiones temporales activas
SELECT p.nombre, p.apellido1, ss.fecha_suspension, ss.descricpion
FROM Servicios.SuspensionServicio ss
JOIN Servicios.TicketServicio ts ON ss.SuspensionId = ts.SuspensionId
JOIN Clientes.Cliente c ON ts.ClienteId = c.ClienteId
JOIN Personas.Persona p ON c.PersonaId = p.PersonaId
WHERE ss.actividad = 'T';

-- 9. Mostrar empleados por turno y establecimiento
SELECT p.nombre, p.apellido1, t.tipo AS turno, e.nombre AS establecimiento
FROM RecursosHumanos.Empleado em
JOIN Personas.Persona p ON em.PersonaId = p.PersonaId
JOIN RecursosHumanos.Turno t ON em.TurnoId = t.TurnoId
JOIN Sucursales.Establecimiento e ON em.EstablecimientoId = e.EstablecimientoId;

-- 10. Obtener compras por proveedor en el último mes
SELECT pe.nombre AS empresa, SUM(c.monto) as total_compras, COUNT(*) as num_compras
FROM Inventarios.Compra c
JOIN Inventarios.Proveedor pr ON c.ProveedorId = pr.ProveedorId
JOIN Personas.Persona pe ON pr.PersonaId = pe.PersonaId
WHERE c.fecha_compra >= '2024-03-01'
GROUP BY pe.nombre;

-- 11. Listar clientes con programa de descuento <----------------------------- pendiente
SELECT p.nombre, p.apellido1, pd.descricpion, pd.porcentaje_aplicado
FROM Servicios.TicketServicio ts
JOIN Clientes.Cliente c ON ts.ClienteId = c.ClienteId
JOIN Personas.Persona p ON c.PersonaId = p.PersonaId
JOIN Servicios.ProgramaDescuento pd ON ts.ProgramaDescuento = pd.ProgramaId;

-- 12. Mostrar consumo promedio por tipo de tarifa
SELECT tt.nombre AS tipo_tarifa, AVG(co.consumo_m3) as consumo_promedio
FROM Clientes.Consumo co
JOIN Clientes.Cliente cl ON co.ConsumoId = cl.ClienteId
JOIN Clientes.Contrato ct ON cl.ContratoId = ct.ContratoId
JOIN Clientes.TipoTarifa tt ON ct.TipoTarifaId = tt.TipoTarifaId
GROUP BY tt.nombre;

-- 13. Obtener historial de asistencia del último día
SELECT p.nombre, p.apellido1, ha.fecha_entrada, ha.fecha_salida
FROM RecursosHumanos.HistorialAsistencia ha
JOIN RecursosHumanos.Empleado e ON ha.EmpleadoId = e.EmpleadoId
JOIN Personas.Persona p ON e.PersonaId = p.PersonaId
WHERE CAST(ha.fecha_entrada AS DATE) = '2024-03-01';

-- 14. Listar domicilios de empresas por localidad
SELECT p.nombre AS empresa, d.domicilio_linea1, d.domicilio_linea2, d.cod_postal
FROM Personas.Persona p
JOIN Personas.Domicilio d ON p.DomicilioId = d.DomicilioId
WHERE p.tipo_persona = 'F';

-- 15. Mostrar contratos próximos a vencer
SELECT p.nombre, p.apellido1, ce.tipo_contrato, ce.fecha_vencimiento
FROM RecursosHumanos.ContratoEmpleado ce
JOIN RecursosHumanos.Empleado e ON ce.ContratoId = e.ContratoId
JOIN Personas.Persona p ON e.PersonaId = p.PersonaId
WHERE ce.fecha_vencimiento <= DATEADD(month, 1, GETDATE())
ORDER BY ce.fecha_vencimiento;