-- =============================================
-- Script para modificar la tabla ingreso
-- Elimina columnas: serie_comprobante, num_comprobante, impuesto
-- Orden final: idingreso, idproveedor, idusuario, fecha, total, estado
-- =============================================
-- EJECUTAR ESTE SCRIPT EN LA BASE DE DATOS
-- =============================================

-- =============================================
-- 1. Verificar y eliminar restricciones que dependan de las columnas a eliminar
-- =============================================

-- Verificar si existen índices o restricciones en las columnas a eliminar
-- (SQL Server generalmente las elimina automáticamente, pero es bueno verificar)

-- =============================================
-- 2. Eliminar columnas de la tabla ingreso
-- =============================================

-- Eliminar columna serie_comprobante si existe
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[ingreso]') AND name = 'serie_comprobante')
BEGIN
    ALTER TABLE [dbo].[ingreso]
    DROP COLUMN [serie_comprobante];
    PRINT 'Columna serie_comprobante eliminada.';
END
GO

-- Eliminar columna num_comprobante si existe
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[ingreso]') AND name = 'num_comprobante')
BEGIN
    -- Primero hacerla NULL si tiene restricción NOT NULL
    ALTER TABLE [dbo].[ingreso]
    ALTER COLUMN [num_comprobante] VARCHAR(10) NULL;
    GO
    
    ALTER TABLE [dbo].[ingreso]
    DROP COLUMN [num_comprobante];
    PRINT 'Columna num_comprobante eliminada.';
END
GO

-- Eliminar columna impuesto si existe
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[ingreso]') AND name = 'impuesto')
BEGIN
    -- Primero hacerla NULL si tiene restricción NOT NULL
    ALTER TABLE [dbo].[ingreso]
    ALTER COLUMN [impuesto] DECIMAL(4,2) NULL;
    GO
    
    ALTER TABLE [dbo].[ingreso]
    DROP COLUMN [impuesto];
    PRINT 'Columna impuesto eliminada.';
END
GO

PRINT '=============================================';
PRINT 'Modificación de tabla ingreso completada.';
PRINT 'Columnas eliminadas: serie_comprobante, num_comprobante, impuesto';
PRINT '=============================================';

