-- Datos de soporte
INSERT INTO Personas.Localidad (nombre, fecha_mod)
VALUES ('Los Mochis', GETDATE()),
       ('Ahome', GETDATE()),
       ('Topolobampo', GETDATE());

INSERT INTO Personas.TipoDomicilio (descripcion, fecha_mod)
VALUES ('Residencial', GETDATE()),
       ('Comercial', GETDATE()),
       ('Industrial', GETDATE());

INSERT INTO Personas.TipoNumero (descripcion, fecha_mod)
VALUES ('Celular', GETDATE()),
       ('Oficina', GETDATE()),
       ('Casa', GETDATE());

-- Personas Físicas
INSERT INTO Personas.Email (correo, fecha_mod)
VALUES ('juan.perez@mail.com', GETDATE()),
       ('maria.lopez@mail.com', GETDATE()),
       ('carlos.ruiz@mail.com', GETDATE()),
       ('ana.garcia@mail.com', GETDATE()),
       ('pedro.martinez@mail.com', GETDATE()),
       ('laura.sanchez@mail.com', GETDATE()),
       ('jose.rodriguez@mail.com', GETDATE()),
       ('carmen.torres@mail.com', GETDATE()),
       ('francisco.ramirez@mail.com', GETDATE()),
       ('sofia.morales@mail.com', GETDATE()),
       ('miguel.castro@mail.com', GETDATE()),
       ('patricia.flores@mail.com', GETDATE()),
       ('roberto.diaz@mail.com', GETDATE()),
       ('isabel.vazquez@mail.com', GETDATE()),
       ('david.mendoza@mail.com', GETDATE());

-- Empresas
INSERT INTO Personas.Email (correo, fecha_mod)
VALUES ('contacto@constructoraxa.com', GETDATE()),
       ('info@industriasmx.com', GETDATE()),
       ('ventas@comercialnorte.com', GETDATE()),
       ('admin@transportessinaloa.com', GETDATE()),
       ('info@manufacturasahome.com', GETDATE()),
       ('contacto@serviciostopo.com', GETDATE()),
       ('ventas@distribuidoradelnorte.com', GETDATE()),
       ('info@agricoladelvalle.com', GETDATE()),
       ('contacto@pescaderiamar.com', GETDATE()),
       ('admin@logisticamochis.com', GETDATE()),
       ('info@materiales_construccion.com', GETDATE()),
       ('ventas@ferreterianorte.com', GETDATE()),
       ('contacto@alimentospacifico.com', GETDATE()),
       ('info@ganaderanorte.com', GETDATE()),
       ('admin@aceroshome.com', GETDATE()),
       ('contacto@pinturasmx.com', GETDATE()),
       ('info@electricanorte.com', GETDATE()),
       ('ventas@plomeriapro.com', GETDATE()),
       ('admin@refrigeraciontotal.com', GETDATE()),
       ('contacto@maquinariapesada.com', GETDATE()),
       ('info@herramientasplus.com', GETDATE()),
       ('admin@tuberiaindustrial.com', GETDATE()),
       ('ventas@bombasagua.com', GETDATE()),
       ('contacto@valvulaspro.com', GETDATE()),
       ('info@medidoresagua.com', GETDATE());

-- Insertar números telefónicos y domicilios similares antes de personas

INSERT INTO Personas.Persona (nombre, apellido1, apellido2, tipo_persona, EmailId, fecha_mod)
VALUES
-- Personas físicas
('Juan', N'Pérez', N'Gómez', 'F', 1, GETDATE()),
(N'María', N'López', N'Sánchez', 'F', 2, GETDATE()),
('Carlos', 'Ruiz', 'Torres', 'F', 3, GETDATE()),
('Ana', N'García', N'Ramírez', 'F', 4, GETDATE()),
('Pedro', N'Martínez', 'Castro', 'F', 5, GETDATE()),
('Laura', N'Sánchez', 'Flores', 'F', 6, GETDATE()),
(N'José', N'Rodríguez', N'Díaz', 'F', 7, GETDATE()),
('Carmen', 'Torres', N'Vázquez', 'F', 8, GETDATE()),
('Francisco', N'Ramírez', 'Mendoza', 'F', 9, GETDATE()),
(N'Sofía', 'Morales', 'Luna', 'F', 10, GETDATE()),
('Miguel', 'Castro', 'Reyes', 'F', 11, GETDATE()),
('Patricia', 'Flores', 'Silva', 'F', 12, GETDATE()),
('Roberto', 'Díaz', 'Ortiz', 'F', 13, GETDATE()),
('Isabel', 'Vázquez', 'Cruz', 'F', 14, GETDATE()),
('David', 'Mendoza', 'Ríos', 'F', 15, GETDATE()),

-- Empresas (personas morales)
('Constructora XA', NULL, NULL, 'M', 16, GETDATE()),
('Industrias MX', NULL, NULL, 'M', 17, GETDATE()),
('Comercial del Norte', NULL, NULL, 'M', 18, GETDATE()),
('Transportes Sinaloa', NULL, NULL, 'M', 19, GETDATE()),
('Manufacturas Ahome', NULL, NULL, 'M', 20, GETDATE()),
('Servicios Topo', NULL, NULL, 'M', 21, GETDATE()),
('Distribuidora del Norte', NULL, NULL, 'M', 22, GETDATE()),
('Agrícola del Valle', NULL, NULL, 'M', 23, GETDATE()),
('Pescadería Mar', NULL, NULL, 'M', 24, GETDATE()),
('Logística Mochis', NULL, NULL, 'M', 25, GETDATE()),
('Materiales Construcción', NULL, NULL, 'M', 26, GETDATE()),
('Ferretería Norte', NULL, NULL, 'M', 27, GETDATE()),
('Alimentos Pacífico', NULL, NULL, 'M', 28, GETDATE()),
('Ganadera Norte', NULL, NULL, 'M', 29, GETDATE()),
('Aceros Home', NULL, NULL, 'M', 30, GETDATE()),
('Pinturas MX', NULL, NULL, 'M', 31, GETDATE()),
('Eléctrica Norte', NULL, NULL, 'M', 32, GETDATE()),
('Plomería Pro', NULL, NULL, 'M', 33, GETDATE()),
('Refrigeración Total', NULL, NULL, 'M', 34, GETDATE()),
('Maquinaria Pesada', NULL, NULL, 'M', 35, GETDATE()),
('Herramientas Plus', NULL, NULL, 'M', 36, GETDATE()),
('Tubería Industrial', NULL, NULL, 'M', 37, GETDATE()),
('Bombas Agua', NULL, NULL, 'M', 38, GETDATE()),
('Válvulas Pro', NULL, NULL, 'M', 39, GETDATE()),
('Medidores Agua', NULL, NULL, 'M', 40, GETDATE());

-- Números telefónicos
INSERT INTO Personas.NumeroTelefonico (numero, TipoNumeroId, fecha_mod)
VALUES
-- Personas físicas
('6681234567', 1, GETDATE()),
('6682345678', 1, GETDATE()),
('6683456789', 1, GETDATE()),
('6684567890', 1, GETDATE()),
('6685678901', 1, GETDATE()),
('6686789012', 1, GETDATE()),
('6687890123', 1, GETDATE()),
('6688901234', 1, GETDATE()),
('6689012345', 1, GETDATE()),
('6680123456', 1, GETDATE()),
('6681122334', 1, GETDATE()),
('6682233445', 1, GETDATE()),
('6683344556', 1, GETDATE()),
('6684455667', 1, GETDATE()),
('6685566778', 1, GETDATE()),

