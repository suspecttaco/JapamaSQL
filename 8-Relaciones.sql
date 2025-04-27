use BD_JAPAMA
go

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

--ReportesServicio a Cliente
alter table Servicios.ReporteProblema
add constraint FK_Reporte_Cliente
foreign key (ClienteId)
references Clientes.Cliente (ClienteId)

--Suspension a Cliente
alter table Servicios.SuspensionServicio
add constraint FK_Suspension_Cliente
foreign key (ClienteId)
references Clientes.Cliente (ClienteId)

--Carta a Cliente
alter table Servicios.CartaNoAdeudos
add constraint FK_Carta_Cliente
foreign key (ClienteId)
references Clientes.Cliente (ClienteId)

--Sucursal a Domicilio
alter table Sucursales.Establecimiento
add constraint FK_Establecimiento_Domicilio
foreign key (DomicilioId)
references Personas.Domicilio (DomicilioId)

--Red a Proveedor
alter table Sucursales.Red
add constraint FK_Red_Proveedor
foreign key (ProveedorId)
references Inventarios.Proveedor (ProveedorId)

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