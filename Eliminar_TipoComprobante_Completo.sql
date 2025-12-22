-- Script completo para eliminar tipo_comprobante de la base de datos
-- EJECUTAR ESTE SCRIPT EN LA BASE DE DATOS
-- ADVERTENCIA: Este script modificará las tablas y stored procedures

-- =============================================
-- 1. Modificar tabla venta para permitir NULL en tipo_comprobante
-- =============================================
-- Primero hacemos la columna NULL para poder eliminar la restricción
ALTER TABLE [dbo].[venta]
ALTER COLUMN [tipo_comprobante] VARCHAR(20) NULL;
GO

-- =============================================
-- 2. Modificar tabla ingreso para permitir NULL en tipo_comprobante
-- =============================================
ALTER TABLE [dbo].[ingreso]
ALTER COLUMN [tipo_comprobante] VARCHAR(20) NULL;
GO

-- =============================================
-- 3. Actualizar stored procedure venta_insertar
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_insertar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_insertar];
GO

CREATE PROCEDURE [dbo].[venta_insertar]
    @idusuario int,
    @idcliente int,
    @serie_comprobante varchar(7),
    @num_comprobante varchar(10),
    @impuesto decimal(4,2),
    @total decimal(11,2),
    @forma_pago varchar(50),
    @cuota varchar(20),
    @moneda varchar(20),
    @detalle type_detalle_venta READONLY
AS
BEGIN
    INSERT INTO venta (idusuario,idcliente,serie_comprobante,
    num_comprobante,fecha,impuesto,total,estado,forma_pago,cuota,moneda)
    VALUES (@idusuario,@idcliente,@serie_comprobante,
    @num_comprobante,GETDATE(),@impuesto,@total,'Aceptado',@forma_pago,@cuota,@moneda);
    
    INSERT detalle_venta (idventa,idarticulo,cantidad,precio,descuento)
    SELECT @@IDENTITY,d.idarticulo,d.cantidad,d.precio,d.descuento
    FROM @detalle d;
END
GO

-- =============================================
-- 4. Actualizar stored procedure ingreso_insertar
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ingreso_insertar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[ingreso_insertar];
GO

CREATE PROC dbo.ingreso_insertar
    @idusuario         INT,
    @idproveedor       INT,
    @serie_comprobante VARCHAR(7),
    @num_comprobante   VARCHAR(10),
    @impuesto          DECIMAL(4,2),
    @total             DECIMAL(11,2),
    @detalle           dbo.types_detalle_ingreso READONLY
AS
BEGIN
    -- Insertamos cabecera
    INSERT INTO ingreso (idproveedor,idusuario,serie_comprobante,
                         num_comprobante,fecha,impuesto,total,estado)
    VALUES(@idproveedor,@idusuario,@serie_comprobante,
           @num_comprobante,GETDATE(),@impuesto,@total,'Aceptado');

    -- Insertamos detalles
    INSERT INTO detalle_ingreso (idingreso,idarticulo,cantidad,precio)
    SELECT @@IDENTITY, d.idarticulo, d.cantidad, d.precio
    FROM   @detalle d;
END;
GO

-- =============================================
-- 5. Actualizar stored procedures de listado para no mostrar tipo_comprobante
-- =============================================
-- venta_listar
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_listar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_listar];
GO

CREATE PROC dbo.venta_listar
AS
BEGIN
    SELECT v.idventa AS ID,v.idusuario,v.idcliente,
    p.nombre AS Cliente,u.nombre AS Usuario,
    v.serie_comprobante AS Serie,
    v.num_comprobante AS Numero,v.fecha AS Fecha,
    v.impuesto AS Impuesto,v.total AS Total,
    v.estado AS Estado,v.forma_pago AS Forma_Pago,
    v.cuota AS Cuota,v.moneda AS Moneda
    FROM venta v
    INNER JOIN persona p ON v.idcliente=p.idpersona
    INNER JOIN usuario u ON v.idusuario=u.idusuario
    ORDER BY v.idventa DESC;
END;
GO

-- venta_buscar
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_buscar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_buscar];
GO

CREATE PROC dbo.venta_buscar
@valor VARCHAR(50)
AS
BEGIN
    SELECT v.idventa AS ID,v.idusuario,v.idcliente,
    p.nombre AS Cliente,u.nombre AS Usuario,
    v.serie_comprobante AS Serie,
    v.num_comprobante AS Numero,v.fecha AS Fecha,
    v.impuesto AS Impuesto,v.total AS Total,
    v.estado AS Estado,v.forma_pago AS Forma_Pago,
    v.cuota AS Cuota,v.moneda AS Moneda
    FROM venta v
    INNER JOIN persona p ON v.idcliente=p.idpersona
    INNER JOIN usuario u ON v.idusuario=u.idusuario
    WHERE v.num_comprobante LIKE '%' + @valor + '%'
    OR p.nombre LIKE '%' + @valor + '%'
    OR u.nombre LIKE '%' + @valor + '%'
    ORDER BY v.idventa DESC;
