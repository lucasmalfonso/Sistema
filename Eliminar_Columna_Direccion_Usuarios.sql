-- =============================================
-- Script para eliminar columna Dirección de los stored procedures de usuarios
-- Ejecutar este script en SQL Server Management Studio
-- =============================================

USE [Sistema]
GO

-- =============================================
-- 1. ACTUALIZAR STORED PROCEDURE: usuario_listar
-- Elimina la columna direccion del SELECT
-- =============================================

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usuario_listar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[usuario_listar]
GO

CREATE PROCEDURE [dbo].[usuario_listar]
AS
BEGIN
    SELECT u.idusuario AS ID,
           u.idrol,
           r.nombre AS Rol,
           u.nombre AS Nombre,
           u.tipo_documento AS Tipo_Documento,
           u.num_documento AS Num_Documento,
           u.telefono AS Telefono,
           u.email AS Email,
           u.usuario AS Usuario,
           u.estado AS Estado
    FROM usuario u 
    INNER JOIN rol r ON u.idrol = r.idrol
    ORDER BY u.idusuario DESC
END
GO

PRINT 'Stored procedure usuario_listar actualizado (columna Dirección eliminada).'
GO

-- =============================================
-- 2. ACTUALIZAR STORED PROCEDURE: usuario_buscar
-- Elimina la columna direccion del SELECT
-- =============================================

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usuario_buscar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[usuario_buscar]
GO

CREATE PROCEDURE [dbo].[usuario_buscar]
    @valor VARCHAR(50)
AS
BEGIN
    SELECT u.idusuario AS ID,
           u.idrol,
           r.nombre AS Rol,
           u.nombre AS Nombre,
           u.tipo_documento AS Tipo_Documento,
           u.num_documento AS Num_Documento,
           u.telefono AS Telefono,
           u.email AS Email,
           u.usuario AS Usuario,
           u.estado AS Estado
    FROM usuario u 
    INNER JOIN rol r ON u.idrol = r.idrol
    WHERE u.nombre LIKE '%' + @valor + '%' 
       OR u.email LIKE '%' + @valor + '%' 
       OR u.usuario LIKE '%' + @valor + '%'
    ORDER BY u.nombre ASC
END
GO

PRINT 'Stored procedure usuario_buscar actualizado (columna Dirección eliminada).'
GO

-- =============================================
-- RESUMEN
-- =============================================

PRINT ''
PRINT '============================================='
PRINT 'Actualización completada exitosamente!'
PRINT '============================================='
PRINT 'La columna "Dirección" ha sido eliminada de:'
PRINT '1. Stored procedure usuario_listar'
PRINT '2. Stored procedure usuario_buscar'
PRINT '============================================='
PRINT ''
PRINT 'NOTA: La columna direccion sigue existiendo en la tabla usuario,'
PRINT 'pero ya no se mostrará en los listados ni búsquedas.'
PRINT '============================================='
GO







