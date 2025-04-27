use BD_JAPAMA
go

create table [Personas].[Localidad](
    [LocalidadId] int primary key identity (1,1) not null,
    [nombre] varchar(50) not null,
    [fecha_mod] datetime not null,
)

create table [Personas].[TipoDomicilio] (
    [TipoDomicilioId] int primary key identity (1,1) not null,
    [descripcion] varchar(50) not null,
    [fecha_mod] datetime not null
)

create table [Personas].[Domicilio](
    [DomicilioId] bigint primary key identity (1,1) not null,
    [domicilio_linea1] varchar(100) not null,
    [domicilio_linea2] varchar(100),
    [cod_postal] varchar(5) not null,
    [LocalidadId] int not null foreign key references Personas.Localidad (LocalidadId),
    [TipoDomicilioId] int not null foreign key references Personas.TipoDomicilio (TipoDomicilioId),
    [fecha_mod] datetime not null
)

create table [Personas].[TipoNumero](
    [TipoNumeroId] int primary key identity (1,1) not null,
    [descripcion] varchar(50) not null ,
    [fecha_mod] datetime not null
)

create table [Personas].[NumeroTelefonico] (
    [NumeroTelId] bigint primary key identity (1,1) not null,
    [numero] varchar(10) unique not null,
    [TipoNumeroId] int foreign key references Personas.TipoNumero([TipoNumeroId]),
    [fecha_mod] datetime not null
)

create table [Personas].[Email] (
    [EmailId] bigint primary key identity (1,1) not null,
    [correo] varchar(50) unique not null,
    [fecha_mod] datetime not null
)

create table [Personas].[Persona] (
    [PersonaId] bigint primary key identity (1,1) not null,
    [nombre] varchar(50) not null,
    [apellido1] varchar(50),
    [apellido2] varchar(50),
    [tipo_persona] varchar(1) not null,
    [EmailId] bigint foreign key references Personas.Email([EmailId]),
    [NumeroTelId] bigint foreign key references Personas.NumeroTelefonico([NumeroTelId]),
    [DomicilioId] bigint,
    [fecha_mod] datetime not null
)

