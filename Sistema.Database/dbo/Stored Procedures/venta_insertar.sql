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