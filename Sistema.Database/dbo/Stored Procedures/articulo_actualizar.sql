
CREATE PROC [dbo].[articulo_actualizar]
    @idarticulo     INT,
    @idcategoria    INT,
    @nombre         VARCHAR(50),
    @precio_venta   DECIMAL(11,2),
    @stock          INT,
    @descripcion    VARCHAR(255),
    @imagen         VARCHAR(20)
AS
BEGIN
    UPDATE articulo
    SET idcategoria   = @idcategoria,
        nombre        = @nombre,
        precio_venta  = @precio_venta,
        stock         = @stock,
        descripcion   = @descripcion,
        imagen        = @imagen
    WHERE idarticulo = @idarticulo;
END