-- Empresas
('6689876543', 2, GETDATE()),
('6688765432', 2, GETDATE()),
('6687654321', 2, GETDATE()),
('6686543210', 2, GETDATE()),
('6685432109', 2, GETDATE()),
('6684321098', 2, GETDATE()),
('6683210987', 2, GETDATE()),
('6682109876', 2, GETDATE()),
('6681098765', 2, GETDATE()),
('6680987654', 2, GETDATE()),
('6689988776', 2, GETDATE()),
('6688877665', 2, GETDATE()),
('6687766554', 2, GETDATE()),
('6686655443', 2, GETDATE()),
('6685544332', 2, GETDATE()),
('6684433221', 2, GETDATE()),
('6683322110', 2, GETDATE()),
('6682211009', 2, GETDATE()),
('6681100998', 2, GETDATE()),
('6680099887', 2, GETDATE()),
('6689999888', 2, GETDATE()),
('6688888777', 2, GETDATE()),
('6687777666', 2, GETDATE()),
('6686666555', 2, GETDATE()),
('6685555444', 2, GETDATE());

-- Domicilios
INSERT INTO Personas.Domicilio (domicilio_linea1, domicilio_linea2, cod_postal, LocalidadId, TipoDomicilioId, fecha_mod)
VALUES
-- Personas físicas
('Calle Principal 123', 'Colonia Centro', '81200', 1, 1, GETDATE()),
('Av. Independencia 456', 'Colonia Libertad', '81210', 1, 1, GETDATE()),
('Calle Reforma 789', 'Colonia Progreso', '81220', 1, 1, GETDATE()),
('Blvd. Centenario 234', 'Colonia Modern', '81230', 1, 1, GETDATE()),
('Av. Álamos 567', 'Colonia Jardines', '81240', 1, 1, GETDATE()),
('Calle Pino 890', 'Colonia Bosques', '81250', 1, 1, GETDATE()),
('Av. Rosales 123', 'Colonia Flores', '81260', 1, 1, GETDATE()),
('Calle Juárez 456', 'Colonia Centro', '81270', 1, 1, GETDATE()),
('Av. Hidalgo 789', 'Colonia Reforma', '81280', 1, 1, GETDATE()),
('Calle Morelos 012', 'Colonia Victoria', '81290', 1, 1, GETDATE()),
('Blvd. Zaragoza 345', 'Colonia Nueva', '81300', 1, 1, GETDATE()),
('Av. Sinaloa 678', 'Colonia Estado', '81310', 1, 1, GETDATE()),
('Calle Sonora 901', 'Colonia Norte', '81320', 1, 1, GETDATE()),
('Av. Chihuahua 234', 'Colonia Sur', '81330', 1, 1, GETDATE()),
('Calle Durango 567', 'Colonia Este', '81340', 1, 1, GETDATE()),

-- Empresas
('Zona Industrial 100', 'Parque Industrial', '81400', 1, 2, GETDATE()),
('Av. Comercial 200', 'Zona Comercial', '81410', 1, 2, GETDATE()),
('Blvd. Industrial 300', 'Sector 1', '81420', 1, 2, GETDATE()),
('Carretera Nacional 400', 'Km 5', '81430', 2, 2, GETDATE()),
('Av. Empresarial 500', 'Zona Dorada', '81440', 1, 2, GETDATE()),
('Calle Comercio 600', 'Centro', '81450', 1, 2, GETDATE()),
('Av. Negocios 700', 'Plaza Principal', '81460', 1, 2, GETDATE()),
('Blvd. Corporativo 800', 'Torre A', '81470', 1, 2, GETDATE()),
('Carretera Internacional 900', 'Km 10', '81480', 3, 2, GETDATE()),
('Av. Industrial 1000', 'Parque 2', '81490', 1, 2, GETDATE()),
('Zona Comercial 1100', 'Local 1', '81500', 1, 2, GETDATE()),
('Av. Principal 1200', 'Plaza Norte', '81510', 1, 2, GETDATE()),
('Blvd. Empresas 1300', 'Edificio B', '81520', 1, 2, GETDATE()),
('Calle Industria 1400', 'Nave 3', '81530', 1, 2, GETDATE()),
('Av. Comercios 1500', 'Local 100', '81540', 1, 2, GETDATE()),
('Zona Industrial 1600', 'Bodega 5', '81550', 1, 2, GETDATE()),
('Av. Corporativa 1700', 'Piso 2', '81560', 1, 2, GETDATE()),
('Blvd. Negocios 1800', 'Suite 300', '81570', 1, 2, GETDATE()),
('Calle Empresarial 1900', 'Oficina 4', '81580', 1, 2, GETDATE()),
('Av. Industrial 2000', 'Planta 1', '81590', 1, 2, GETDATE()),
('Zona Comercial 2100', 'Local 200', '81600', 1, 2, GETDATE()),
('Av. Empresas 2200', 'Edificio C', '81610', 1, 2, GETDATE()),
('Blvd. Industrial 2300', 'Nave 7', '81620', 1, 2, GETDATE()),
('Calle Negocios 2400', 'Torre B', '81630', 1, 2, GETDATE()),
('Av. Corporativo 2500', 'Piso 5', '81640', 1, 2, GETDATE());

-- Actualizar PersonaId con NumeroTelId y DomicilioId
UPDATE Personas.Persona
SET NumeroTelId = NT.NumeroTelId,
    DomicilioId = D.DomicilioId
FROM Personas.Persona P
         INNER JOIN Personas.NumeroTelefonico NT ON P.PersonaId = NT.NumeroTelId
         INNER JOIN Personas.Domicilio D ON P.PersonaId = D.DomicilioId;

-- 10 Domicilios adicionales
INSERT INTO Personas.Domicilio (domicilio_linea1, domicilio_linea2, cod_postal, LocalidadId, TipoDomicilioId, fecha_mod)
VALUES ('Av. Insurgentes 2600', 'Residencial Las Palmas', '81650', 1, 1, GETDATE()),
       ('Calle Girasoles 2700', 'Fraccionamiento Las Flores', '81660', 1, 1, GETDATE()),
       ('Blvd. Alameda 2800', 'Colonia Los Pinos', '81670', 1, 1, GETDATE()),
       ('Paseo del Mar 2900', 'Residencial Costa Azul', '81680', 3, 1, GETDATE()),
       ('Calle Nogal 3000', 'Colonia Las Arboledas', '81690', 1, 1, GETDATE()),
       ('Av. Universidad 3100', 'Colonia Educación', '81700', 1, 2, GETDATE()),
       ('Blvd. Las Torres 3200', 'Torre Ejecutiva', '81710', 1, 2, GETDATE()),
       ('Carretera Vieja 3300', 'Parque Industrial Sur', '81720', 2, 2, GETDATE()),
       ('Av. Las Américas 3400', 'Plaza Comercial', '81730', 1, 2, GETDATE()),
       ('Calle Victoria 3500', 'Centro Histórico', '81740', 1, 2, GETDATE());

-- Departamentos
INSERT INTO Sucursales.Departamento (descripcion, segmento_red, fecha_mod)
VALUES ('Atención al Cliente', '192.168.1.0/24', GETDATE()),
       ('Cobranza', '192.168.2.0/24', GETDATE()),
       ('Operaciones', '192.168.3.0/24', GETDATE()),
       ('Mantenimiento', '192.168.4.0/24', GETDATE()),
       ('Servicios Técnicos', '192.168.5.0/24', GETDATE()),
       ('Contratos', '192.168.6.0/24', GETDATE()),
       ('Facturación', '192.168.7.0/24', GETDATE()),
       ('Medición', '192.168.8.0/24', GETDATE()),
       ('Administración', '192.168.9.0/24', GETDATE()),
       ('Calidad del Agua', '192.168.10.0/24', GETDATE());

