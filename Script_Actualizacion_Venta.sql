-- Script para agregar campos forma_pago y cuota a la tabla venta
-- Ejecutar este script en la base de datos antes de usar la aplicación

-- 1. Agregar columnas a la tabla venta
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[venta]') AND name = 'forma_pago')
BEGIN
    ALTER TABLE [dbo].[venta]
    ADD [forma_pago] VARCHAR(50) NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[venta]') AND name = 'cuota')
BEGIN
    ALTER TABLE [dbo].[venta]
    ADD [cuota] VARCHAR(20) NULL;
END

-- 2. Actualizar stored procedure venta_insertar
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_insertar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_insertar];
GO

CREATE PROCEDURE [dbo].[venta_insertar]
    @idusuario int,
    @idcliente int,
    @tipo_comprobante varchar(20),
    @serie_comprobante varchar(7),
    @num_comprobante varchar(10),
    @impuesto decimal(4,2),
    @total decimal(11,2),
    @forma_pago varchar(50),
    @cuota varchar(20),
    @detalle type_detalle_venta READONLY
AS
BEGIN
    INSERT INTO venta (idusuario,idcliente,tipo_comprobante,serie_comprobante,
    num_comprobante,fecha,impuesto,total,estado,forma_pago,cuota)
    VALUES (@idusuario,@idcliente,@tipo_comprobante,@serie_comprobante,
    @num_comprobante,GETDATE(),@impuesto,@total,'Aceptado',@forma_pago,@cuota);
    
    INSERT detalle_venta (idventa,idarticulo,cantidad,precio,descuento)
    SELECT @@IDENTITY,d.idarticulo,d.cantidad,d.precio,d.descuento
    FROM @detalle d;
END
GO

-- 3. Actualizar stored procedure venta_listar
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_listar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_listar];
GO

CREATE PROCEDURE [dbo].[venta_listar]
AS
SELECT v.idventa AS ID,v.idusuario,u.nombre AS Usuario,p.nombre AS Cliente,
v.tipo_comprobante AS Tipo_Comprobante,v.serie_comprobante AS Serie,
v.num_comprobante AS Numero,v.fecha AS Fecha,v.impuesto AS Impuesto,
v.total AS Total,v.estado AS Estado,v.forma_pago AS Forma_Pago,v.cuota AS Cuota
FROM venta v INNER JOIN usuario u ON v.idusuario=u.idusuario
INNER JOIN persona p ON v.idcliente=p.idpersona
ORDER BY v.idventa DESC
GO

-- 4. Actualizar stored procedure venta_buscar
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_buscar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_buscar];
GO

CREATE PROCEDURE [dbo].[venta_buscar]
    @valor varchar(50)
AS
SELECT v.idventa AS ID,v.idusuario,u.nombre AS Usuario,p.nombre AS Cliente,
v.tipo_comprobante AS Tipo_Comprobante,v.serie_comprobante AS Serie,
v.num_comprobante AS Numero,v.fecha AS Fecha,v.impuesto AS Impuesto,
v.total AS Total,v.estado AS Estado,v.forma_pago AS Forma_Pago,v.cuota AS Cuota
FROM venta v INNER JOIN usuario u ON v.idusuario=u.idusuario
INNER JOIN persona p ON v.idcliente=p.idpersona
WHERE v.num_comprobante LIKE '%' + @valor + '%' OR p.nombre LIKE '%' + @valor + '%'
ORDER BY v.fecha ASC
GO

-- 5. Actualizar stored procedure venta_consulta_fechas
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_consulta_fechas]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_consulta_fechas];
GO

CREATE PROCEDURE [dbo].[venta_consulta_fechas]
    @fecha_inicio date,
    @fecha_fin date
AS
SELECT v.idventa AS ID,v.idusuario,u.nombre AS Usuario,p.nombre AS Cliente,
v.tipo_comprobante AS Tipo_Comprobante,v.serie_comprobante AS Serie,
v.num_comprobante AS Numero,v.fecha AS Fecha,v.impuesto AS Impuesto,
v.total AS Total,v.estado AS Estado,v.forma_pago AS Forma_Pago,v.cuota AS Cuota
FROM venta v INNER JOIN usuario u ON v.idusuario=u.idusuario
INNER JOIN persona p ON v.idcliente=p.idpersona
WHERE v.fecha>=@fecha_inicio AND v.fecha<=@fecha_fin
ORDER BY v.idventa DESC
GO

PRINT 'Actualización completada exitosamente. Los campos forma_pago y cuota han sido agregados a la tabla venta y los stored procedures han sido actualizados.';





