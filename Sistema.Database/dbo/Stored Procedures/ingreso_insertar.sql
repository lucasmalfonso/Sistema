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