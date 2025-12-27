-- Script para modificar los stored procedures de listado de proveedores
-- persona_listar_proveedores

USE [tu_base_datos_aqui]
GO

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

PRINT 'Stored procedure persona_listar_proveedores actualizado exitosamente'
GO
