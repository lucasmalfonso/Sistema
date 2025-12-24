CREATE PROC dbo.ingreso_insertar
    @idusuario         INT,
    @idproveedor       INT,
    @total             DECIMAL(11,2),
    @detalle           dbo.types_detalle_ingreso READONLY
AS
BEGIN
    -- Insertamos cabecera
    INSERT INTO ingreso (idproveedor,idusuario,fecha,total,estado)
    VALUES(@idproveedor,@idusuario,GETDATE(),@total,'Aceptado');

    -- Insertamos detalles
    INSERT INTO detalle_ingreso (idingreso,idarticulo,cantidad,precio)
    SELECT @@IDENTITY, d.idarticulo, d.cantidad, d.precio
    FROM   @detalle d;
END;