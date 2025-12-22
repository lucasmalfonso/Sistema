-- Script para eliminar @serie_comprobante, @num_comprobante y @impuesto del stored procedure venta_insertar
-- EJECUTAR ESTE SCRIPT EN LA BASE DE DATOS

USE [dbsistemaprod]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Actualizar stored procedure venta_insertar
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
    INSERT INTO venta (idusuario,idcliente,
    fecha,total,estado,forma_pago,cuota,moneda)
    VALUES (@idusuario,@idcliente,
    GETDATE(),@total,'Aceptado',@forma_pago,@cuota,@moneda);
    
    INSERT detalle_venta (idventa,idarticulo,cantidad,precio,descuento)
    SELECT @@IDENTITY,d.idarticulo,d.cantidad,d.precio,d.descuento
    FROM @detalle d;
END
GO

PRINT 'Stored procedure venta_insertar actualizado correctamente.';
PRINT 'Se eliminaron los parámetros: @serie_comprobante, @num_comprobante y @impuesto.';

