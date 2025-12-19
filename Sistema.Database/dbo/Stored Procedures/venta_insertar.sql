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