END;
GO

-- venta_consulta_fechas
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
    SELECT v.idventa AS ID,v.idusuario,v.idcliente,
    p.nombre AS Cliente,u.nombre AS Usuario,
    v.serie_comprobante AS Serie,
    v.num_comprobante AS Numero,v.fecha AS Fecha,
    v.impuesto AS Impuesto,v.total AS Total,
    v.estado AS Estado,v.forma_pago AS Forma_Pago,
    v.cuota AS Cuota,v.moneda AS Moneda
    FROM venta v
    INNER JOIN persona p ON v.idcliente=p.idpersona
    INNER JOIN usuario u ON v.idusuario=u.idusuario
    WHERE v.fecha BETWEEN @fecha_inicio AND @fecha_fin
    AND (@forma_pago IS NULL OR v.forma_pago = @forma_pago)
    AND (@moneda IS NULL OR v.moneda = @moneda)
    ORDER BY v.idventa DESC;
END;
GO

-- ingreso_listar
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ingreso_listar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[ingreso_listar];
GO

CREATE PROC dbo.ingreso_listar
AS
BEGIN
    SELECT i.idingreso AS ID,i.idproveedor,i.idusuario,
    p.nombre AS Proveedor,u.nombre AS Usuario,
    i.serie_comprobante AS Serie,
    i.num_comprobante AS Numero,i.fecha AS Fecha,
    i.impuesto AS Impuesto,i.total AS Total,
    i.estado AS Estado
    FROM ingreso i
    INNER JOIN persona p ON i.idproveedor=p.idpersona
    INNER JOIN usuario u ON i.idusuario=u.idusuario
    ORDER BY i.idingreso DESC;
END;
GO

-- ingreso_buscar
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ingreso_buscar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[ingreso_buscar];
GO

CREATE PROC dbo.ingreso_buscar
@valor VARCHAR(50)
AS
BEGIN
    SELECT i.idingreso AS ID,i.idproveedor,i.idusuario,
    p.nombre AS Proveedor,u.nombre AS Usuario,
    i.serie_comprobante AS Serie,
    i.num_comprobante AS Numero,i.fecha AS Fecha,
    i.impuesto AS Impuesto,i.total AS Total,
    i.estado AS Estado
    FROM ingreso i
    INNER JOIN persona p ON i.idproveedor=p.idpersona
    INNER JOIN usuario u ON i.idusuario=u.idusuario
    WHERE i.num_comprobante LIKE '%' + @valor + '%'
    OR p.nombre LIKE '%' + @valor + '%'
    OR u.nombre LIKE '%' + @valor + '%'
    ORDER BY i.idingreso DESC;
END;
GO

-- =============================================
-- 6. Actualizar stored procedure venta_comprobante (para reportes)
-- =============================================
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_comprobante]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_comprobante];
GO

CREATE PROC dbo.venta_comprobante
@idventa int
AS
BEGIN
    SELECT p.nombre AS Cliente,p.direccion,p.telefono,p.email,
    u.nombre AS Usuario,v.serie_comprobante,v.num_comprobante,
    v.fecha,v.impuesto,v.total,
    a.nombre AS articulo,d.cantidad,d.precio,d.descuento,
    ((d.cantidad*d.precio)-d.descuento) AS importe
    FROM venta v 
    INNER JOIN persona p ON v.idcliente=p.idpersona
    INNER JOIN usuario u ON v.idusuario=u.idusuario
    INNER JOIN detalle_venta d ON v.idventa=d.idventa
    INNER JOIN articulo a ON d.idarticulo=a.idarticulo
    WHERE v.idventa=@idventa;
END;
GO

PRINT 'Script ejecutado correctamente.';
PRINT 'Se modificaron las tablas para permitir NULL en tipo_comprobante.';
PRINT 'Se actualizaron todos los stored procedures para eliminar tipo_comprobante.';
PRINT 'Se actualizó venta_comprobante (usado para reportes).';
PRINT '';
PRINT 'NOTA IMPORTANTE: El reporte RptComprobanteVenta.rdlc también usa tipo_comprobante.';
PRINT 'Necesitarás actualizar el reporte manualmente para eliminar la referencia a tipo_comprobante.';
PRINT '';
PRINT 'NOTA: Si deseas eliminar completamente la columna tipo_comprobante de las tablas,';
PRINT 'ejecuta el siguiente comando después de verificar que no hay datos importantes:';
PRINT 'ALTER TABLE [dbo].[venta] DROP COLUMN [tipo_comprobante];';
PRINT 'ALTER TABLE [dbo].[ingreso] DROP COLUMN [tipo_comprobante];';

