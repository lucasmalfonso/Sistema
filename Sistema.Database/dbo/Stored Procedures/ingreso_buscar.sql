--Procedimiento buscar
create proc ingreso_buscar
@valor varchar(50)
as
select i.idingreso as ID, i.idusuario,u.nombre as Usuario,p.nombre as Proveedor,
i.tipo_comprobante as Tipo_Comprobante,i.serie_comprobante as Serie,
i.num_comprobante as Numero,i.fecha as Fecha,i.impuesto as Impuesto,
i.total as Total,i.estado as Estado
from ingreso i inner join usuario u on i.idusuario=u.idusuario
inner join persona p on i.idproveedor=p.idpersona
where i.num_comprobante like '%' +@valor + '%' Or p.nombre like '%' +@valor + '%' 
order by i.fecha asc
