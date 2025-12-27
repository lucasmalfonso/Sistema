-- Script para modificar el stored procedure persona_buscar
-- Agregando soporte para Fecha_Nacimiento

USE [tu_base_datos_aqui]
GO

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

PRINT 'Stored procedure persona_buscar actualizado exitosamente'
GO
