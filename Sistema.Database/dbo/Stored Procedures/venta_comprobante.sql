create proc venta_comprobante
@idventa int
as
select p.nombre as Cliente,p.direccion,p.telefono,p.email,
u.nombre as Usuario,v.tipo_comprobante,v.serie_comprobante,v.num_comprobante,
v.fecha,v.impuesto,v.total,
a.nombre as articulo,d.cantidad,d.precio,d.descuento,
((d.cantidad*d.precio)-d.descuento) as importe
from venta v inner join persona p on v.idcliente=p.idpersona
inner join usuario u on v.idusuario=u.idusuario
inner join detalle_venta d on v.idventa=d.idventa
inner join articulo a on d.idarticulo=a.idarticulo
where v.idventa=@idventa
