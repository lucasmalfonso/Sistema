-- =============================================
-- Script de Migración: Soporte de Servicios en Ventas
-- =============================================
-- Este script modifica la estructura de la base de datos
-- para permitir que las ventas incluyan tanto artículos como servicios
-- =============================================

USE [dbsistemaprod]  -- Cambiar por el nombre de tu base de datos
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

PRINT '========================================';
PRINT 'Iniciando migración para soporte de servicios en ventas...';
PRINT '========================================';
GO

-- =============================================
-- Paso 1: Eliminar el trigger existente
-- =============================================
IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'Venta_ActualizarStock')
BEGIN
    DROP TRIGGER [dbo].[Venta_ActualizarStock];
    PRINT 'Trigger Venta_ActualizarStock eliminado.';
END
GO

-- =============================================
-- Paso 2: Eliminar la foreign key existente en detalle_venta
-- =============================================
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_detalle_venta_articulo')
BEGIN
    ALTER TABLE [dbo].[detalle_venta] DROP CONSTRAINT [FK_detalle_venta_articulo];
    PRINT 'Foreign key FK_detalle_venta_articulo eliminada.';
END
GO

-- =============================================
-- Paso 3: Modificar la tabla detalle_venta
-- =============================================
-- Hacer idarticulo nullable
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[detalle_venta]') AND name = 'idarticulo' AND is_nullable = 0)
BEGIN
    ALTER TABLE [dbo].[detalle_venta] ALTER COLUMN [idarticulo] INT NULL;
    PRINT 'Columna idarticulo modificada a NULL.';
END
GO

-- Agregar columna idservicio si no existe
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[detalle_venta]') AND name = 'idservicio')
BEGIN
    ALTER TABLE [dbo].[detalle_venta] ADD [idservicio] INT NULL;
    PRINT 'Columna idservicio agregada.';
END
GO

-- Agregar foreign key para servicio
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_detalle_venta_servicio')
BEGIN
    ALTER TABLE [dbo].[detalle_venta]
    ADD CONSTRAINT [FK_detalle_venta_servicio] 
    FOREIGN KEY ([idservicio]) REFERENCES [dbo].[servicio] ([idservicio]);
    PRINT 'Foreign key FK_detalle_venta_servicio agregada.';
END
GO

-- Restaurar foreign key para articulo (ahora nullable)
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_detalle_venta_articulo')
BEGIN
    ALTER TABLE [dbo].[detalle_venta]
    ADD CONSTRAINT [FK_detalle_venta_articulo] 
    FOREIGN KEY ([idarticulo]) REFERENCES [dbo].[articulo] ([idarticulo]);
    PRINT 'Foreign key FK_detalle_venta_articulo restaurada.';
END
GO

-- Agregar CHECK constraint para asegurar que solo uno tenga valor
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_detalle_venta_articulo_servicio')
BEGIN
    ALTER TABLE [dbo].[detalle_venta]
    ADD CONSTRAINT [CK_detalle_venta_articulo_servicio]
    CHECK (([idarticulo] IS NOT NULL AND [idservicio] IS NULL) OR ([idarticulo] IS NULL AND [idservicio] IS NOT NULL));
    PRINT 'CHECK constraint CK_detalle_venta_articulo_servicio agregado.';
END
GO

-- =============================================
-- Paso 4: Recrear el trigger actualizado
-- =============================================
CREATE TRIGGER [dbo].[Venta_ActualizarStock]
   ON [dbo].[detalle_venta]
   FOR INSERT
   AS
   UPDATE a SET a.stock=a.stock-d.cantidad
   FROM articulo AS a INNER JOIN
   INSERTED AS d ON d.idarticulo=a.idarticulo
   WHERE d.idarticulo IS NOT NULL;
GO
PRINT 'Trigger Venta_ActualizarStock recreado (solo actualiza stock de artículos).';
GO

-- =============================================
-- Paso 5: Actualizar el tipo type_detalle_venta
-- =============================================
-- Primero eliminar el tipo si existe
IF EXISTS (SELECT * FROM sys.types WHERE name = 'type_detalle_venta')
BEGIN
    -- Eliminar dependencias primero
    IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'venta_insertar')
    BEGIN
        DROP PROCEDURE [dbo].[venta_insertar];
        PRINT 'Stored procedure venta_insertar eliminado temporalmente.';
    END
    GO
    
    DROP TYPE [dbo].[type_detalle_venta];
    PRINT 'Tipo type_detalle_venta eliminado.';
