DROP TABLE Auditoria.DatosEmpresa
GO

CREATE TABLE Auditoria.DatosEmpresa
(
    EmpresaId       INT PRIMARY KEY NOT NULL IDENTITY (1,1),
    nombre_corto    VARCHAR(15)     NOT NULL,
    nombre_completo VARCHAR(100)    NOT NULL,
    direccion       VARCHAR(80)     NOT NULL,
    colonia         VARCHAR(50)     NOT NULL,
    codigo_postal   VARCHAR(5)      NOT NULL,
    localidad       VARCHAR(50)     NOT NULL,
    numero_contacto VARCHAR(10),
    email           VARCHAR(50)
)
GO

INSERT INTO Auditoria.DatosEmpresa (nombre_corto, nombre_completo, direccion, colonia, codigo_postal, localidad,
                                    numero_contacto, email)
VALUES ('JAPAMA', 'Junta de Agua Potable y Alcantarillado del Municipio de Ahome',
        'C. Ángel Flores esq. con Av. Aquiles Serdán', 'C. Centro', '81200', 'Los Mochis, Sinaloa, Mexico',
        '6688120404','ccj@japamadigital.gob.mx')
GO

SELECT * FROM Auditoria.DatosEmpresa