-- Redes
INSERT INTO Sucursales.Red (compania_red, segmento_red, fecha_mod)
VALUES ('Telmex', '10.10.1.0/24', GETDATE()),
       ('TotalPlay', '10.10.2.0/24', GETDATE()),
       ('Megacable', '10.10.3.0/24', GETDATE()),
       ('Izzi', '10.10.4.0/24', GETDATE()),
       ('AT&T', '10.10.5.0/24', GETDATE()),
       ('Axtel', '10.10.6.0/24', GETDATE()),
       ('Alestra', '10.10.7.0/24', GETDATE()),
       ('Telcel', '10.10.8.0/24', GETDATE()),
       ('Movistar', '10.10.9.0/24', GETDATE()),
       ('Uninet', '10.10.10.0/24', GETDATE());

-- Tipos de Establecimiento
INSERT INTO Sucursales.TipoEstablecimiento (nombre, fecha_mod)
VALUES ('Oficina Principal', GETDATE()),
       ('Sucursal', GETDATE()),
       ('Módulo de Atención', GETDATE()),
       ('Centro de Pago', GETDATE()),
       ('Oficina Administrativa', GETDATE()),
       ('Centro Operativo', GETDATE()),
       ('Almacén', GETDATE()),
       ('Laboratorio', GETDATE()),
       ('Taller', GETDATE()),
       ('Planta de Tratamiento', GETDATE());

-- Establecimientos (usando las 10 direcciones adicionales)
INSERT INTO Sucursales.Establecimiento (nombre, TipoEstablecimientoId, DomicilioId, RedId, DepartamentoId, fecha_mod)
VALUES ('JAPAMA Central', 1, 36, 1, 1, GETDATE()),
       ('Sucursal Norte', 2, 37, 2, 2, GETDATE()),
       ('Módulo Plaza', 3, 38, 3, 3, GETDATE()),
       ('Centro de Pagos Costa', 4, 39, 4, 4, GETDATE()),
       ('Oficinas Ejecutivas', 5, 40, 5, 5, GETDATE()),
       ('Centro Operativo Sur', 6, 41, 6, 6, GETDATE()),
       ('Almacén General', 7, 42, 7, 7, GETDATE()),
       ('Laboratorio Central', 8, 43, 8, 8, GETDATE()),
       ('Taller Mecánico', 9, 44, 9, 9, GETDATE()),
       ('Planta Tratadora Norte', 10, 45, 10, 10, GETDATE());

-- Bancos
INSERT INTO RecursosHumanos.Banco (nombre, fecha_mod)
VALUES ('BBVA', GETDATE()),
       ('Santander', GETDATE()),
       ('Banorte', GETDATE()),
       ('HSBC', GETDATE()),
       ('Scotiabank', GETDATE()),
       ('Banamex', GETDATE()),
       ('Banco Azteca', GETDATE()),
       ('BanBajío', GETDATE()),
       ('Inbursa', GETDATE()),
       ('Bancoppel', GETDATE());

-- Cajeros Automáticos
INSERT INTO Sucursales.CajeroAutomatico (EstablecimientoId, actividad, fecha_inicio, fecha_cierre, horario, BancoId,
                                         fecha_mod)
VALUES (1, 'A', '2024-01-01', '2024-12-31', '24/7', 1, GETDATE()),
       (2, 'A', '2024-01-01', '2024-12-31', '06:00-22:00', 2, GETDATE()),
       (3, 'A', '2024-01-01', '2024-12-31', '24/7', 3, GETDATE()),
       (4, 'A', '2024-01-01', '2024-12-31', '07:00-21:00', 4, GETDATE()),
       (5, 'A', '2024-01-01', '2024-12-31', '24/7', 5, GETDATE()),
       (6, 'I', '2024-01-01', '2024-12-31', '08:00-20:00', 1, GETDATE()),
       (7, 'A', '2024-01-01', '2024-12-31', '24/7', 2, GETDATE()),
       (8, 'S', '2024-01-01', '2024-12-31', '07:00-23:00', 3, GETDATE()),
       (9, 'A', '2024-01-01', '2024-12-31', '24/7', 4, GETDATE()),
       (10, 'A', '2024-01-01', '2024-12-31', '06:00-22:00', 5, GETDATE());


-- Primero insertamos datos de soporte necesarios
INSERT INTO Clientes.Tarifa (precio_base, base_agua, base_drenaje, base_saneamiento, max_m3, fecha_mod)
VALUES
-- Tarifa doméstica
(150.00, 80.00, 40.00, 30.00, 10, GETDATE()),
-- Tarifa comercial
(300.00, 160.00, 80.00, 60.00, 20, GETDATE());

INSERT INTO Clientes.TipoTarifa (nombre, TarifaId, fecha_mod)
VALUES ('Doméstica', 1, GETDATE()),
       ('Comercial', 2, GETDATE());

-- Insertar contratos
INSERT INTO Clientes.Contrato (fecha_contrato, enlace_documento, TipoTarifaId, medidor, fecha_mod)
VALUES
-- Contratos domésticos
('2024-01-15', 'contratos/dom/2024/001.pdf', 1, 'DOM001202401', GETDATE()),
('2024-01-20', 'contratos/dom/2024/002.pdf', 1, 'DOM002202401', GETDATE()),
('2024-02-01', 'contratos/dom/2024/003.pdf', 1, 'DOM003202402', GETDATE()),
('2024-02-15', 'contratos/dom/2024/004.pdf', 1, 'DOM004202402', GETDATE()),
('2024-03-01', 'contratos/dom/2024/005.pdf', 1, 'DOM005202403', GETDATE()),
-- Contratos comerciales
('2024-01-10', 'contratos/com/2024/001.pdf', 2, 'COM001202401', GETDATE()),
('2024-01-25', 'contratos/com/2024/002.pdf', 2, 'COM002202401', GETDATE()),
('2024-02-05', 'contratos/com/2024/003.pdf', 2, 'COM003202402', GETDATE()),
('2024-02-20', 'contratos/com/2024/004.pdf', 2, 'COM004202402', GETDATE()),
('2024-03-05', 'contratos/com/2024/005.pdf', 2, 'COM005202403', GETDATE());

-- Insertar clientes
INSERT INTO Clientes.Cliente (PersonaId, fecha_corte, ContratoId, actividad, fecha_mod)
VALUES
-- Clientes domésticos (usando personas físicas)
(1, '2024-04-15', 1, 'A', GETDATE()),
(2, '2024-04-20', 2, 'A', GETDATE()),
(3, '2024-05-01', 3, 'A', GETDATE()),
(4, '2024-05-15', 4, 'A', GETDATE()),
(5, '2024-06-01', 5, 'A', GETDATE()),
-- Clientes comerciales (usando empresas)
(16, '2024-04-10', 6, 'A', GETDATE()),
(17, '2024-04-25', 7, 'A', GETDATE()),
(18, '2024-05-05', 8, 'A', GETDATE()),
(19, '2024-05-20', 9, 'A', GETDATE()),
(20, '2024-06-05', 10, 'A', GETDATE());

-- Primero insertamos los cargos de servicio básicos
INSERT INTO Clientes.CargoServicio (descripcion, monto, fecha_mod)
VALUES ('Reconexión', 500.00, GETDATE()),
       ('Cargo por pago tardío', 200.00, GETDATE()),
       ('Instalación medidor', 1000.00, GETDATE()),
       ('Mantenimiento red', 150.00, GETDATE()),
       ('Verificación medidor', 300.00, GETDATE());

