-- Script para modificar el stored procedure persona_actualizar
-- Agregando soporte para Fecha_Nacimiento

USE [tu_base_datos_aqui]
GO

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

PRINT 'Stored procedure persona_actualizar actualizado exitosamente'
GO
