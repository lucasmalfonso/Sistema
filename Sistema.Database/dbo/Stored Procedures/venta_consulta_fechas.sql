CREATE PROC dbo.venta_consulta_fechas
@fecha_inicio DATE,
@fecha_fin DATE,
@forma_pago VARCHAR(50) = NULL,
@moneda VARCHAR(20) = NULL
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
    WHERE v.fecha BETWEEN @fecha_inicio AND @fecha_fin
    AND (@forma_pago IS NULL OR v.forma_pago = @forma_pago)
    AND (@moneda IS NULL OR v.moneda = @moneda)
    ORDER BY v.idventa DESC;
END;