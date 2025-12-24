-- Script para actualizar el stored procedure venta_insertar
-- EJECUTAR ESTE SCRIPT EN LA BASE DE DATOS

-- Primero, asegurarse de que las columnas existen en la tabla
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[venta]') AND name = 'forma_pago')
BEGIN
    ALTER TABLE [dbo].[venta] ADD [forma_pago] VARCHAR(50) NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[venta]') AND name = 'cuota')
BEGIN
    ALTER TABLE [dbo].[venta] ADD [cuota] VARCHAR(20) NULL;
END

-- Eliminar el stored procedure existente
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[venta_insertar]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[venta_insertar];
GO

-- Crear el stored procedure actualizado
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

PRINT 'Stored procedure venta_insertar actualizado correctamente.';















