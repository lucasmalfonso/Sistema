--Procedimiento Listar
create proc servicio_listar
as
select a.idservicio as ID,a.idcategoria,c.nombre as Categoria,a.nombre as Nombre,a.precio_venta as Precio_Venta,a.descripcion as Descripcion,a.imagen as Imagen,
a.estado as Estado
from servicio a inner join categoria c on a.idcategoria=c.idcategoria
order by a.idservicio desc













