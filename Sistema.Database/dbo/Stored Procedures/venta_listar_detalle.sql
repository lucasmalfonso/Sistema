CREATE PROCEDURE [dbo].[venta_listar_detalle]
    @idventa int
AS
BEGIN
    -- Artículos primero, luego servicios, ordenados por nombre
    SELECT d.idarticulo as ID, a.nombre as ARTICULO,
           d.cantidad as CANTIDAD, d.precio as PRECIO, d.descuento as DESCUENTO,
           ((d.cantidad*d.precio)-d.descuento) as IMPORTE,
           0 as TIPO  -- 0 = Artículo
    FROM detalle_venta d 
    INNER JOIN articulo a ON d.idarticulo = a.idarticulo
    WHERE d.idventa = @idventa AND d.idarticulo IS NOT NULL
    
    UNION ALL
    
    -- Servicios
    SELECT d.idservicio as ID, s.nombre as ARTICULO,
           d.cantidad as CANTIDAD, d.precio as PRECIO, d.descuento as DESCUENTO,
           ((d.cantidad*d.precio)-d.descuento) as IMPORTE,
           1 as TIPO  -- 1 = Servicio
    FROM detalle_venta d 
    INNER JOIN servicio s ON d.idservicio = s.idservicio
    WHERE d.idventa = @idventa AND d.idservicio IS NOT NULL
    
    ORDER BY TIPO, ARTICULO;  -- Primero artículos, luego servicios, ordenados por nombre
END