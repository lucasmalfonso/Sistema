create proc venta_listar_detalle
@idventa int
as
select d.idarticulo as ID, a.nombre as ARTICULO,
d.cantidad as CANTIDAD,d.precio as PRECIO,d.descuento as DESCUENTO,
((d.cantidad*d.precio)-d.descuento) as IMPORTE
from detalle_venta d inner join articulo a on d.idarticulo=a.idarticulo
where d.idventa=@idventa
