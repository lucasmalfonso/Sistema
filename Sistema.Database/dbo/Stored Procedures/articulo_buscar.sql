
CREATE PROC dbo.articulo_buscar
    @valor VARCHAR(50)
AS
BEGIN
    SELECT 
        a.idarticulo   AS ID,
        a.idcategoria,
        c.nombre       AS Categoria,
        a.nombre       AS Nombre,
        a.precio_venta AS Precio_Venta,
        a.stock        AS Stock,
        a.descripcion  AS Descripcion,
        a.imagen       AS Imagen,
        a.estado       AS Estado
    FROM articulo a 
    INNER JOIN categoria c ON a.idcategoria = c.idcategoria
    WHERE a.nombre      LIKE '%' + @valor + '%'
       OR a.descripcion LIKE '%' + @valor + '%'
    ORDER BY a.nombre ASC;
END;
