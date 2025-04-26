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