-- Insertamos consumos para cada cliente (3 meses)
INSERT INTO Clientes.Consumo (lectura_anterior, lectura_actual, consumo_m3, facturado_m3, periodo_lectura, fecha_mod)
VALUES
-- Clientes domésticos (consumos menores)
(0, 8, 8, 150.00, '2024-01-31', GETDATE()),
(8, 15, 7, 140.00, '2024-02-29', GETDATE()),
(15, 24, 9, 170.00, '2024-03-31', GETDATE()),
(0, 9, 9, 160.00, '2024-01-31', GETDATE()),
(9, 18, 9, 160.00, '2024-02-29', GETDATE()),
(18, 26, 8, 150.00, '2024-03-31', GETDATE()),
(0, 7, 7, 140.00, '2024-01-31', GETDATE()),
(7, 16, 9, 170.00, '2024-02-29', GETDATE()),
(16, 25, 9, 170.00, '2024-03-31', GETDATE()),
(0, 10, 10, 180.00, '2024-01-31', GETDATE()),
(10, 19, 9, 170.00, '2024-02-29', GETDATE()),
(19, 28, 9, 170.00, '2024-03-31', GETDATE()),
(0, 8, 8, 150.00, '2024-01-31', GETDATE()),
(8, 17, 9, 170.00, '2024-02-29', GETDATE()),
(17, 25, 8, 150.00, '2024-03-31', GETDATE()),

-- Clientes comerciales (consumos mayores)
(0, 25, 25, 450.00, '2024-01-31', GETDATE()),
(25, 52, 27, 480.00, '2024-02-29', GETDATE()),
(52, 80, 28, 490.00, '2024-03-31', GETDATE()),
(0, 30, 30, 520.00, '2024-01-31', GETDATE()),
(30, 58, 28, 490.00, '2024-02-29', GETDATE()),
(58, 89, 31, 530.00, '2024-03-31', GETDATE()),
(0, 28, 28, 490.00, '2024-01-31', GETDATE()),
(28, 55, 27, 480.00, '2024-02-29', GETDATE()),
(55, 84, 29, 500.00, '2024-03-31', GETDATE()),
(0, 32, 32, 540.00, '2024-01-31', GETDATE()),
(32, 61, 29, 500.00, '2024-02-29', GETDATE()),
(61, 92, 31, 530.00, '2024-03-31', GETDATE()),
(0, 27, 27, 480.00, '2024-01-31', GETDATE()),
(27, 56, 29, 500.00, '2024-02-29', GETDATE()),
(56, 85, 29, 500.00, '2024-03-31', GETDATE());

-- Insertamos adeudos
INSERT INTO Clientes.Adeudos (EstablecimientoId, ClienteId, ConsumoId, CargoId,
                              adeudo_anterior, adeudo_actual, IVA, fecha_vencimiento, fecha_mod)
VALUES
-- Clientes domésticos
(1, 1, 1, 1, 0.00, 150.00, 24.00, '2024-02-15', GETDATE()),
(1, 1, 2, 4, 150.00, 290.00, 46.40, '2024-03-15', GETDATE()),
(1, 1, 3, 2, 290.00, 460.00, 73.60, '2024-04-15', GETDATE()),

(1, 2, 4, 1, 0.00, 160.00, 25.60, '2024-02-20', GETDATE()),
(1, 2, 5, 4, 160.00, 320.00, 51.20, '2024-03-20', GETDATE()),
(1, 2, 6, 2, 320.00, 470.00, 75.20, '2024-04-20', GETDATE()),

(1, 3, 7, 1, 0.00, 140.00, 22.40, '2024-03-01', GETDATE()),
(1, 3, 8, 4, 140.00, 310.00, 49.60, '2024-04-01', GETDATE()),
(1, 3, 9, 2, 310.00, 480.00, 76.80, '2024-05-01', GETDATE()),

(1, 4, 10, 1, 0.00, 180.00, 28.80, '2024-03-15', GETDATE()),
(1, 4, 11, 4, 180.00, 350.00, 56.00, '2024-04-15', GETDATE()),
(1, 4, 12, 2, 350.00, 520.00, 83.20, '2024-05-15', GETDATE()),

(1, 5, 13, 1, 0.00, 150.00, 24.00, '2024-03-01', GETDATE()),
(1, 5, 14, 4, 150.00, 320.00, 51.20, '2024-04-01', GETDATE()),
(1, 5, 15, 2, 320.00, 470.00, 75.20, '2024-05-01', GETDATE()),

-- Clientes comerciales
(1, 6, 16, 1, 0.00, 450.00, 72.00, '2024-02-10', GETDATE()),
(1, 6, 17, 4, 450.00, 930.00, 148.80, '2024-03-10', GETDATE()),
(1, 6, 18, 2, 930.00, 1420.00, 227.20, '2024-04-10', GETDATE()),

(1, 7, 19, 1, 0.00, 520.00, 83.20, '2024-02-25', GETDATE()),
(1, 7, 20, 4, 520.00, 1010.00, 161.60, '2024-03-25', GETDATE()),
(1, 7, 21, 2, 1010.00, 1540.00, 246.40, '2024-04-25', GETDATE()),

(1, 8, 22, 1, 0.00, 490.00, 78.40, '2024-03-05', GETDATE()),
(1, 8, 23, 4, 490.00, 970.00, 155.20, '2024-04-05', GETDATE()),
(1, 8, 24, 2, 970.00, 1470.00, 235.20, '2024-05-05', GETDATE()),

(1, 9, 25, 1, 0.00, 540.00, 86.40, '2024-03-20', GETDATE()),
(1, 9, 26, 4, 540.00, 1040.00, 166.40, '2024-04-20', GETDATE()),
(1, 9, 27, 2, 1040.00, 1570.00, 251.20, '2024-05-20', GETDATE()),

(1, 10, 28, 1, 0.00, 480.00, 76.80, '2024-03-05', GETDATE()),
(1, 10, 29, 4, 480.00, 980.00, 156.80, '2024-04-05', GETDATE()),
(1, 10, 30, 2, 980.00, 1480.00, 236.80, '2024-05-05', GETDATE());

-- Primero insertamos los cargos de servicio básicos
INSERT INTO Clientes.CargoServicio (descripcion, monto, fecha_mod)
VALUES ('Reconexión', 500.00, GETDATE()),
       ('Cargo por pago tardío', 200.00, GETDATE()),
       ('Instalación medidor', 1000.00, GETDATE()),
       ('Mantenimiento red', 150.00, GETDATE()),
       ('Verificación medidor', 300.00, GETDATE());

-- Insertamos consumos para cada cliente (3 meses)
INSERT INTO Clientes.Consumo (lectura_anterior, lectura_actual, consumo_m3, facturado_m3, periodo_lectura, fecha_mod)
VALUES
-- Clientes domésticos (consumos menores)
(0, 8, 8, 150.00, '2024-01-31', GETDATE()),
(8, 15, 7, 140.00, '2024-02-29', GETDATE()),
(15, 24, 9, 170.00, '2024-03-31', GETDATE()),
(0, 9, 9, 160.00, '2024-01-31', GETDATE()),
(9, 18, 9, 160.00, '2024-02-29', GETDATE()),
(18, 26, 8, 150.00, '2024-03-31', GETDATE()),
(0, 7, 7, 140.00, '2024-01-31', GETDATE()),
(7, 16, 9, 170.00, '2024-02-29', GETDATE()),
(16, 25, 9, 170.00, '2024-03-31', GETDATE()),
(0, 10, 10, 180.00, '2024-01-31', GETDATE()),
(10, 19, 9, 170.00, '2024-02-29', GETDATE()),
(19, 28, 9, 170.00, '2024-03-31', GETDATE()),
(0, 8, 8, 150.00, '2024-01-31', GETDATE()),
(8, 17, 9, 170.00, '2024-02-29', GETDATE()),
(17, 25, 8, 150.00, '2024-03-31', GETDATE()),

