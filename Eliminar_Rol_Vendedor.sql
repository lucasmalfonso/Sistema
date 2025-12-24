-- =============================================
-- Script para eliminar el rol "Vendedor" de la base de datos
-- Ejecutar este script en SQL Server Management Studio
-- =============================================

USE [Sistema]
GO

-- Verificar si existen usuarios con el rol "Vendedor" antes de eliminar
-- Si hay usuarios con este rol, primero deberás cambiarles el rol o eliminarlos

-- Opción 1: Eliminar directamente el rol (si no hay usuarios asociados)
DELETE FROM rol
WHERE nombre = 'Vendedor'
GO

-- Opción 2: Si hay usuarios con este rol y quieres eliminarlos primero:
-- Primero elimina los usuarios con el rol Vendedor
-- DELETE FROM usuario WHERE idrol = (SELECT idrol FROM rol WHERE nombre = 'Vendedor')
-- Luego elimina el rol
-- DELETE FROM rol WHERE nombre = 'Vendedor'

-- Opción 3: Si hay usuarios con este rol y quieres cambiarles el rol a otro (ej: Administrador):
-- UPDATE usuario SET idrol = (SELECT idrol FROM rol WHERE nombre = 'Administrador') 
-- WHERE idrol = (SELECT idrol FROM rol WHERE nombre = 'Vendedor')
-- Luego elimina el rol
-- DELETE FROM rol WHERE nombre = 'Vendedor'

-- Verificar que se eliminó correctamente
SELECT * FROM rol WHERE nombre = 'Vendedor'
-- Si no devuelve resultados, el rol fue eliminado correctamente
GO

PRINT 'Script ejecutado. Verifica que el rol Vendedor haya sido eliminado.'
GO

