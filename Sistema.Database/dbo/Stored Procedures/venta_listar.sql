   CREATE PROCEDURE [dbo].[venta_listar]
   AS
   SELECT v.idventa AS ID,v.idusuario,u.nombre AS Usuario,p.nombre AS Cliente,
   v.tipo_comprobante AS Tipo_Comprobante,v.serie_comprobante AS Serie,
   v.num_comprobante AS Numero,v.fecha AS Fecha,v.impuesto AS Impuesto,v.forma_pago AS Forma_Pago,v.cuota AS Cuota,v.moneda AS Moneda,
   v.total AS Total,v.estado AS Estado
   FROM venta v INNER JOIN usuario u ON v.idusuario=u.idusuario
   INNER JOIN persona p ON v.idcliente=p.idpersona
   ORDER BY v.idventa DESC