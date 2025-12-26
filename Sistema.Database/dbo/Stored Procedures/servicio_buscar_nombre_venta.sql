--Procedimiento Buscar Nombre Venta
create proc servicio_buscar_nombre_venta
@valor varchar(50)
as
select idservicio,nombre,precio_venta
from servicio
where nombre=@valor and estado=1












