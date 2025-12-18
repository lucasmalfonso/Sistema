create proc ingreso_listar_detalle
@idingreso int
as
select d.idarticulo as ID,a.nombre as ARTICULO,
d.cantidad as CANTIDAD,d.precio as PRECIO,(d.precio*d.cantidad) as IMPORTE
from detalle_ingreso d inner join articulo a on d.idarticulo=a.idarticulo
where d.idingreso=@idingreso
