CREATE PROC dbo.ingreso_buscar
@valor VARCHAR(50)
AS
BEGIN
    SELECT i.idingreso AS ID,i.idproveedor,i.idusuario,
    p.nombre AS Proveedor,u.nombre AS Usuario,
    i.serie_comprobante AS Serie,
    i.num_comprobante AS Numero,i.fecha AS Fecha,
    i.impuesto AS Impuesto,i.total AS Total,
    i.estado AS Estado
    FROM ingreso i
    INNER JOIN persona p ON i.idproveedor=p.idpersona
    INNER JOIN usuario u ON i.idusuario=u.idusuario
    WHERE i.num_comprobante LIKE '%' + @valor + '%'
    OR p.nombre LIKE '%' + @valor + '%'
    OR u.nombre LIKE '%' + @valor + '%'
    ORDER BY i.idingreso DESC;
END;