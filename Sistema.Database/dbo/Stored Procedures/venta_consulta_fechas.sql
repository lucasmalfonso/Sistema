create proc venta_consulta_fechas
@fecha_inicio date,
@fecha_fin date
as
select v.idventa as ID,v.idusuario,u.nombre as Usuario,p.nombre as Cliente,
v.tipo_comprobante as Tipo_Comprobante,v.serie_comprobante as Serie,
v.num_comprobante as Numero,v.fecha as Fecha,v.impuesto as Impuesto,
v.total as Total,v.estado as Estado
from venta v inner join usuario u on v.idusuario=u.idusuario
inner join persona p on v.idcliente=p.idpersona
where v.fecha>=@fecha_inicio and v.fecha<=@fecha_fin
Order by v.idventa desc