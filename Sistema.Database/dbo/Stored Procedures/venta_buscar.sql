CREATE PROC dbo.venta_buscar
@valor VARCHAR(50)
AS
BEGIN
    SELECT 
        v.idventa AS ID,
        u.nombre AS Usuario,
        p.nombre AS Cliente,
        v.fecha AS Fecha,
        v.forma_pago AS Forma_Pago,
        v.cuota AS Cuota,
        v.moneda AS Moneda,
        v.total AS Total,
        v.estado AS Estado
    FROM venta v
    INNER JOIN persona p ON v.idcliente=p.idpersona
    INNER JOIN usuario u ON v.idusuario=u.idusuario
    WHERE p.nombre LIKE '%' + @valor + '%'
    OR u.nombre LIKE '%' + @valor + '%'
    OR CAST(v.total AS VARCHAR) LIKE '%' + @valor + '%'
    ORDER BY v.idventa DESC;
END;