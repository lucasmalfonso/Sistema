-- =============================================
-- Script para modificar la tabla venta
-- Elimina columnas: serie_comprobante, num_comprobante, impuesto
-- Orden final: idventa, idcliente, idusuario, fecha, forma_pago, cuota, moneda, total, estado
-- =============================================
-- EJECUTAR ESTE SCRIPT EN LA BASE DE DATOS
-- =============================================

-- =============================================
-- 1. Verificar y eliminar restricciones que dependan de las columnas a eliminar
-- =============================================

-- Verificar si existen índices o restricciones en las columnas a eliminar
-- (SQL Server generalmente las elimina automáticamente, pero es bueno verificar)

-- =============================================
-- 2. Eliminar columnas de la tabla venta
-- =============================================

-- Eliminar columna serie_comprobante si existe
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[venta]') AND name = 'serie_comprobante')
BEGIN
    ALTER TABLE [dbo].[venta]
    DROP COLUMN [serie_comprobante];
    PRINT 'Columna serie_comprobante eliminada.';
END
GO

-- Eliminar columna num_comprobante si existe
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[venta]') AND name = 'num_comprobante')
BEGIN
    -- Primero hacerla NULL si tiene restricción NOT NULL
    ALTER TABLE [dbo].[venta]
    ALTER COLUMN [num_comprobante] VARCHAR(10) NULL;
    GO
    
    ALTER TABLE [dbo].[venta]
    DROP COLUMN [num_comprobante];
    PRINT 'Columna num_comprobante eliminada.';
END
GO

-- Eliminar columna impuesto si existe
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[venta]') AND name = 'impuesto')
BEGIN
    -- Primero hacerla NULL si tiene restricción NOT NULL
    ALTER TABLE [dbo].[venta]
    ALTER COLUMN [impuesto] DECIMAL(4,2) NULL;
    GO
    
    ALTER TABLE [dbo].[venta]
    DROP COLUMN [impuesto];
    PRINT 'Columna impuesto eliminada.';
END
GO

-- =============================================
-- 3. Asegurar que las columnas necesarias existen
-- =============================================

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[venta]') AND name = 'forma_pago')
BEGIN
    ALTER TABLE [dbo].[venta] ADD [forma_pago] VARCHAR(50) NULL;
    PRINT 'Columna forma_pago agregada.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[venta]') AND name = 'cuota')
BEGIN
    ALTER TABLE [dbo].[venta] ADD [cuota] VARCHAR(20) NULL;
    PRINT 'Columna cuota agregada.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[venta]') AND name = 'moneda')
BEGIN
    ALTER TABLE [dbo].[venta] ADD [moneda] VARCHAR(20) NULL;
    PRINT 'Columna moneda agregada.';
END
GO

-- =============================================
-- 4. Actualizar stored procedure venta_insertar
-- =============================================

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_insertar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_insertar];
GO

CREATE PROCEDURE [dbo].[venta_insertar]
    @idusuario int,
    @idcliente int,
    @total decimal(11,2),
    @forma_pago varchar(50),
    @cuota varchar(20),
    @moneda varchar(20),
    @detalle type_detalle_venta READONLY
AS
BEGIN
    INSERT INTO venta (
        idusuario,
        idcliente,
        fecha,
        forma_pago,
        cuota,
        moneda,
        total,
        estado
    )
    VALUES (
        @idusuario,
        @idcliente,
        GETDATE(),
        @forma_pago,
        @cuota,
        @moneda,
        @total,
        'Aceptado'
    );
    
    INSERT detalle_venta (idventa,idarticulo,cantidad,precio,descuento)
    SELECT @@IDENTITY,d.idarticulo,d.cantidad,d.precio,d.descuento
    FROM @detalle d;
END
GO

PRINT 'Stored procedure venta_insertar actualizado.';
GO

-- =============================================
-- 5. Actualizar stored procedure venta_listar
-- =============================================

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_listar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_listar];
GO

