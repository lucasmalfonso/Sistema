
CREATE PROC [dbo].[articulo_listar]
AS
BEGIN
    SELECT  
        a.idarticulo  AS ID,
        a.idcategoria,
        c.nombre      AS Categoria,
        -- a.codigo   AS Codigo,   -- 👈 ELIMINADO
        a.nombre      AS Nombre,
        a.precio_venta AS Precio_Venta,
        a.stock       AS Stock,
        a.descripcion AS Descripcion,
        a.imagen      AS Imagen,
        a.estado      AS Estado
    FROM articulo a 
    INNER JOIN categoria c ON a.idcategoria = c.idcategoria
    ORDER BY a.idarticulo DESC;
END
