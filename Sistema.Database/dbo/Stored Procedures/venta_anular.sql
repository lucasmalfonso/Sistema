CREATE PROCEDURE [dbo].[venta_anular]
    @idventa int
AS
BEGIN
    UPDATE venta 
    SET estado = 'Anulado'
    WHERE idventa = @idventa;
    
    -- Solo actualizar stock de artículos, no de servicios
    UPDATE articulo 
    SET stock = stock + d.cantidad
    FROM articulo a
    INNER JOIN (
        SELECT idarticulo, cantidad 
        FROM detalle_venta 
        WHERE idventa = @idventa AND idarticulo IS NOT NULL
    ) AS d ON a.idarticulo = d.idarticulo;
END