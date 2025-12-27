-- SCRIPT COMPLETO DE EJECUCIÓN EN ORDEN
-- Ejecutar primero el script 01, luego los demás en orden

-- =============================================================================
-- PASO 1: AGREGAR COLUMNA A LA TABLA
-- =============================================================================

USE [tu_base_datos_aqui]
GO

-- Agregar la columna Fecha_Nacimiento a la tabla Persona
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'Persona' AND COLUMN_NAME = 'Fecha_Nacimiento')
BEGIN
    ALTER TABLE Persona
    ADD Fecha_Nacimiento DATETIME NULL DEFAULT GETDATE();
    PRINT 'Columna Fecha_Nacimiento agregada exitosamente a la tabla Persona';
END
ELSE
BEGIN
    PRINT 'La columna Fecha_Nacimiento ya existe en la tabla Persona';
END
GO

-- =============================================================================
-- PASO 2-9: RECREAR STORED PROCEDURES
-- =============================================================================

-- persona_insertar
DROP PROCEDURE IF EXISTS persona_insertar
GO

CREATE PROCEDURE persona_insertar
    @tipo_persona VARCHAR(50),
    @nombre VARCHAR(100),
    @tipo_documento VARCHAR(50),
    @num_documento VARCHAR(50),
    @direccion VARCHAR(200),
    @telefono VARCHAR(20),
    @email VARCHAR(100),
    @fecha_nacimiento DATETIME
AS
BEGIN
    INSERT INTO Persona (
        Tipo_Persona,
        Nombre,
        Tipo_Documento,
      Num_Documento,
        Direccion,
        Telefono,
        Email,
        Fecha_Nacimiento
    )
    VALUES (
        @tipo_persona,
  @nombre,
        @tipo_documento,
   @num_documento,
        @direccion,
        @telefono,
    @email,
        @fecha_nacimiento
    )
END
GO

-- persona_actualizar
DROP PROCEDURE IF EXISTS persona_actualizar
GO

CREATE PROCEDURE persona_actualizar
    @idpersona INT,
 @tipo_persona VARCHAR(50),
    @nombre VARCHAR(100),
    @tipo_documento VARCHAR(50),
    @num_documento VARCHAR(50),
    @direccion VARCHAR(200),
@telefono VARCHAR(20),
    @email VARCHAR(100),
    @fecha_nacimiento DATETIME
AS
BEGIN
    UPDATE Persona
    SET
        Tipo_Persona = @tipo_persona,
        Nombre = @nombre,
        Tipo_Documento = @tipo_documento,
        Num_Documento = @num_documento,
     Direccion = @direccion,
        Telefono = @telefono,
        Email = @email,
     Fecha_Nacimiento = @fecha_nacimiento
    WHERE IdPersona = @idpersona
END
GO

-- persona_listar
DROP PROCEDURE IF EXISTS persona_listar
GO

CREATE PROCEDURE persona_listar
AS
BEGIN
    SELECT
IdPersona AS ID,
        Tipo_Persona,
 Nombre,
        Tipo_Documento,
        Num_Documento,
      Direccion,
  Telefono,
        Email,
        Fecha_Nacimiento
    FROM Persona
    ORDER BY Nombre
END
GO

-- persona_listar_clientes
DROP PROCEDURE IF EXISTS persona_listar_clientes
GO

CREATE PROCEDURE persona_listar_clientes
AS
BEGIN
    SELECT
        IdPersona AS ID,
        Tipo_Persona,
    Nombre,
        Tipo_Documento,
        Num_Documento,
        Direccion,
        Telefono,
        Email,
   Fecha_Nacimiento
    FROM Persona
    WHERE Tipo_Persona = 'Cliente'
    ORDER BY Nombre
END
GO

-- persona_listar_proveedores
DROP PROCEDURE IF EXISTS persona_listar_proveedores
GO

CREATE PROCEDURE persona_listar_proveedores
AS
BEGIN
    SELECT
   IdPersona AS ID,
        Tipo_Persona,
        Nombre,
        Tipo_Documento,
  Num_Documento,
        Direccion,
        Telefono,
        Email,
        Fecha_Nacimiento
    FROM Persona
    WHERE Tipo_Persona = 'Proveedor'
 ORDER BY Nombre
END
GO

-- persona_buscar
DROP PROCEDURE IF EXISTS persona_buscar
GO

CREATE PROCEDURE persona_buscar
    @valor VARCHAR(100)
AS
BEGIN
    SELECT
        IdPersona AS ID,
        Tipo_Persona,
   Nombre,
        Tipo_Documento,
     Num_Documento,
  Direccion,
        Telefono,
        Email,
        Fecha_Nacimiento
    FROM Persona
    WHERE Nombre LIKE '%' + @valor + '%'
        OR Num_Documento LIKE '%' + @valor + '%'
        OR Email LIKE '%' + @valor + '%'
    ORDER BY Nombre
END
GO

-- persona_buscar_clientes
DROP PROCEDURE IF EXISTS persona_buscar_clientes
GO

CREATE PROCEDURE persona_buscar_clientes
    @valor VARCHAR(100)
AS
BEGIN
    SELECT
        IdPersona AS ID,
        Tipo_Persona,
        Nombre,
        Tipo_Documento,
      Num_Documento,
        Direccion,
        Telefono,
      Email,
        Fecha_Nacimiento
    FROM Persona
  WHERE Tipo_Persona = 'Cliente'
        AND (Nombre LIKE '%' + @valor + '%'
            OR Num_Documento LIKE '%' + @valor + '%'
    OR Email LIKE '%' + @valor + '%')
    ORDER BY Nombre
END
GO

-- persona_buscar_proveedores
DROP PROCEDURE IF EXISTS persona_buscar_proveedores
GO

CREATE PROCEDURE persona_buscar_proveedores
    @valor VARCHAR(100)
AS
BEGIN
    SELECT
        IdPersona AS ID,
        Tipo_Persona,
        Nombre,
        Tipo_Documento,
        Num_Documento,
        Direccion,
        Telefono,
        Email,
        Fecha_Nacimiento
    FROM Persona
    WHERE Tipo_Persona = 'Proveedor'
        AND (Nombre LIKE '%' + @valor + '%'
            OR Num_Documento LIKE '%' + @valor + '%'
  OR Email LIKE '%' + @valor + '%')
    ORDER BY Nombre
END
GO

PRINT '======================================'
PRINT 'Todos los scripts se ejecutaron correctamente'
PRINT '======================================'
GO
