-- =============================================
-- Script para eliminar el rol "Almacenero" de la base de datos
-- Ejecutar este script en SQL Server Management Studio
-- =============================================

USE [Sistema]
GO

-- Verificar si existen usuarios con el rol "Almacenero" antes de eliminar
-- Si hay usuarios con este rol, primero deberás cambiarles el rol o eliminarlos

-- Opción 1: Eliminar directamente el rol (si no hay usuarios asociados)
DELETE FROM rol
WHERE nombre = 'Almacenero'
GO

-- Opción 2: Si hay usuarios con este rol y quieres eliminarlos primero:
-- Primero elimina los usuarios con el rol Almacenero
-- DELETE FROM usuario WHERE idrol = (SELECT idrol FROM rol WHERE nombre = 'Almacenero')
-- Luego elimina el rol
-- DELETE FROM rol WHERE nombre = 'Almacenero'

-- Verificar que se eliminó correctamente
SELECT * FROM rol WHERE nombre = 'Almacenero'
-- Si no devuelve resultados, el rol fue eliminado correctamente
GO

PRINT 'Script ejecutado. Verifica que el rol Almacenero haya sido eliminado.'
GO