-- Clientes comerciales (consumos mayores)
(0, 25, 25, 450.00, '2024-01-31', GETDATE()),
(25, 52, 27, 480.00, '2024-02-29', GETDATE()),
(52, 80, 28, 490.00, '2024-03-31', GETDATE()),
(0, 30, 30, 520.00, '2024-01-31', GETDATE()),
(30, 58, 28, 490.00, '2024-02-29', GETDATE()),
(58, 89, 31, 530.00, '2024-03-31', GETDATE()),
(0, 28, 28, 490.00, '2024-01-31', GETDATE()),
(28, 55, 27, 480.00, '2024-02-29', GETDATE()),
(55, 84, 29, 500.00, '2024-03-31', GETDATE()),
(0, 32, 32, 540.00, '2024-01-31', GETDATE()),
(32, 61, 29, 500.00, '2024-02-29', GETDATE()),
(61, 92, 31, 530.00, '2024-03-31', GETDATE()),
(0, 27, 27, 480.00, '2024-01-31', GETDATE()),
(27, 56, 29, 500.00, '2024-02-29', GETDATE()),
(56, 85, 29, 500.00, '2024-03-31', GETDATE());

-- Insertamos adeudos
INSERT INTO Clientes.Adeudos (EstablecimientoId, ClienteId, ConsumoId, CargoId,
                              adeudo_anterior, adeudo_actual, IVA, fecha_vencimiento, fecha_mod)
VALUES
-- Clientes domésticos
(1, 1, 1, 1, 0.00, 150.00, 24.00, '2024-02-15', GETDATE()),
(1, 1, 2, 4, 150.00, 290.00, 46.40, '2024-03-15', GETDATE()),
(1, 1, 3, 2, 290.00, 460.00, 73.60, '2024-04-15', GETDATE()),

(1, 2, 4, 1, 0.00, 160.00, 25.60, '2024-02-20', GETDATE()),
(1, 2, 5, 4, 160.00, 320.00, 51.20, '2024-03-20', GETDATE()),
(1, 2, 6, 2, 320.00, 470.00, 75.20, '2024-04-20', GETDATE()),

(1, 3, 7, 1, 0.00, 140.00, 22.40, '2024-03-01', GETDATE()),
(1, 3, 8, 4, 140.00, 310.00, 49.60, '2024-04-01', GETDATE()),
(1, 3, 9, 2, 310.00, 480.00, 76.80, '2024-05-01', GETDATE()),

(1, 4, 10, 1, 0.00, 180.00, 28.80, '2024-03-15', GETDATE()),
(1, 4, 11, 4, 180.00, 350.00, 56.00, '2024-04-15', GETDATE()),
(1, 4, 12, 2, 350.00, 520.00, 83.20, '2024-05-15', GETDATE()),

(1, 5, 13, 1, 0.00, 150.00, 24.00, '2024-03-01', GETDATE()),
(1, 5, 14, 4, 150.00, 320.00, 51.20, '2024-04-01', GETDATE()),
(1, 5, 15, 2, 320.00, 470.00, 75.20, '2024-05-01', GETDATE()),

-- Clientes comerciales
(1, 6, 16, 1, 0.00, 450.00, 72.00, '2024-02-10', GETDATE()),
(1, 6, 17, 4, 450.00, 930.00, 148.80, '2024-03-10', GETDATE()),
(1, 6, 18, 2, 930.00, 1420.00, 227.20, '2024-04-10', GETDATE()),

(1, 7, 19, 1, 0.00, 520.00, 83.20, '2024-02-25', GETDATE()),
(1, 7, 20, 4, 520.00, 1010.00, 161.60, '2024-03-25', GETDATE()),
(1, 7, 21, 2, 1010.00, 1540.00, 246.40, '2024-04-25', GETDATE()),

(1, 8, 22, 1, 0.00, 490.00, 78.40, '2024-03-05', GETDATE()),
(1, 8, 23, 4, 490.00, 970.00, 155.20, '2024-04-05', GETDATE()),
(1, 8, 24, 2, 970.00, 1470.00, 235.20, '2024-05-05', GETDATE()),

(1, 9, 25, 1, 0.00, 540.00, 86.40, '2024-03-20', GETDATE()),
(1, 9, 26, 4, 540.00, 1040.00, 166.40, '2024-04-20', GETDATE()),
(1, 9, 27, 2, 1040.00, 1570.00, 251.20, '2024-05-20', GETDATE()),

(1, 10, 28, 1, 0.00, 480.00, 76.80, '2024-03-05', GETDATE()),
(1, 10, 29, 4, 480.00, 980.00, 156.80, '2024-04-05', GETDATE()),
(1, 10, 30, 2, 980.00, 1480.00, 236.80, '2024-05-05', GETDATE());

-- Puestos Sindicato
INSERT INTO RecursosHumanos.PuestoSindicato (nombre, estatus, fecha_mod)
VALUES ('Secretario General', 'A', GETDATE()),
       ('Secretario de Trabajo', 'A', GETDATE()),
       ('Secretario de Finanzas', 'A', GETDATE()),
       ('Secretario de Actas', 'A', GETDATE()),
       ('Secretario de Organización', 'A', GETDATE()),
       ('Delegado Sindical', 'A', GETDATE()),
       ('Comisionado de Vigilancia', 'A', GETDATE()),
       ('Comisionado de Honor', 'A', GETDATE()),
       ('Representante Laboral', 'A', GETDATE()),
       ('Vocal', 'A', GETDATE());

-- Turnos
INSERT INTO RecursosHumanos.Turno (tipo, duracion, hora_entrada, hora_salida, fecha_mod)
VALUES ('MAT', 8, '07:00', '15:00', GETDATE()),
       ('MAT', 8, '08:00', '16:00', GETDATE()),
       ('VES', 8, '14:00', '22:00', GETDATE()),
       ('VES', 8, '15:00', '23:00', GETDATE()),
       ('NOC', 8, '22:00', '06:00', GETDATE()),
       ('NOC', 8, '23:00', '07:00', GETDATE()),
       ('MAT', 6, '06:00', '12:00', GETDATE()),
       ('VES', 6, '12:00', '18:00', GETDATE()),
       ('VES', 6, '13:00', '19:00', GETDATE()),
       ('NOC', 6, '00:00', '06:00', GETDATE());

-- Nómina
INSERT INTO RecursosHumanos.Nomina (clabe, BancoId, fecha_mod)
VALUES ('012650001234567890', 1, GETDATE()),
       ('014650002345678901', 2, GETDATE()),
       ('072650003456789012', 3, GETDATE()),
       ('021650004567890123', 4, GETDATE()),
       ('044650005678901234', 5, GETDATE()),
       ('002650006789012345', 6, GETDATE()),
       ('127650007890123456', 7, GETDATE()),
       ('030650008901234567', 8, GETDATE()),
       ('036650009012345678', 9, GETDATE()),
       ('137650000123456789', 10, GETDATE());

-- Contratos
INSERT INTO RecursosHumanos.ContratoEmpleado (tipo_contrato, fecha_contrato, fecha_vencimiento, enlace_documento,
                                              fecha_mod)
