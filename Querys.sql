EXEC Clientes.InsertarCliente
     @Nombre = 'Mario',
     @Apellido1 = N'Gutiérrez',
     @Apellido2 = N'López',
     @Email = 'mario.gutierrez@example.com',
     @NumeroTelefono = '6681234567',
     @TipoNumero = 1,
     @TipoPersona = 'F',
     @DomicilioLinea1 = 'Calle Roble 567',
     @DomicilioLinea2 = 'Colonia El Parque',
     @CodigoPostal = '81250',
     @LocalidadId = 1,
     @TipoDomicilioId = 1,
     @FechaCorte = '2023-12-15',
     @FechaContrato = '2023-01-10',
     @EnlaceDocumento = 'contratos/mario_gutierrez.pdf',
     @TipoTarifaId = 1,
     @Medidor = 'M202312001'
GO

EXEC RecursosHumanos.InsertarEmpleado
     @Nombre = 'Laura',
     @Apellido1 = 'Castillo',
     @Apellido2 = 'Rojas',
     @Email = 'laura.castillo@japama.com',
     @NumeroTelefono = '6682345678',
     @TipoNumero = 1,
     @TipoPersona = 'F',
     @DomicilioLinea1 = 'Av. Reforma 123',
     @DomicilioLinea2 = 'Colonia Centro',
     @CodigoPostal = '81200',
     @LocalidadId = 1,
     @TipoDomicilioId = 1,
     @NSS = '12345678901',
     @RFC = 'CARL890213HJ5',
     @EstadoCivil = 'SOL',
     @FechaNacimiento = '1989-02-13',
     @FechaContratacion = '2023-03-15',
     @PuestoId = 1,
     @TurnoId = 1,
     @EstablecimientoID = 1,
     @TipoContrato = 'CON',
     @FechaVencimiento = '2024-03-15',
     @EnlaceDocumento = 'contratos/empleados/laura_castillo.pdf',
     @Clabe = '123456789012345678',
     @BancoId = 1
GO

EXEC Inventarios.InsertarProveedor
     @Nombre = N'Suministros Hidráulicos S.A.',
     @Email = 'contacto@suministroshidraulicos.com',
     @NumeroTelefono = '6683456789',
     @TipoNumero = 2,
     @TipoPersona = 'M',
     @TipoDomicilioId = 2,
     @DomicilioLinea1 = 'Blvd. Industrial 450',
     @DomicilioLinea2 = 'Parque Industrial Norte',
     @CodigoPostal = '81420',
     @LocalidadId = 1
GO

SELECT * FROM RecursosHumanos.V8_EmpleadosSindicato
GO

SELECT * FROM Servicios.V11_ListaClientesCartaNoAdeudos
GO

SELECT * FROM Inventarios.V13_ListaVehiculosSucursal
GO

SELECT Personas.FC_TotalPersonaFisicaMoral('F') AS 'Total Personas Físicas';

SELECT Personas.FC_TotalPersonaFisicaMoral('M') AS 'Total Personas Morales'
GO

SELECT * FROM RecursosHumanos.N_EmpleadoContrato()
GO

SELECT *
FROM RecursosHumanos.AsistenciaPeriodo('2023-01-01', '2023-12-31')
GO

SELECT c.ClienteId, p.nombre, p.apellido1, p.apellido2,
       d.domicilio_linea1, d.domicilio_linea2, d.cod_postal, l.nombre AS Localidad
FROM Clientes.V2_ListaClientes c
         JOIN Personas.Persona p ON c.PersonaId = p.PersonaId
         JOIN Personas.Domicilio d ON p.DomicilioId = d.DomicilioId
         JOIN Personas.Localidad l ON d.LocalidadId = l.LocalidadId
GO

SELECT * FROM Servicios.V3_ContratosActivos
GO

SELECT p.ProveedorId, p.PersonaId, per.nombre,
       e.correo AS Email, nt.numero AS Telefono
FROM Inventarios.V5_ListaProveedores p
         JOIN Personas.Persona per ON p.PersonaId = per.PersonaId
         JOIN Personas.Email e ON per.EmailId = e.EmailId
         JOIN Personas.NumeroTelefonico nt ON per.NumeroTelId = nt.NumeroTelId
GO

SELECT e.*,
       email.correo,
       tel.numero AS Telefono
FROM RecursosHumanos.V14_ListaEmpleadoMatutino e
         JOIN Personas.Persona p ON e.EmpleadoId = p.PersonaId
         JOIN Personas.Email email ON p.EmailId = email.EmailId
         JOIN Personas.NumeroTelefonico tel ON p.NumeroTelId = tel.NumeroTelId
GO

SELECT r.ReporteId, r.descripcion, r.fecha_reporte,
       p.nombre, p.apellido1, p.apellido2,
       r.domicilio_linea1, r.domicilio_linea2, r.cod_postal,
       l.nombre AS Localidad
FROM Servicios.V6_ListaReportes r
         JOIN Clientes.Cliente c ON r.ClienteId = c.ClienteId
         JOIN Personas.Persona p ON c.PersonaId = p.PersonaId
         JOIN Personas.Localidad l ON r.LocalidadId = l.LocalidadId
GO