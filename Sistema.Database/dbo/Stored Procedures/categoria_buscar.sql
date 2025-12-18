--Procedimiento Buscar
create proc categoria_buscar
@valor varchar(50)
as
select idcategoria as ID,nombre as Nombre,descripcion as Descripcion,estado as Estado
from categoria
where nombre like '%' + @valor + '%' Or descripcion like '%' + @valor + '%'
order by nombre asc