END
GO

-- Crear el tipo actualizado
CREATE TYPE [dbo].[type_detalle_venta] AS TABLE (
    [idarticulo] INT             NULL,
    [idservicio]  INT             NULL,
    [articulo]   VARCHAR (100)   NULL,
    [stock]      INT             NULL,
    [cantidad]   INT             NULL,
    [precio]     DECIMAL (11, 2) NULL,
    [descuento]  DECIMAL (11, 2) NULL,
    [importe]    DECIMAL (11, 2) NULL);
GO
PRINT 'Tipo type_detalle_venta recreado con soporte para servicios.';
GO

-- =============================================
-- Paso 6: Actualizar stored procedure venta_insertar
-- =============================================
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
    DECLARE @idventa int;
    
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
    
    SET @idventa = SCOPE_IDENTITY();
    
    -- Insertar artículos
    INSERT detalle_venta (idventa,idarticulo,idservicio,cantidad,precio,descuento)
    SELECT @idventa, d.idarticulo, NULL, d.cantidad, d.precio, d.descuento
    FROM @detalle d
    WHERE d.idarticulo IS NOT NULL;
    
    -- Insertar servicios
    INSERT detalle_venta (idventa,idarticulo,idservicio,cantidad,precio,descuento)
    SELECT @idventa, NULL, d.idservicio, d.cantidad, d.precio, d.descuento
    FROM @detalle d
    WHERE d.idservicio IS NOT NULL;
END
GO
PRINT 'Stored procedure venta_insertar actualizado.';
GO

-- =============================================
-- Paso 7: Actualizar stored procedure venta_listar_detalle
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_listar_detalle]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_listar_detalle];
GO

CREATE PROCEDURE [dbo].[venta_listar_detalle]
    @idventa int
AS
BEGIN
    -- Artículos
    SELECT d.idarticulo as ID, a.nombre as ARTICULO,
           d.cantidad as CANTIDAD, d.precio as PRECIO, d.descuento as DESCUENTO,
           ((d.cantidad*d.precio)-d.descuento) as IMPORTE
    FROM detalle_venta d 
    INNER JOIN articulo a ON d.idarticulo = a.idarticulo
    WHERE d.idventa = @idventa AND d.idarticulo IS NOT NULL
    
    UNION ALL
    
    -- Servicios
    SELECT d.idservicio as ID, s.nombre as ARTICULO,
           d.cantidad as CANTIDAD, d.precio as PRECIO, d.descuento as DESCUENTO,
           ((d.cantidad*d.precio)-d.descuento) as IMPORTE
    FROM detalle_venta d 
    INNER JOIN servicio s ON d.idservicio = s.idservicio
    WHERE d.idventa = @idventa AND d.idservicio IS NOT NULL
    
    ORDER BY ID;
END
GO
PRINT 'Stored procedure venta_listar_detalle actualizado.';
GO

-- =============================================
-- Paso 8: Actualizar stored procedure venta_anular
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_anular]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_anular];
GO

CREATE PROCEDURE [dbo].[venta_anular]
    @idventa int
AS
BEGIN
    UPDATE venta 
    SET estado = 'Anulado'
    WHERE idventa = @idventa;
    
    -- Solo actualizar stock de artículos, no de servicios
    UPDATE articulo 
    SET stock = stock + d.cantidad
    FROM articulo a
    INNER JOIN (
        SELECT idarticulo, cantidad 
        FROM detalle_venta 
        WHERE idventa = @idventa AND idarticulo IS NOT NULL
    ) AS d ON a.idarticulo = d.idarticulo;
END
GO
PRINT 'Stored procedure venta_anular actualizado.';
GO

-- =============================================
-- Verificación final
-- =============================================
PRINT '';
PRINT '========================================';
PRINT 'Migración completada exitosamente!';
PRINT '========================================';
PRINT '';
PRINT 'Cambios aplicados:';
PRINT '  ✓ Tabla detalle_venta modificada (idservicio agregado, idarticulo nullable)';
PRINT '  ✓ Tipo type_detalle_venta actualizado';
PRINT '  ✓ Stored procedure venta_insertar actualizado';
PRINT '  ✓ Stored procedure venta_listar_detalle actualizado';
PRINT '  ✓ Stored procedure venta_anular actualizado';
PRINT '  ✓ Trigger Venta_ActualizarStock actualizado';
PRINT '';
PRINT 'El sistema ahora soporta servicios en las ventas.';
PRINT '========================================';
GO