VALUES ('SIN', '2024-01-01', '2025-01-01', 'contratos/2024/SIN001.pdf', GETDATE()),
       ('SIN', '2024-01-15', '2025-01-15', 'contratos/2024/SIN002.pdf', GETDATE()),
       ('CON', '2024-02-01', '2025-02-01', 'contratos/2024/CON001.pdf', GETDATE()),
       ('CON', '2024-02-15', '2025-02-15', 'contratos/2024/CON002.pdf', GETDATE()),
       ('Eve', '2024-03-01', '2024-09-01', 'contratos/2024/EVE001.pdf', GETDATE()),
       ('Eve', '2024-03-15', '2024-09-15', 'contratos/2024/EVE002.pdf', GETDATE()),
       ('SIN', '2024-01-01', '2025-01-01', 'contratos/2024/SIN003.pdf', GETDATE()),
       ('CON', '2024-01-01', '2025-01-01', 'contratos/2024/CON003.pdf', GETDATE()),
       ('Eve', '2024-01-01', '2024-07-01', 'contratos/2024/EVE003.pdf', GETDATE()),
       ('SIN', '2024-02-01', '2025-02-01', 'contratos/2024/SIN004.pdf', GETDATE());

-- Puestos
INSERT INTO RecursosHumanos.Puesto (descripcion, salario_base, bonos, fecha_mod)
VALUES ('Gerente General', 35000.00, 5000.00, GETDATE()),
       ('Jefe de Departamento', 25000.00, 3000.00, GETDATE()),
       ('Supervisor', 20000.00, 2500.00, GETDATE()),
       ('Técnico Especializado', 18000.00, 2000.00, GETDATE()),
       ('Operador', 15000.00, 1500.00, GETDATE()),
       ('Auxiliar Administrativo', 12000.00, 1000.00, GETDATE()),
       ('Almacenista', 11000.00, 1000.00, GETDATE()),
       ('Chofer', 10000.00, 1500.00, GETDATE()),
       ('Vigilante', 9000.00, 1000.00, GETDATE()),
       ('Intendente', 8000.00, 800.00, GETDATE());

-- Empleados
INSERT INTO RecursosHumanos.Empleado (nss, rfc, ContratoId, PuestoId, edo_civil,
                                      fecha_nacimiento, fecha_contratacion, actividad, fecha_mod, PersonaId, TurnoId,
                                      NominaId, EstablecimientoId)
VALUES ('12345678901', 'XAXX010101000', 1, 1, 'CAS', '1980-01-15', '2024-01-01', 'A', GETDATE(), 1, 1, 1, 1),
       ('23456789012', 'XAXX020202000', 2, 2, 'SOL', '1985-02-20', '2024-01-15', 'A', GETDATE(), 2, 2, 2, 1),
       ('34567890123', 'XAXX030303000', 3, 3, 'CAS', '1982-03-25', '2024-02-01', 'A', GETDATE(), 3, 3, 3, 2),
       ('45678901234', 'XAXX040404000', 4, 4, 'DIV', '1988-04-10', '2024-02-15', 'A', GETDATE(), 4, 4, 4, 2),
       ('56789012345', 'XAXX050505000', 5, 5, 'SOL', '1990-05-05', '2024-03-01', 'A', GETDATE(), 5, 5, 5, 3),
       ('67890123456', 'XAXX060606000', 6, 6, 'CAS', '1987-06-15', '2024-03-15', 'A', GETDATE(), 6, 6, 6, 3),
       ('78901234567', 'XAXX070707000', 7, 7, 'SOL', '1992-07-20', '2024-01-01', 'A', GETDATE(), 7, 7, 7, 4),
       ('89012345678', 'XAXX080808000', 8, 8, 'CAS', '1986-08-25', '2024-01-01', 'A', GETDATE(), 8, 8, 8, 4),
       ('90123456789', 'XAXX090909000', 9, 9, 'VIU', '1983-09-30', '2024-01-01', 'A', GETDATE(), 9, 9, 9, 5),
       ('01234567890', 'XAXX101010000', 10, 10, 'SOL', '1991-10-05', '2024-02-01', 'A', GETDATE(), 10, 10, 10, 5);

-- Sindicato
INSERT INTO RecursosHumanos.Sindicato (EmpleadoId, fecha_afiliacion, PuestoSindicatoId, fecha_mod)
VALUES (1, '2024-01-01', 1, GETDATE()),
       (2, '2024-01-15', 2, GETDATE()),
       (3, '2024-02-01', 3, GETDATE()),
       (4, '2024-02-15', 4, GETDATE()),
       (5, '2024-03-01', 5, GETDATE()),
       (6, '2024-03-15', 6, GETDATE()),
       (7, '2024-01-01', 7, GETDATE()),
       (8, '2024-01-01', 8, GETDATE()),
       (9, '2024-01-01', 9, GETDATE()),
       (10, '2024-02-01', 10, GETDATE());

-- Historial Asistencia
INSERT INTO RecursosHumanos.HistorialAsistencia (EmpleadoId, fecha_entrada, fecha_salida, fecha_mod)
VALUES (1, '2024-03-01 07:00', '2024-03-01 15:00', GETDATE()),
       (2, '2024-03-01 08:00', '2024-03-01 16:00', GETDATE()),
       (3, '2024-03-01 14:00', '2024-03-01 22:00', GETDATE()),
       (4, '2024-03-01 15:00', '2024-03-01 23:00', GETDATE()),
       (5, '2024-03-01 22:00', '2024-03-02 06:00', GETDATE()),
       (6, '2024-03-01 23:00', '2024-03-02 07:00', GETDATE()),
       (7, '2024-03-01 06:00', '2024-03-01 12:00', GETDATE()),
       (8, '2024-03-01 12:00', '2024-03-01 18:00', GETDATE()),
       (9, '2024-03-01 13:00', '2024-03-01 19:00', GETDATE()),
       (10, '2024-03-02 00:00', '2024-03-02 06:00', GETDATE());

-- Tipos de Material
INSERT INTO Inventarios.TipoMaterial (descripcion, fecha_mod)
VALUES ('Tubería PVC', GETDATE()),
       ('Material Eléctrico', GETDATE()),
       ('Herramientas', GETDATE()),
       ('Material de Construcción', GETDATE()),
       ('Válvulas', GETDATE()),
       ('Medidores', GETDATE()),
       ('Conexiones', GETDATE()),
       ('Material de Oficina', GETDATE()),
       ('Químicos para Tratamiento', GETDATE()),
       ('Repuestos', GETDATE());

-- Materiales
INSERT INTO Inventarios.Material (nombre, descripcion, actividad, TipoMaterialId, fecha_mod)
VALUES ('Tubo PVC 4"', 'Tubo PVC hidráulico', 'A', 1, GETDATE()),
       ('Cable 12AWG', 'Cable eléctrico negro', 'A', 2, GETDATE()),
       ('Martillo', 'Martillo de bola 2lb', 'A', 3, GETDATE()),
       ('Cemento', 'Cemento gris 50kg', 'A', 4, GETDATE()),
       ('Válvula 2"', 'Válvula de compuerta', 'A', 5, GETDATE()),
       ('Medidor 1/2"', 'Medidor doméstico', 'A', 6, GETDATE()),
       ('Codo 90° 3"', 'Codo PVC hidráulico', 'A', 7, GETDATE()),
       ('Papel', 'Papel bond carta', 'A', 8, GETDATE()),
       ('Cloro', 'Hipoclorito de sodio', 'A', 9, GETDATE()),
       ('Bomba 5HP', 'Bomba sumergible', 'A', 10, GETDATE());

