-- =============================================
-- Script para Actualizar venta_listar_detalle
-- =============================================
-- Este script actualiza el stored procedure venta_listar_detalle
-- para soportar tanto artículos como servicios en el detalle de ventas
-- =============================================

USE [dbsistemaprod]  -- Cambiar por el nombre de tu base de datos
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

PRINT '========================================';
PRINT 'Actualizando stored procedure venta_listar_detalle...';
PRINT '========================================';
GO

-- =============================================
-- Eliminar el stored procedure existente
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_listar_detalle]') AND type in (N'P', N'PC'))
BEGIN
    DROP PROCEDURE [dbo].[venta_listar_detalle];
    PRINT 'Stored procedure venta_listar_detalle eliminado.';
END
GO

-- =============================================
-- Crear el stored procedure actualizado
-- =============================================
CREATE PROCEDURE [dbo].[venta_listar_detalle]
    @idventa int
AS
BEGIN
    -- Artículos primero, luego servicios, ordenados por nombre
    SELECT d.idarticulo as ID, a.nombre as ARTICULO,
           d.cantidad as CANTIDAD, d.precio as PRECIO, d.descuento as DESCUENTO,
           ((d.cantidad*d.precio)-d.descuento) as IMPORTE,
           0 as TIPO  -- 0 = Artículo
    FROM detalle_venta d 
    INNER JOIN articulo a ON d.idarticulo = a.idarticulo
    WHERE d.idventa = @idventa AND d.idarticulo IS NOT NULL
    
    UNION ALL
    
    -- Servicios
    SELECT d.idservicio as ID, s.nombre as ARTICULO,
           d.cantidad as CANTIDAD, d.precio as PRECIO, d.descuento as DESCUENTO,
           ((d.cantidad*d.precio)-d.descuento) as IMPORTE,
           1 as TIPO  -- 1 = Servicio
    FROM detalle_venta d 
    INNER JOIN servicio s ON d.idservicio = s.idservicio
    WHERE d.idventa = @idventa AND d.idservicio IS NOT NULL
    
    ORDER BY TIPO, ARTICULO;  -- Primero artículos, luego servicios, ordenados por nombre
END
GO

PRINT '';
PRINT '========================================';
PRINT 'Stored procedure venta_listar_detalle actualizado exitosamente!';
PRINT '========================================';
PRINT '';
PRINT 'Mejoras implementadas:';
PRINT '  ✓ Soporte para mostrar artículos y servicios';
PRINT '  ✓ Columna TIPO agregada (0 = Artículo, 1 = Servicio)';
PRINT '  ✓ Ordenamiento: primero artículos, luego servicios, ambos por nombre';
PRINT '  ✓ UNION ALL para combinar ambos tipos de items';
PRINT '';
PRINT 'El stored procedure ahora muestra correctamente:';
PRINT '  - Todos los artículos de la venta (ordenados por nombre)';
PRINT '  - Todos los servicios de la venta (ordenados por nombre)';
PRINT '  - Ambos en la misma consulta con las mismas columnas';
PRINT '========================================';
GO