CREATE PROC dbo.venta_listar
AS
BEGIN
    SELECT 
        v.idventa AS ID,
        u.nombre AS Usuario,
        p.nombre AS Cliente,
        v.fecha AS Fecha,
        v.forma_pago AS Forma_Pago,
        v.cuota AS Cuota,
        v.moneda AS Moneda,
        v.total AS Total,
        v.estado AS Estado
    FROM venta v
    INNER JOIN persona p ON v.idcliente=p.idpersona
    INNER JOIN usuario u ON v.idusuario=u.idusuario
    ORDER BY v.idventa DESC;
END;
GO

PRINT 'Stored procedure venta_listar actualizado.';
GO

-- =============================================
-- 6. Actualizar stored procedure venta_buscar
-- =============================================

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_buscar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_buscar];
GO

CREATE PROC dbo.venta_buscar
@valor VARCHAR(50)
AS
BEGIN
    SELECT 
        v.idventa AS ID,
        u.nombre AS Usuario,
        p.nombre AS Cliente,
        v.fecha AS Fecha,
        v.forma_pago AS Forma_Pago,
        v.cuota AS Cuota,
        v.moneda AS Moneda,
        v.total AS Total,
        v.estado AS Estado
    FROM venta v
    INNER JOIN persona p ON v.idcliente=p.idpersona
    INNER JOIN usuario u ON v.idusuario=u.idusuario
    WHERE p.nombre LIKE '%' + @valor + '%'
    OR u.nombre LIKE '%' + @valor + '%'
    OR CAST(v.total AS VARCHAR) LIKE '%' + @valor + '%'
    ORDER BY v.idventa DESC;
END;
GO

PRINT 'Stored procedure venta_buscar actualizado.';
GO

-- =============================================
-- 7. Actualizar stored procedure venta_consulta_fechas
-- =============================================

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_consulta_fechas]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_consulta_fechas];
GO

CREATE PROC dbo.venta_consulta_fechas
@fecha_inicio DATE,
@fecha_fin DATE,
@forma_pago VARCHAR(50) = NULL,
@moneda VARCHAR(20) = NULL
AS
BEGIN
    SELECT 
        v.idventa AS ID,
        u.nombre AS Usuario,
        p.nombre AS Cliente,
        v.fecha AS Fecha,
        v.forma_pago AS Forma_Pago,
        v.cuota AS Cuota,
        v.moneda AS Moneda,
        v.total AS Total,
        v.estado AS Estado
    FROM venta v
    INNER JOIN persona p ON v.idcliente=p.idpersona
    INNER JOIN usuario u ON v.idusuario=u.idusuario
    WHERE v.fecha BETWEEN @fecha_inicio AND @fecha_fin
    AND (@forma_pago IS NULL OR v.forma_pago = @forma_pago)
    AND (@moneda IS NULL OR v.moneda = @moneda)
    ORDER BY v.idventa DESC;
END;
GO

PRINT 'Stored procedure venta_consulta_fechas actualizado.';
GO

-- =============================================
-- RESUMEN
-- =============================================
PRINT '';
PRINT '=============================================';
PRINT 'Modificación completada exitosamente.';
PRINT '=============================================';
PRINT 'Columnas eliminadas: serie_comprobante, num_comprobante, impuesto';
PRINT 'Orden final de columnas:';
PRINT '  1. idventa';
PRINT '  2. idcliente';
PRINT '  3. idusuario';
PRINT '  4. fecha';
PRINT '  5. forma_pago';
PRINT '  6. cuota';
PRINT '  7. moneda';
PRINT '  8. total';
PRINT '  9. estado';
PRINT '=============================================';
PRINT 'Stored procedures actualizados:';
PRINT '  - venta_insertar';
PRINT '  - venta_listar';
PRINT '  - venta_buscar';
PRINT '  - venta_consulta_fechas';
PRINT '=============================================';