-- Tipos de Mobiliario
INSERT INTO Inventarios.TipoMobiliario (descripcion, fecha_mod)
VALUES ('Escritorio', GETDATE()),
       ('Silla', GETDATE()),
       ('Archivero', GETDATE()),
       ('Mesa', GETDATE()),
       ('Gabinete', GETDATE()),
       ('Estante', GETDATE()),
       ('Mostrador', GETDATE()),
       ('Locker', GETDATE()),
       ('Banco', GETDATE()),
       ('Librero', GETDATE());

-- Mobiliario
INSERT INTO Inventarios.Mobiliario (nombre, descripcion, actividad, TipoMobiliarioId, fecha_mod)
VALUES ('Escritorio Ejecutivo', 'Escritorio en L con cajones', 'A', 1, GETDATE()),
       ('Silla Ergonómica', 'Silla giratoria con brazos', 'A', 2, GETDATE()),
       ('Archivero 4G', 'Archivero metálico 4 gavetas', 'A', 3, GETDATE()),
       ('Mesa Juntas', 'Mesa sala juntas 8 personas', 'A', 4, GETDATE()),
       ('Gabinete Metal', 'Gabinete herramientas', 'A', 5, GETDATE()),
       ('Estante Industrial', 'Estante almacén 5 niveles', 'A', 6, GETDATE()),
       ('Mostrador Atención', 'Mostrador recepción', 'A', 7, GETDATE()),
       ('Locker 6P', 'Locker 6 puertas personal', 'A', 8, GETDATE()),
       ('Banco Trabajo', 'Banco taller alto', 'A', 9, GETDATE()),
       ('Librero Oficina', 'Librero 5 repisas', 'A', 10, GETDATE());

-- Taller Vehículo
INSERT INTO Inventarios.TallerVehiculo (PersonaId, fecha_mod)
VALUES (1, GETDATE()),
       (2, GETDATE()),
       (3, GETDATE()),
       (4, GETDATE()),
       (5, GETDATE()),
       (6, GETDATE()),
       (7, GETDATE()),
       (8, GETDATE()),
       (9, GETDATE()),
       (10, GETDATE());

-- Tipo Vehículo
INSERT INTO Inventarios.TipoVehiculo (nombre, fecha_mod)
VALUES ('Camioneta Pick-up', GETDATE()),
       ('Sedan', GETDATE()),
       ('Camión Pipa', GETDATE()),
       ('Retroexcavadora', GETDATE()),
       ('Motocicleta', GETDATE()),
       ('Camión Volteo', GETDATE()),
       ('Van', GETDATE()),
       ('Grúa', GETDATE()),
       ('Camión Vactor', GETDATE()),
       ('Tractor', GETDATE());

-- Vehículos
INSERT INTO Inventarios.Vehiculo (TipoVehiculoId, matricula, actividad, EstablecimientoId, fecha_mod)
VALUES (1, 'JAP-001', 'A', 1, GETDATE()),
       (2, 'JAP-002', 'A', 1, GETDATE()),
       (3, 'JAP-003', 'A', 2, GETDATE()),
       (4, 'JAP-004', 'A', 2, GETDATE()),
       (5, 'JAP-005', 'A', 3, GETDATE()),
       (6, 'JAP-006', 'A', 3, GETDATE()),
       (7, 'JAP-007', 'A', 4, GETDATE()),
       (8, 'JAP-008', 'A', 4, GETDATE()),
       (9, 'JAP-009', 'A', 5, GETDATE()),
       (10, 'JAP-010', 'A', 5, GETDATE());

-- Reporte Vehículo
INSERT INTO Inventarios.ReporteVehiculo (VehiculoId, TallerId, descripcion, fecha_reporte, fecha_mod)
VALUES (1, 1, 'Mantenimiento preventivo', '2024-03-01', GETDATE()),
       (2, 2, 'Cambio de aceite', '2024-03-02', GETDATE()),
       (3, 3, 'Reparación frenos', '2024-03-03', GETDATE()),
       (4, 4, 'Revisión general', '2024-03-04', GETDATE()),
       (5, 5, 'Cambio llantas', '2024-03-05', GETDATE()),
       (6, 6, 'Alineación y balanceo', '2024-03-06', GETDATE()),
       (7, 7, 'Reparación suspensión', '2024-03-07', GETDATE()),
       (8, 8, 'Diagnóstico motor', '2024-03-08', GETDATE()),
       (9, 9, 'Servicio completo', '2024-03-09', GETDATE()),
       (10, 10, 'Reparación sistema hidráulico', '2024-03-10', GETDATE());

-- Inventario
INSERT INTO Inventarios.Inventario (MaterialId, MobiliarioId, VehiculoId, cantidad, fecha_mod)
VALUES (1, NULL, NULL, 100, GETDATE()),
       (2, NULL, NULL, 500, GETDATE()),
       (3, NULL, NULL, 20, GETDATE()),
       (4, NULL, NULL, 200, GETDATE()),
       (5, NULL, NULL, 50, GETDATE()),
       (NULL, 1, NULL, 10, GETDATE()),
       (NULL, 2, NULL, 30, GETDATE()),
       (NULL, 3, NULL, 15, GETDATE()),
       (NULL, NULL, 1, 1, GETDATE()),
       (NULL, NULL, 2, 1, GETDATE());

-- Facturación
INSERT INTO Inventarios.Facturacion (EstablecimientoId, fecha_factura, enlace_documento, fecha_mod)
VALUES (1, '2024-03-01', 'facturas/2024/FAC001.pdf', GETDATE()),
       (1, '2024-03-02', 'facturas/2024/FAC002.pdf', GETDATE()),
       (2, '2024-03-03', 'facturas/2024/FAC003.pdf', GETDATE()),
       (2, '2024-03-04', 'facturas/2024/FAC004.pdf', GETDATE()),
       (3, '2024-03-05', 'facturas/2024/FAC005.pdf', GETDATE()),
       (3, '2024-03-06', 'facturas/2024/FAC006.pdf', GETDATE()),
       (4, '2024-03-07', 'facturas/2024/FAC007.pdf', GETDATE()),
       (4, '2024-03-08', 'facturas/2024/FAC008.pdf', GETDATE()),
       (5, '2024-03-09', 'facturas/2024/FAC009.pdf', GETDATE()),
       (5, '2024-03-10', 'facturas/2024/FAC010.pdf', GETDATE());

-- Proveedor
INSERT INTO Inventarios.Proveedor (PersonaId, fecha_mod)
VALUES (16, GETDATE()),
       (17, GETDATE()),
       (18, GETDATE()),
       (19, GETDATE()),
       (20, GETDATE()),
       (21, GETDATE()),
       (22, GETDATE()),
       (23, GETDATE()),
       (24, GETDATE()),
       (25, GETDATE());

-- Compra
INSERT INTO Inventarios.Compra (ProductoId, FacturaId, ProveedorId, fecha_compra, monto, cantidad, fecha_mod)
VALUES (1, 1, 1, '2024-03-01', 5000.00, 50, GETDATE()),
       (2, 2, 2, '2024-03-02', 3000.00, 100, GETDATE()),
       (3, 3, 3, '2024-03-03', 2000.00, 10, GETDATE()),
       (4, 4, 4, '2024-03-04', 10000.00, 100, GETDATE()),
       (5, 5, 5, '2024-03-05', 7500.00, 25, GETDATE()),
       (6, 6, 6, '2024-03-06', 15000.00, 5, GETDATE()),
       (7, 7, 7, '2024-03-07', 12000.00, 15, GETDATE()),
       (8, 8, 8, '2024-03-08', 8000.00, 20, GETDATE()),
       (9, 9, 9, '2024-03-09', 20000.00, 1, GETDATE()),
       (10, 10, 10, '2024-03-10', 25000.00, 1, GETDATE());

