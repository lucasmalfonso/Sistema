CREATE proc [dbo].[venta_anular]
@idventa int
as
update venta set estado='Anulado'
where idventa=@idventa
update articulo 
set stock=stock+d.cantidad
from articulo a
inner join
(select idarticulo,cantidad from detalle_venta where idventa=@idventa) as d
on a.idarticulo=d.idarticulo;