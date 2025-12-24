-- Script para eliminar tipo_comprobante de los stored procedures
-- EJECUTAR ESTE SCRIPT EN LA BASE DE DATOS

-- =============================================
-- 1. Actualizar stored procedure venta_insertar
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
-- 2. Actualizar stored procedure ingreso_insertar
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

PRINT 'Stored procedures actualizados correctamente. Se eliminó el parámetro tipo_comprobante.';
PRINT 'NOTA: Si la columna tipo_comprobante es NOT NULL en las tablas, necesitarás modificarla primero o usar un valor por defecto.';