-- Reporte Problema (10 reportes)
INSERT INTO Servicios.ReporteProblema (descripcion, fecha_reporte, EmpleadoId,
                                       seguimiento, DepartamentoId, observaciones, fecha_mod)
VALUES ('Fuga en medidor', '2024-03-01', 1, 'En proceso', 3, 'Prioridad alta', GETDATE()),
       ('Sin servicio', '2024-03-02', 2, 'Resuelto', 3, 'Válvula cerrada', GETDATE()),
       ('Baja presión', '2024-03-03', 3, 'En revisión', 3, 'Zona alta', GETDATE()),
       ('Agua turbia', '2024-03-04', 4, 'En proceso', 9, 'Toma muestra', GETDATE()),
       ('Medidor dañado', '2024-03-05', 5, 'Programado', 8, 'Requiere cambio', GETDATE()),
       ('Fuga en calle', '2024-03-06', 6, 'En proceso', 3, 'Excavación mayor', GETDATE()),
       ('Drenaje tapado', '2024-03-07', 7, 'Pendiente', 3, 'Usar vactor', GETDATE()),
       ('Error lectura', '2024-03-08', 8, 'Resuelto', 8, 'Corregir sistema', GETDATE()),
       ('Reconexión', '2024-03-09', 9, 'Programado', 3, 'Pago verificado', GETDATE()),
       ('Fuga matriz', '2024-03-10', 10, 'Urgente', 3, 'Corte general', GETDATE());

-- Suspensión Servicio (10 suspensiones)
INSERT INTO Servicios.SuspensionServicio (actividad, descricpion,
                                          fecha_suspension, enlace_documento, fecha_mod)
VALUES ('T', 'Falta de pago 3 meses', '2024-03-01', 'suspensiones/2024/SUS001.pdf', GETDATE()),
       ('P', 'Baja definitiva', '2024-03-02', 'suspensiones/2024/SUS002.pdf', GETDATE()),
       ('T', 'Mantenimiento red', '2024-03-03', 'suspensiones/2024/SUS003.pdf', GETDATE()),
       ('T', 'Reparación línea', '2024-03-04', 'suspensiones/2024/SUS004.pdf', GETDATE()),
       ('P', 'Demolición inmueble', '2024-03-05', 'suspensiones/2024/SUS005.pdf', GETDATE()),
       ('T', 'Fuga mayor', '2024-03-06', 'suspensiones/2024/SUS006.pdf', GETDATE()),
       ('T', 'Solicitud cliente', '2024-03-07', 'suspensiones/2024/SUS007.pdf', GETDATE()),
       ('P', 'Cambio uso suelo', '2024-03-08', 'suspensiones/2024/SUS008.pdf', GETDATE()),
       ('T', 'Trabajos viales', '2024-03-09', 'suspensiones/2024/SUS009.pdf', GETDATE()),
       ('T', 'Reconexión pendiente', '2024-03-10', 'suspensiones/2024/SUS010.pdf', GETDATE());

-- Carta No Adeudos (10 cartas)
INSERT INTO Servicios.CartaNoAdeudos (enlace_documento, fecha_mod)
VALUES ('cartas/2024/CNA001.pdf', GETDATE()),
       ('cartas/2024/CNA002.pdf', GETDATE()),
       ('cartas/2024/CNA003.pdf', GETDATE()),
       ('cartas/2024/CNA004.pdf', GETDATE()),
       ('cartas/2024/CNA005.pdf', GETDATE()),
       ('cartas/2024/CNA006.pdf', GETDATE()),
       ('cartas/2024/CNA007.pdf', GETDATE()),
       ('cartas/2024/CNA008.pdf', GETDATE()),
       ('cartas/2024/CNA009.pdf', GETDATE()),
       ('cartas/2024/CNA010.pdf', GETDATE());

-- Programa Descuento (10 programas)
INSERT INTO Servicios.ProgramaDescuento (descricpion, porcentaje_aplicado,
                                         fecha_inicio, fecha_final, fecha_mod)
VALUES ('Pensionados IMSS', 50.00, '2024-01-01', '2024-12-31', GETDATE()),
       ('INAPAM', 40.00, '2024-01-01', '2024-12-31', GETDATE()),
       ('Pago anual anticipado', 15.00, '2024-01-01', '2024-03-31', GETDATE()),
       ('Escuelas públicas', 30.00, '2024-01-01', '2024-12-31', GETDATE()),
       ('Personas discapacidad', 45.00, '2024-01-01', '2024-12-31', GETDATE()),
       ('Madre soltera', 25.00, '2024-01-01', '2024-12-31', GETDATE()),
       ('Jubilados municipales', 35.00, '2024-01-01', '2024-12-31', GETDATE()),
       ('Casa hogar', 100.00, '2024-01-01', '2024-12-31', GETDATE()),
       ('Bomberos', 100.00, '2024-01-01', '2024-12-31', GETDATE()),
       ('Regularización', 20.00, '2024-03-01', '2024-05-31', GETDATE());

-- Ticket Servicio (30 tickets, uno por cada servicio)
INSERT INTO Servicios.TicketServicio (ClienteId, SuspensionId, ReporteProblema,
                                      ProgramaDescuento, CartaNoAdeudos, fecha_mod)
VALUES
-- 10 tickets con reportes
(1, NULL, 1, NULL, NULL, GETDATE()),
(2, NULL, 2, NULL, NULL, GETDATE()),
(3, NULL, 3, NULL, NULL, GETDATE()),
(4, NULL, 4, NULL, NULL, GETDATE()),
(5, NULL, 5, NULL, NULL, GETDATE()),
(6, NULL, 6, NULL, NULL, GETDATE()),
(7, NULL, 7, NULL, NULL, GETDATE()),
(8, NULL, 8, NULL, NULL, GETDATE()),
(9, NULL, 9, NULL, NULL, GETDATE()),
(10, NULL, 10, NULL, NULL, GETDATE()),
-- 10 tickets con suspensiones
(1, 1, NULL, NULL, NULL, GETDATE()),
(2, 2, NULL, NULL, NULL, GETDATE()),
(3, 3, NULL, NULL, NULL, GETDATE()),
(4, 4, NULL, NULL, NULL, GETDATE()),
(5, 5, NULL, NULL, NULL, GETDATE()),
(6, 6, NULL, NULL, NULL, GETDATE()),
(7, 7, NULL, NULL, NULL, GETDATE()),
(8, 8, NULL, NULL, NULL, GETDATE()),
(9, 9, NULL, NULL, NULL, GETDATE()),
(10, 10, NULL, NULL, NULL, GETDATE()),
-- 10 tickets con cartas de no adeudo
(1, NULL, NULL, NULL, 1, GETDATE()),
(2, NULL, NULL, NULL, 2, GETDATE()),
(3, NULL, NULL, NULL, 3, GETDATE()),
(4, NULL, NULL, NULL, 4, GETDATE()),
(5, NULL, NULL, NULL, 5, GETDATE()),
(6, NULL, NULL, NULL, 6, GETDATE()),
(7, NULL, NULL, NULL, 7, GETDATE()),
(8, NULL, NULL, NULL, 8, GETDATE()),
(9, NULL, NULL, NULL, 9, GETDATE()),
(10, NULL, NULL, NULL, 10, GETDATE());
