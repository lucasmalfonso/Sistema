-- =============================================
-- Script para crear el rol "Soporte" en la base de datos
-- Ejecutar este script en SQL Server Management Studio
-- =============================================

USE [Sistema]
GO

-- Verificar si el rol "Soporte" ya existe antes de crearlo
IF EXISTS (SELECT 1 FROM rol WHERE nombre = 'Soporte')
BEGIN
    PRINT 'El rol "Soporte" ya existe en la base de datos.'
    SELECT * FROM rol WHERE nombre = 'Soporte'
END
ELSE
BEGIN
    -- Insertar el nuevo rol "Soporte"
    -- El campo idrol se auto-generará con IDENTITY
    -- El campo estado tomará el valor por defecto (1 = activo)
    -- El campo descripcion será NULL
    INSERT INTO rol (nombre, descripcion, estado)
    VALUES ('Soporte', NULL, 1)
    
    PRINT 'Rol "Soporte" creado exitosamente.'
    
    -- Verificar que se creó correctamente
    SELECT * FROM rol WHERE nombre = 'Soporte'
END
GO

