-- Script para agregar la columna Fecha_Nacimiento a la tabla Persona
-- Ejecutar este script primero en la base de datos

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
