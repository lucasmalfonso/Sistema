-- Script para modificar los stored procedures de listado
-- persona_listar

USE [tu_base_datos_aqui]
GO

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

PRINT 'Stored procedure persona_listar actualizado exitosamente'
GO
