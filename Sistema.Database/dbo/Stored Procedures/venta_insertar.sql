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
