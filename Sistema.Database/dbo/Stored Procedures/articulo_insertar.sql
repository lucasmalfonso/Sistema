CREATE PROC articulo_insertar
 @idcategoria INT,
 @nombre VARCHAR(100),
 @precio_venta DECIMAL(11,2),
 @stock INT,
 @descripcion VARCHAR(255),
 @imagen VARCHAR(20)
AS
INSERT INTO articulo (idcategoria,nombre,precio_venta,stock,descripcion,imagen)
VALUES (@idcategoria,@nombre,@precio_venta,@stock,@descripcion,@imagen)
