use BD_JAPAMA
go

/*
Las relaciones establecidas anteriormente definen las siguientes conexiones:

1. Relaciones del módulo Inventarios:
   - Proveedor -> Persona: Vincula proveedores con sus datos personales
   - TallerVehiculo -> Persona: Conecta talleres con información de contacto
   - Facturación -> Establecimiento: Asocia facturas con sucursales
   - Vehículo -> Establecimiento: Asigna vehículos a sucursales específicas

2. Relaciones del módulo Clientes:
   - Cliente -> Persona: Vincula clientes con sus datos personales
   - Adeudos -> Establecimiento: Asocia deudas con sucursales específicas
   - TicketServicio -> Cliente: Conecta tickets de servicio con clientes

3. Relaciones del módulo Sucursales:
   - Establecimiento -> Domicilio: Asocia ubicaciones físicas con sucursales
   - CajeroAutomatico -> Banco: Vincula cajeros con sus bancos correspondientes

4. Relaciones del módulo Recursos Humanos:
   - Empleado -> Persona: Conecta empleados con sus datos personales
   - Empleado -> Establecimiento: Asigna empleados a sucursales específicas

Nota: Algunas relaciones aparecen duplicadas en el código y deberían ser revisadas
para evitar redundancia (ejemplo: Vehiculo -> Establecimiento).
*/

--Inventarios a Personas
alter table Inventarios.Proveedor
add constraint FK_Proveedor_Persona
foreign key (PersonaId)
references Personas.Persona (PersonaId)

alter table Inventarios.TallerVehiculo
add constraint FK_Taller_Persona
foreign key (PersonaId)
references Personas.Persona (PersonaId)

--Inventario a Establecimiento
alter table Inventarios.Facturacion
add constraint FK_Facturacion_Establecimiento
foreign key (EstablecimientoId)
references Sucursales.Establecimiento (EstablecimientoId)

alter table Inventarios.Vehiculo
add constraint FK_Vehiculo_Establecimiento
foreign key (EstablecimientoId)
references Sucursales.Establecimiento (EstablecimientoId)

--Cliente a Persona
alter table Clientes.Cliente
add constraint FK_Cliente_Persona
foreign key (PersonaId)
references Personas.Persona (PersonaId)

--Cliente a Sucursal
alter table Clientes.Adeudos
add constraint FK_Adeudo_Establecimiento
foreign key (EstablecimientoId)
references Sucursales.Establecimiento (EstablecimientoId)

--Ticket a Cliente
alter table Servicios.TicketServicio
add constraint FK_Ticket_Cliente
foreign key (ClienteId)
references Clientes.Cliente (ClienteId)

--Sucursal a Domicilio
alter table Sucursales.Establecimiento
add constraint FK_Establecimiento_Domicilio
foreign key (DomicilioId)
references Personas.Domicilio (DomicilioId)

--Cajero a Banco
alter table Sucursales.CajeroAutomatico
add constraint FK_Cajero_Banco
foreign key (BancoId)
references RecursosHumanos.Banco (BancoId)

--Empleado a Persona
alter table RecursosHumanos.Empleado
add constraint FK_Empleado_Persona
foreign key (PersonaId)
references Personas.Persona (PersonaId)

--Empleado a Establecimiento
ALTER TABLE RecursosHumanos.Empleado ADD CONSTRAINT
FK_EstablecimientoId FOREIGN KEY (EstablecimientoId) REFERENCES Sucursales.Establecimiento(EstablecimientoId);
GO

--Vehiculo a Establecimiento
ALTER TABLE Inventarios.Vehiculo ADD CONSTRAINT
FK_EstablecimientoId FOREIGN KEY (EstablecimientoId) REFERENCES Sucursales.Establecimiento(EstablecimientoId);
GO